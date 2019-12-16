(in-package #:arrow)

;;; CFFI

(cffi:define-foreign-library :g-lib
    (:unix (:or "libglib-2.0.so.0" "libglib-2.0.so"))
    (:windows "libglib-2.0-0.dll"))

(cffi:defctype glist-pointer :pointer)

(cffi:defcstruct g-list
  (data :pointer)
  (next :pointer)
  (prev :pointer))

(cffi:defcfun ("g_list_append" g-list-append) (:pointer (:struct g-list))
  (list (:pointer (:struct g-list)))
  (data :pointer))

(cffi:defcfun ("g_list_concat" g-list-concat) (:pointer (:struct g-list))
  (list-1 (:pointer (:struct g-list)))
  (list-2 (:pointer (:struct g-list))))

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
          (gir:invoke (native-pointer "append_value") value)
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
