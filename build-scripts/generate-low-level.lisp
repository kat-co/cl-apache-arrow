(require :asdf)
(require :cffi)

(handler-case (cffi:load-foreign-library "libgobject-2.0.so")
  (t ()
    (format t "Cannot load the libgobject foreign library. Please make sure it is in a place CFFI can find it.")
    (exit)))

(require :gir2cl)

(handler-case (asdf:load-system :gir2cl)
  (t (c)
    (format t "Cannot load the gir2cl system:~&~a" c)
    (exit)))

;;; The parameters are meant to be passed in via the Makefile.

(defvar *package-name* "#:my-low-level"
  "The package name for the generated code to reside in.")

(defvar *gir-namespace* "MyNamespace"
  "The Gir namespace.")

(defvar *generated-file* "generated.lisp"
  "The file to place the generated code into.")

(defvar *gir-file* "my.gir"
  "The Gir file to read in.")

(with-open-file (stream *generated-file* :direction :output :if-exists :supersede)
  (gir2cl:generate *package-name* *gir-namespace* stream *gir-file*))
