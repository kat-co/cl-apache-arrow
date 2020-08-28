SBCL ?= sbcl --non-interactive

.PHONY : generate
generate : src/arrow-low-level.lisp src/parquet-low-level.lisp

.PHONY : src/arrow-low-level.lisp
ARROW_GIR ?= /usr/share/gir-1.0/Arrow-1.0.gir
src/arrow-low-level.lisp : $(ARROW_GIR) build-scripts/generate-low-level.lisp
	$(SBCL) --eval '(defparameter *generated-file* "$@")'\
		--eval '(defparameter *gir-file* #P"$<")'\
		--eval '(defparameter *gir-namespace* "Arrow")'\
		--eval '(defparameter *package-name* "#:arrow-low-level")'\
		--load $(word 2,$^)

.PHONY : src/parquet-low-level.lisp
src/parquet-low-level.lisp : PARQUET_GIR ?= /usr/share/gir-1.0/Parquet-1.0.gir
src/parquet-low-level.lisp : $(PARQUET_GIR) build-scripts/generate-low-level.lisp
	$(SBCL) --eval '(defparameter *generated-file* "$@")'\
		--eval '(defparameter *gir-file* #P"$<")'\
		--eval '(defparameter *gir-namespace* "Parquet")'\
		--eval '(defparameter *package-name* "#:parquet-low-level")'\
		--load $(word 2,$^)
