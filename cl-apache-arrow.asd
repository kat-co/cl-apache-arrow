;;;; Copyright (c) 2019 Katherine Cox-Buday <cox.katherine.e@gmail.com>

(asdf:defsystem #:cl-apache-arrow
  :description "Describe cl-apache-arrow here"
  :author "Katherine Cox-Buday <cox.katherine.e@gmail.com>"
  :license  "Apache-2.0"
  :version "0.0.1"
  :depends-on (cl-gobject-introspection
               closer-mop)
  :serial t
  :components ((:module "src"
                :components
                ((:file "package")
               (:file "arrow-low-level")
               (:file "parquet-low-level")
               (:file "arrow")
               (:file "parquet")
                 (:file "utils")))))
