(asdf:defsystem #:cl-apache-arrow
  :description "A wrapper around Apache Arrow's C++ library."
  :author "Katherine Cox-Buday <cox.katherine.e@gmail.com>"
  :license  "Apache-2.0"
  :version "1.0.0"
  :depends-on (cl-gobject-introspection
               closer-mop
               trivial-garbage)
  :serial t
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "arrow-low-level")
                 (:file "parquet-low-level")
                 (:file "arrow")
                 (:file "parquet")
                 (:file "utils"))))
  :in-order-to ((test-op (test-op "cl-apache-arrow/tests"))))

(defsystem "cl-apache-arrow/tests"
  :description "Test system for cl-apache-arrow"
  :author "Katherine Cox-Buday <cox.katherine.e@gmail.com>"
  :license "Apache-2.0"
  :depends-on ("cl-apache-arrow"
               "rove")
  :components ((:module "src"
                :components
                ((:file "utils-test")
                 (:file "arrow-test"))))
  :perform (test-op (op c) (symbol-call :rove :run c)))
