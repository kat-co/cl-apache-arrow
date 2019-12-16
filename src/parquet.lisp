(in-package #:parquet)

(defun write-table (writer schema field-builders batch-size)
  (let ((table (arrow-low-level:make-arrow-table-new-arrays (arrow-low-level:native-pointer schema)
                                                            field-builders)))
    (parquet-low-level:arrow-file-writer-write-table writer
                                                     (arrow-low-level:native-pointer table)
                                                     batch-size)))

(defmacro with-open-file-writer ((writer schema path) &body body)
  `(let ((,writer (parquet-low-level:make-arrow-file-writer-new-path
                   (arrow-low-level:native-pointer ,schema) ,path)))
     (unwind-protect
          ,@body
       (parquet-low-level:arrow-file-writer-close ,writer))))
