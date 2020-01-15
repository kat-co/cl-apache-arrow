(in-package #:arrow)

(defclass entity-slot-definition (closer-mop:standard-direct-slot-definition)
  ((arrow-type :type class
               :initarg :arrow-type
               :accessor arrow-type
               :documentation
               "One of the Arrow Data types.")
   (arrow-field-name :type string
                     :initarg :arrow-field-name
                     :accessor arrow-field-name)))

(defclass entity-class (closer-mop:standard-class) ())

(defmethod closer-mop:validate-superclass ((class entity-class)
                                           (super closer-mop:standard-class)) t)

(defmethod closer-mop:validate-superclass ((class standard-class)
                                           (super entity-class)) t)

(defmethod closer-mop:direct-slot-definition-class ((class entity-class)
                                                    &rest initargs)
  (declare (ignore class initargs))
  (find-class 'entity-slot-definition))

(defun schema-from-object (obj &key (schema '(*)) get-field-name skip-slot-p)
  "Enumerates over the slots in a CLOS class and returns a schema
generated from its slots, and a function which, when passed an object
of the same type, will append its values to the correct field
builders."
  (check-type obj standard-object)
  (check-type schema list)
  (check-type get-field-name (or null function))
  (check-type skip-slot-p (or null function))

  (let ((clos-class-slots (remove-if
                           (lambda (s) (eq :class s))
                           (let ((class (class-of obj)))
                             (alexandria:flatten
                              (mapcar #'closer-mop:class-direct-slots
                                      (cons class (closer-mop:class-direct-superclasses class)))))
                           :key #'closer-mop:slot-definition-allocation)))

    (multiple-value-bind (schema-field-builders field-builders field-list class-slots)
        (fields-from-class (class-of obj) clos-class-slots schema)

      (let ((schema (make-arrow-schema-new (g-list field-list))))
        (values
         schema
              schema-field-builders
              (lambda (obj*)
                "Populates field builders from slots of a CLOS object."

                (labels ((iterate (slots builders)
                           (when builders
                             (let ((builder (car builders))
                                   (slot (car slots)))
                               (if (typep builder 'list-array-builder)
                                   (progn
                                     (append-value builder)
                                     (iterate slots (cdr builders)))

                                   (let ((slot-value (and (slot-boundp obj* slot)
                                                          (slot-value obj* slot))))
                                     (if slot-value
                                         (append-value builder slot-value)
                                         (append-null builder))

                                     (iterate (cdr slots) (cdr builders))))))))

             (iterate class-slots field-builders))))))))

;;; Unexported

(defun fields-from-class (class clos-class-slots schema &optional wildcard-slots)
  "Builds up a list of Arrow field builders which matches the shape of
the schema list passed in. Returns a list of field builders, a GList
of fields, and a list of class slots."
  (check-type clos-class-slots list)
  (check-type schema list)
  (check-type wildcard-slots list)

  (let* ((wildcard-slots (or wildcard-slots
                             (slot-definitions-difference clos-class-slots (alexandria:flatten schema))))
         (field-builders (list))
         (schema-field-builders (list))
         (class-slots (list))
         (fields (make-instance 'field-list)))

    (loop
      for schema-place in schema
      do (if (listp schema-place)
             ;; We are requesting a nested structure. The first item
             ;; in the list is the name of the nested structure in its
             ;; parent list.
             (multiple-value-bind (struct-field-builder field-builders* field class-slots*)
                 (nest-struct class clos-class-slots
                              (car schema-place) (cdr schema-place) wildcard-slots)

               (prepend-field fields field)
               (setf field-builders (append field-builders field-builders*)
                     schema-field-builders (append schema-field-builders (list struct-field-builder))
                     class-slots (append class-slots class-slots*)))

             (if (eq '* schema-place)
                 ;; Replace the star with all the slots not explicitly
                 ;; defined.
                 (multiple-value-bind (schema-field-builders* field-builders* fields* class-slots* lisp-fields*)
                     (fields-from-class class clos-class-slots wildcard-slots wildcard-slots)

                   (setf field-builders (append field-builders* field-builders)
                         schema-field-builders (append schema-field-builders* schema-field-builders)
                         class-slots (append class-slots* class-slots)
                         fields (concat fields* fields)))

                 ;; Otherwise add bits for the requested slot.
                 (let ((slot (find-slot-definition clos-class-slots schema-place)))

                   (unless slot
                     (error "Cannot find requested slot \"~a\" for schema in class \"~a\""
                            schema-place class))

                   (let* ((arrow-type (arrow-type-from-slot slot))
                        (field (make-field-new (arrow-field-name slot)
                                               (native-pointer arrow-type))))

                     (prepend-field fields field)
                   (setf
                    field-builders (cons (data-type-array-builder arrow-type)
                                         field-builders)
                    schema-field-builders (cons (car field-builders) schema-field-builders)
                      class-slots (cons schema-place class-slots)))))))

    (values schema-field-builders field-builders fields class-slots)))

(defun nest-struct (class clos-class-slots field-name schema w)
  (check-type clos-class-slots list)
  (check-type field-name string)
  (check-type schema list)

  (multiple-value-bind (schema-field-builders field-builders fields class-slots)
      (fields-from-class class clos-class-slots schema w)
    (declare (ignore schema-field-builders))

    (let* ((struct-type (make-struct-data-type-new fields))
           (inner-list-field (make-field-new "element" (native-pointer struct-type)))
           (inner-list-type (make-list-data-type-new (native-pointer inner-list-field)))

           (list-field (make-field-new field-name (native-pointer inner-list-type)))
           (list-builder (make-list-array-builder-new (native-pointer inner-list-type))))

      (values
       list-builder
       (cons list-builder field-builders)
       list-field
       class-slots))))

(defun slot-definitions-difference (slot-definitions exclusions)
  "Finds the slots in the object which are not in the exclusions
list."
  (check-type slot-definitions list)

  (set-difference (mapcar #'closer-mop:slot-definition-name
                          slot-definitions)
                  exclusions))

(defun find-slot-definition (slot-definitions slot-name)
  "Finds the MOP slot definition of an object with the given name."
  (check-type slot-definitions list)
  (check-type slot-name symbol)

  (find slot-name slot-definitions
        :key #'closer-mop:slot-definition-name))

(defun arrow-type-from-slot (slot)
  "Fetches the function that creates an Arrow type from the slot
definition of a CLOS object with a meta-object of entity-class."
  (check-type slot closer-mop:slot-definition)

  (let ((arrow-type-fn (arrow-type slot)))
    (apply (car arrow-type-fn) (cdr arrow-type-fn))))


(defun data-type-array-builder (data-type)
  "Returns an array builder for the given Arrow DataType."

  (typecase data-type
    (binary-data-type (make-binary-array-builder-new))
    (boolean-data-type (make-boolean-array-builder-new))
    (date32data-type (make-date32array-builder-new))
    (date64data-type (make-date64array-builder-new))
    ;;(decimal128data-type (make-decimal128array-builder-new))
    ;;(decimal-data-type)
    ;;(dense-union-data-type)
    ;;(dictionary-data-type)
    (double-data-type (make-double-array-builder-new))
    ;;(fixed-size-binary-data-type)
    (float-data-type (make-float-array-builder-new))
    (int16data-type (make-int16array-builder-new))
    (int32data-type (make-int32array-builder-new))
    (int64data-type (make-int64array-builder-new))
    (int8data-type (make-int8array-builder-new))
    ;;(list-data-type (make-list-array-builder-new))
    (null-data-type (make-null-array-builder-new))
    ;;(sparse-union-data-type)
    (string-data-type (make-string-array-builder-new))
    ;;(struct-data-type (make-struct-array-builder-new))
    ;;(time32data-type (make-time32array-builder-new))
    ;;(time64data-type (make-time64array-builder-new))
    ;;(timestamp-data-type (make-timestamp-array-builder-new))
    (uint16data-type (make-uint16array-builder-new))
    (uint32data-type (make-uint32array-builder-new))
    (uint64data-type (make-uint64array-builder-new))
    (uint8data-type (make-uint8array-builder-new))))

;; (defun arrow-data-type-from-lisp (type-specifier)
;;   "Returns an Arrow DataType from a type Lisp type specifier."

;;   (cond
;;     ((eq type-specifier 'null) (make-arrow-null-data-type-new))
;;     ;;(? (make-arrow-binary-data-type-new))
;;     ;;(? (make-arrow-date32data-type-new))
;;     ;;(? (make-arrow-date64data-type-new))
;;     ;;(? (make-arrow-decimal128data-type-new))
;;     ;;(decimal (make-arrow-decimal-data-type-new))
;;     ;;(? (make-arrow-dense-union-data-type-new))
;;     ;;(hash-table (make-arrow-dictionary-data-type-new ()))

;;     ((eq type-specifier 'boolean) (make-arrow-boolean-data-type-new))
;;     ;;(? (make-arrow-fixed-size-binary-data-type-new))

;;     ((eq type-specifier 'double-float) (make-arrow-double-data-type-new))
;;     ((eq type-specifier 'float) (make-arrow-float-data-type-new))
;;     ;;(list (make-arrow-list-data-type-new))
;;     ;;(? (make-arrow-sparse-union-data-type-new))

;;     ((eq type-specifier 'string) (make-arrow-string-data-type-new))
;;     ;; (? (make-arrow-struct-data-type-new))
;;     ;; (? (make-arrow-time32data-type-new))
;;     ;; (? (make-arrow-time64data-type-new))
;;     ;; (? (make-arrow-timestamp-data-type-new))

;;     ((equalp type-specifier '(unsigned-byte 8)) (make-arrow-uint8data-type-new))
;;     ((equalp type-specifier '(unsigned-byte 16)) (make-arrow-uint16data-type-new))
;;     ((equalp type-specifier '(unsigned-byte 32)) (make-arrow-uint32data-type-new))
;;     ((equalp type-specifier '(unsigned-byte 64)) (make-arrow-uint64data-type-new))
;;     ((equalp type-specifier '(signed-byte 8)) (make-arrow-int8data-type-new))
;;     ((equalp type-specifier '(signed-byte 16)) (make-arrow-int16data-type-new))
;;     ((equalp type-specifier '(signed-byte 32)) (make-arrow-int32data-type-new))
;;     ((equalp type-specifier '(signed-byte 64)) (make-arrow-int64data-type-new))
;;     (t (error "Cannot match type specifier \"~s\" to an Arrow type." type-specifier))))
