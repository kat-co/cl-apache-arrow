(in-package #:arrow)

;;; CFFI

(cffi:define-foreign-library :g-lib
    (:unix (:or "libglib-2.0.so.0" "libglib-2.0.so"))
    (:windows "libglib-2.0-0.dll"))

(cffi:defctype glist-pointer :pointer)

(cffi:defctype gpointer :pointer)

(cffi:defcstruct g-list
  (data :pointer)
  (next (:pointer (:struct g-list)))
  (prev (:pointer (:struct g-list))))

(cffi:defcfun ("g_list_prepend" g-list-prepend) (:pointer (:struct g-list))
  (list (:pointer (:struct g-list)))
  (data :pointer))

(cffi:defcfun ("g_list_concat" g-list-concat) (:pointer (:struct g-list))
  (list-1 (:pointer (:struct g-list)))
  (list-2 (:pointer (:struct g-list))))

(cffi:defcfun ("g_list_free" g-list-free) :void
  (mem (:pointer (:struct g-list))))

(cffi:defcfun ("g_list_nth_data" g-list-nth-data) gpointer
  (list (:pointer (:struct g-list)))
  (n :unsigned-int))

;; High level

(defmacro with-field-builders ((field-builders) &body body)
  `(progn
     (unwind-protect
          ,@body
       (setf ,field-builders (mapcar #'array-builder-finish ,field-builders)))))

(defgeneric append-value (array-builder &optional value)
  (:method ((array-builder gir-object) &optional value)
    (with-slots (native-pointer)
        array-builder
      (if value
          (if (stringp value)
              (gir:invoke (native-pointer "append_string") value)
              (gir:invoke (native-pointer "append_value") value))
          (gir:invoke (native-pointer "append_value"))))))


(defgeneric append-null (array-builder)
  (:method ((array-builder gir-object))
    (with-slots (native-pointer)
        array-builder
      (gir:invoke (native-pointer "append_null")))))

(defgeneric array-builder-finish (array-builder)
  (:method ((array-builder gir-object))
    (with-slots (native-pointer)
        array-builder
      (gir:invoke (native-pointer "finish")))))

(defclass field-list ()
  ((g-list :type cffi:foreign-pointer
           :initarg :g-list
           :initform (cffi:null-pointer)
           :accessor g-list)
   (lisp-list :type list
              :initarg :lisp-list
              :initform (list)
              :accessor lisp-list))

  (:documentation
   "It is often necessary to couple the lifetime of a g-list
   containing fields with the lifetime of the fields themselves. If
   this is not done, it is easy to end up with a g-list containing
   fields that have been garbage collected which can cause non-obvious
   bugs. This class handles building up both lists simultaneously to
   help couple their lifetimes."))

(defmethod concat ((lhs field-list) rhs)
  (check-type rhs field-list)

  (with-accessors ((lhs-g-list g-list) (lhs-list lisp-list))
      lhs
    (with-accessors ((rhs-g-list g-list) (rhs-list lisp-list))
        rhs
      (let ((new-g-list (g-list-concat lhs-g-list rhs-g-list))
            (new-list (append lhs-list rhs-list)))
        (make-instance 'field-list :g-list new-g-list
                                   :lisp-list new-list)))))

(defmethod prepend-field ((l field-list) field)
  "Prepends the given field to both the g-list and the list."
  (check-type field arrow-low-level:field)

  (with-accessors ((g-list g-list) (list lisp-list))
      l
    (setf
     g-list (g-list-prepend g-list (gir::this-of (native-pointer field)))
     list (cons field list))))

(defmethod initialize-instance :after ((l field-list) &key)
  "Sets up a finalizer for the field-list which ensures that the
underlying GList is freed when this object is garbage collected."
  ;; The purpose of the let block is so that the function being passed
  ;; into cffi:finalize doesn't close around a slot-value of
  ;; field-list. If it did, the object would never get garbage collected
  (let ((g-list (cffi:null-pointer)))
    (with-accessors ((g-list* g-list))
        l
      (setf g-list g-list*))
    (unless (cffi:null-pointer-p g-list)
      (trivial-garbage:finalize
       l
       (lambda () (g-list-free g-list))))))
