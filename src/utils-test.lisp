(defpackage cl-apache-arrow/tests/utils
  (:use :cl
        :arrow
        :rove))
(in-package :cl-apache-arrow/tests/utils)

(defclass test-class ()
  ((field-a :initarg :field-a
            :arrow-field-name "arrow-field-a"
            :arrow-type (arrow-low-level:make-string-data-type-new))
   (field-b :initarg :field-b
            :arrow-field-name "arrow-field-b"
            :arrow-type (arrow-low-level:make-int32data-type-new)))

  (:metaclass arrow:entity-class))

(let ((o (make-instance 'test-class
                        :field-a "value-a"
                        :field-b 1)))

  (deftest schema-from-object
    (testing "The correct schema is generated."
      (let ((schema (arrow:schema-from-object o)))
        (ok (string= (arrow-low-level:arrow-schema-to-string schema)
                     "arrow-field-a: string
arrow-field-b: int32"))))

    (testing "The correct field builders are generated."
      (multiple-value-bind (schema field-builders)
          (arrow:schema-from-object o)
        (let ((field-builder-types (mapcar #'type-of field-builders)))
          (ok (equalp field-builder-types
                      '(arrow-low-level:string-array-builder
                        arrow-low-level:int32array-builder)))))))

  (deftest field-list
    (testing "Prepending field-list gives expected sequence"
      (let* ((lhs-field-list (make-instance 'arrow:field-list))
             (rhs-field-list (make-instance 'arrow:field-list))
             (string-data-type (arrow-low-level:native-pointer
                                (arrow-low-level:make-string-data-type-new)))
             (a (arrow-low-level:make-field-new "a" string-data-type))
             (b (arrow-low-level:make-field-new "b" string-data-type))
             (c (arrow-low-level:make-field-new "c" string-data-type))
             (d (arrow-low-level:make-field-new "d" string-data-type)))

        (prepend-field lhs-field-list b)
        (prepend-field lhs-field-list a)

        (prepend-field rhs-field-list d)
        (prepend-field rhs-field-list c)

        (let ((new-field-list (concat lhs-field-list rhs-field-list)))
          (ok (equalp (arrow:lisp-list new-field-list)
                      (append (arrow:lisp-list lhs-field-list)
                              (arrow:lisp-list rhs-field-list))))
          (loop
            for f in (list a b c d)
            for i upto 3
            do (ok (cffi:pointer-eq
                    (arrow::g-list-nth-data (arrow:g-list new-field-list) i)
                    (gir::this-of (arrow-low-level:native-pointer f))))))))))
