(defpackage #:arrow-low-level
  (:use #:cl)
  (:import-from #:gir)
  (:export gir-object
           native-pointer
           arrow-array-cast
           arrow-array-count
           arrow-array-count-values
           arrow-array-dictionary-encode
           arrow-array-diff-unified
           arrow-array-equal
           arrow-array-equal-approx
           arrow-array-equal-range
           arrow-array-filter
           arrow-array-get-length
           arrow-array-get-n-nulls
           arrow-array-get-null-bitmap
           arrow-array-get-offset
           arrow-array-get-value-data-type
           arrow-array-get-value-type
           arrow-array-is-in
           arrow-array-is-in-chunked-array
           arrow-array-is-null
           arrow-array-is-valid
           arrow-array-slice
           arrow-array-sort-to-indices
           arrow-array-take
           arrow-array-to-string
           arrow-array-unique arrow-array-view
           arrow-array array-builder-finish
           array-builder-get-value-data-type
           array-builder-get-value-type
           array-builder-release-ownership
           array-builder make-binary-array-new
           binary-array-get-buffer
           binary-array-get-offsets-buffer
           binary-array-get-value binary-array
           make-binary-array-builder-new
           binary-array-builder-append
           binary-array-builder-append-null
           binary-array-builder-append-value
           binary-array-builder
           make-binary-data-type-new
           binary-data-type
           make-boolean-array-new
           boolean-array-and
           boolean-array-get-value
           boolean-array-get-values
           boolean-array-invert boolean-array-or
           boolean-array-xor boolean-array
           make-boolean-array-builder-new
           boolean-array-builder-append
           boolean-array-builder-append-null
           boolean-array-builder-append-nulls
           boolean-array-builder-append-value
           boolean-array-builder-append-values
           boolean-array-builder
           make-boolean-data-type-new
           boolean-data-type make-buffer-new
           make-buffer-new-bytes buffer-copy
           buffer-equal buffer-equal-n-bytes
           buffer-get-capacity buffer-get-data
           buffer-get-mutable-data
           buffer-get-parent buffer-get-size
           buffer-is-mutable buffer-slice buffer
           make-buffer-input-stream-new
           buffer-input-stream-get-buffer
           buffer-input-stream
           make-buffer-output-stream-new
           buffer-output-stream
           make-csvread-options-new
           csvread-options-add-column-name
           csvread-options-add-column-type
           csvread-options-add-false-value
           csvread-options-add-null-value
           csvread-options-add-schema
           csvread-options-add-true-value
           csvread-options-get-column-names
           csvread-options-get-column-types
           csvread-options-get-false-values
           csvread-options-get-null-values
           csvread-options-get-true-values
           csvread-options-set-column-names
           csvread-options-set-false-values
           csvread-options-set-null-values
           csvread-options-set-true-values
           csvread-options make-csvreader-new
           csvreader-read csvreader
           make-cast-options-new cast-options
           make-chunked-array-new
           chunked-array-equal
           chunked-array-get-chunk
           chunked-array-get-chunks
           chunked-array-get-length
           chunked-array-get-n-chunks
           chunked-array-get-n-nulls
           chunked-array-get-n-rows
           chunked-array-get-value-data-type
           chunked-array-get-value-type
           chunked-array-slice
           chunked-array-to-string chunked-array
           make-codec-new codec-get-name codec
           make-compare-options-new
           compare-options
           make-compressed-input-stream-new
           compressed-input-stream
           make-compressed-output-stream-new
           compressed-output-stream
           make-count-options-new count-options
           arrow-data-type-equal
           arrow-data-type-get-id
           arrow-data-type-to-string
           arrow-data-type make-date32array-new
           date32array-get-value
           date32array-get-values date32array
           make-date32array-builder-new
           date32array-builder-append
           date32array-builder-append-null
           date32array-builder-append-nulls
           date32array-builder-append-value
           date32array-builder-append-values
           date32array-builder
           make-date32data-type-new
           date32data-type make-date64array-new
           date64array-get-value
           date64array-get-values date64array
           make-date64array-builder-new
           date64array-builder-append
           date64array-builder-append-null
           date64array-builder-append-nulls
           date64array-builder-append-value
           date64array-builder-append-values
           date64array-builder
           make-date64data-type-new
           date64data-type
           make-decimal128-new-integer
           make-decimal128-new-string
           decimal128-abs decimal128-divide
           decimal128-equal
           decimal128-greater-than
           decimal128-greater-than-or-equal
           decimal128-less-than
           decimal128-less-than-or-equal
           decimal128-minus decimal128-multiply
           decimal128-negate
           decimal128-not-equal decimal128-plus
           decimal128-rescale
           decimal128-to-integer
           decimal128-to-string
           decimal128-to-string-scale decimal128
           decimal128array-format-value
           decimal128array-get-value
           decimal128array
           make-decimal128array-builder-new
           decimal128array-builder-append
           decimal128array-builder-append-null
           decimal128array-builder-append-value
           decimal128array-builder
           make-decimal128data-type-new
           decimal128data-type
           make-decimal-data-type-new
           decimal-data-type-get-precision
           decimal-data-type-get-scale
           decimal-data-type
           make-dense-union-array-new
           make-dense-union-array-new-data-type
           dense-union-array
           make-dense-union-data-type-new
           dense-union-data-type
           make-dictionary-array-new
           dictionary-array-get-dictionary
           dictionary-array-get-dictionary-data-type
           dictionary-array-get-indices
           dictionary-array
           make-dictionary-data-type-new
           dictionary-data-type-get-index-data-type
           dictionary-data-type-get-value-data-type
           dictionary-data-type-is-ordered
           dictionary-data-type
           make-double-array-new
           double-array-compare
           double-array-get-value
           double-array-get-values
           double-array-sum double-array
           make-double-array-builder-new
           double-array-builder-append
           double-array-builder-append-null
           double-array-builder-append-nulls
           double-array-builder-append-value
           double-array-builder-append-values
           double-array-builder
           make-double-data-type-new
           double-data-type
           make-feather-file-reader-new
           feather-file-reader-get-column-data
           feather-file-reader-get-column-name
           feather-file-reader-get-description
           feather-file-reader-get-n-columns
           feather-file-reader-get-n-rows
           feather-file-reader-get-version
           feather-file-reader-has-description
           feather-file-reader-read
           feather-file-reader-read-indices
           feather-file-reader-read-names
           feather-file-reader
           make-feather-file-writer-new
           feather-file-writer-append
           feather-file-writer-close
           feather-file-writer-set-description
           feather-file-writer-set-n-rows
           feather-file-writer-write
           feather-file-writer make-field-new
           make-field-new-full field-equal
           field-get-data-type field-get-name
           field-is-nullable field-to-string
           field make-file-output-stream-new
           file-output-stream
           fixed-size-binary-array
           make-fixed-size-binary-data-type-new
           fixed-size-binary-data-type-get-byte-width
           fixed-size-binary-data-type
           fixed-width-data-type-get-bit-width
           fixed-width-data-type
           make-float-array-new
           float-array-compare
           float-array-get-value
           float-array-get-values
           float-array-sum float-array
           make-float-array-builder-new
           float-array-builder-append
           float-array-builder-append-null
           float-array-builder-append-nulls
           float-array-builder-append-value
           float-array-builder-append-values
           float-array-builder
           make-float-data-type-new
           float-data-type
           floating-point-data-type
           make-gioinput-stream-new
           gioinput-stream-get-raw
           gioinput-stream
           make-giooutput-stream-new
           giooutput-stream-get-raw
           giooutput-stream input-stream-advance
           input-stream-align
           input-stream-read-tensor input-stream
           make-int16array-new
           int16array-compare
           int16array-get-value
           int16array-get-values int16array-sum
           int16array
           make-int16array-builder-new
           int16array-builder-append
           int16array-builder-append-null
           int16array-builder-append-nulls
           int16array-builder-append-value
           int16array-builder-append-values
           int16array-builder
           make-int16data-type-new
           int16data-type make-int32array-new
           int32array-compare
           int32array-get-value
           int32array-get-values int32array-sum
           int32array
           make-int32array-builder-new
           int32array-builder-append
           int32array-builder-append-null
           int32array-builder-append-nulls
           int32array-builder-append-value
           int32array-builder-append-values
           int32array-builder
           make-int32data-type-new
           int32data-type make-int64array-new
           int64array-compare
           int64array-get-value
           int64array-get-values int64array-sum
           int64array
           make-int64array-builder-new
           int64array-builder-append
           int64array-builder-append-null
           int64array-builder-append-nulls
           int64array-builder-append-value
           int64array-builder-append-values
           int64array-builder
           make-int64data-type-new
           int64data-type make-int8array-new
           int8array-compare int8array-get-value
           int8array-get-values int8array-sum
           int8array make-int8array-builder-new
           int8array-builder-append
           int8array-builder-append-null
           int8array-builder-append-nulls
           int8array-builder-append-value
           int8array-builder-append-values
           int8array-builder
           make-int8data-type-new int8data-type
           make-int-array-builder-new
           int-array-builder-append
           int-array-builder-append-null
           int-array-builder-append-nulls
           int-array-builder-append-value
           int-array-builder-append-values
           int-array-builder integer-data-type
           make-jsonread-options-new
           jsonread-options make-jsonreader-new
           jsonreader-read jsonreader
           make-list-array-new
           list-array-get-value
           list-array-get-value-type list-array
           make-list-array-builder-new
           list-array-builder-append
           list-array-builder-append-null
           list-array-builder-append-value
           list-array-builder-get-value-builder
           list-array-builder
           make-list-data-type-new
           list-data-type-get-field
           list-data-type-get-value-field
           list-data-type
           make-memory-mapped-input-stream-new
           memory-mapped-input-stream
           make-mutable-buffer-new
           make-mutable-buffer-new-bytes
           mutable-buffer-set-data
           mutable-buffer-slice mutable-buffer
           make-null-array-new null-array
           make-null-array-builder-new
           null-array-builder-append-null
           null-array-builder-append-nulls
           null-array-builder
           make-null-data-type-new
           null-data-type numeric-array-mean
           numeric-array numeric-data-type
           output-stream-align
           output-stream-write-tensor
           output-stream
           primitive-array-get-buffer
           primitive-array make-record-batch-new
           record-batch-add-column
           record-batch-equal
           record-batch-get-column-data
           record-batch-get-column-name
           record-batch-get-n-columns
           record-batch-get-n-rows
           record-batch-get-schema
           record-batch-remove-column
           record-batch-slice
           record-batch-to-string record-batch
           make-record-batch-builder-new
           record-batch-builder-flush
           record-batch-builder-get-column-builder
           record-batch-builder-get-field
           record-batch-builder-get-initial-capacity
           record-batch-builder-get-n-columns
           record-batch-builder-get-n-fields
           record-batch-builder-get-schema
           record-batch-builder-set-initial-capacity
           record-batch-builder
           make-record-batch-file-reader-new
           record-batch-file-reader-get-n-record-batches
           record-batch-file-reader-get-record-batch
           record-batch-file-reader-get-schema
           record-batch-file-reader-get-version
           record-batch-file-reader-read-record-batch
           record-batch-file-reader
           make-record-batch-file-writer-new
           record-batch-file-writer
           record-batch-reader-get-next-record-batch
           record-batch-reader-get-schema
           record-batch-reader-read-next
           record-batch-reader-read-next-record-batch
           record-batch-reader
           make-record-batch-stream-reader-new
           record-batch-stream-reader
           make-record-batch-stream-writer-new
           record-batch-stream-writer
           record-batch-writer-close
           record-batch-writer-write-record-batch
           record-batch-writer-write-table
           record-batch-writer
           make-resizable-buffer-new
           resizable-buffer-reserve
           resizable-buffer-resize
           resizable-buffer
           make-arrow-schema-new
           arrow-schema-add-field
           arrow-schema-equal
           arrow-schema-get-field
           arrow-schema-get-field-by-name
           arrow-schema-get-field-index
           arrow-schema-get-fields
           arrow-schema-n-fields
           arrow-schema-remove-field
           arrow-schema-replace-field
           arrow-schema-to-string arrow-schema
           seekable-input-stream-get-size
           seekable-input-stream-get-support-zero-copy
           seekable-input-stream-peek
           seekable-input-stream-read-at
           seekable-input-stream
           make-sparse-union-array-new
           make-sparse-union-array-new-data-type
           sparse-union-array
           make-sparse-union-data-type-new
           sparse-union-data-type
           make-string-array-new
           string-array-get-string string-array
           make-string-array-builder-new
           string-array-builder-append
           string-array-builder-append-value
           string-array-builder-append-values
           string-array-builder
           make-string-data-type-new
           string-data-type
           make-struct-array-new
           struct-array-flatten
           struct-array-get-field
           struct-array-get-fields struct-array
           make-struct-array-builder-new
           struct-array-builder-append
           struct-array-builder-append-null
           struct-array-builder-append-value
           struct-array-builder-get-field-builder
           struct-array-builder-get-field-builders
           struct-array-builder
           make-struct-data-type-new
           struct-data-type-get-field
           struct-data-type-get-field-by-name
           struct-data-type-get-field-index
           struct-data-type-get-fields
           struct-data-type-get-n-fields
           struct-data-type
           make-arrow-table-new-arrays
           make-arrow-table-new-chunked-arrays
           make-arrow-table-new-record-batches
           make-arrow-table-new-values
           arrow-table-add-column
           arrow-table-concatenate
           arrow-table-equal
           arrow-table-get-column-data
           arrow-table-get-n-columns
           arrow-table-get-n-rows
           arrow-table-get-schema
           arrow-table-remove-column
           arrow-table-replace-column
           arrow-table-slice
           arrow-table-to-string arrow-table
           make-table-batch-reader-new
           table-batch-reader
           make-take-options-new take-options
           make-arrow-tensor-new
           arrow-tensor-equal
           arrow-tensor-get-buffer
           arrow-tensor-get-dimension-name
           arrow-tensor-get-n-dimensions
           arrow-tensor-get-shape
           arrow-tensor-get-size
           arrow-tensor-get-strides
           arrow-tensor-get-value-data-type
           arrow-tensor-get-value-type
           arrow-tensor-is-column-major
           arrow-tensor-is-contiguous
           arrow-tensor-is-mutable
           arrow-tensor-is-row-major
           arrow-tensor make-time32array-new
           time32array-get-value
           time32array-get-values time32array
           make-time32array-builder-new
           time32array-builder-append
           time32array-builder-append-null
           time32array-builder-append-nulls
           time32array-builder-append-value
           time32array-builder-append-values
           time32array-builder
           make-time32data-type-new
           time32data-type make-time64array-new
           time64array-get-value
           time64array-get-values time64array
           make-time64array-builder-new
           time64array-builder-append
           time64array-builder-append-null
           time64array-builder-append-nulls
           time64array-builder-append-value
           time64array-builder-append-values
           time64array-builder
           make-time64data-type-new
           time64data-type
           time-data-type-get-unit
           time-data-type
           make-timestamp-array-new
           timestamp-array-get-value
           timestamp-array-get-values
           timestamp-array
           make-timestamp-array-builder-new
           timestamp-array-builder-append
           timestamp-array-builder-append-null
           timestamp-array-builder-append-nulls
           timestamp-array-builder-append-value
           timestamp-array-builder-append-values
           timestamp-array-builder
           make-timestamp-data-type-new
           timestamp-data-type-get-unit
           timestamp-data-type
           make-uint16array-new
           uint16array-compare
           uint16array-get-value
           uint16array-get-values
           uint16array-sum uint16array
           make-uint16array-builder-new
           uint16array-builder-append
           uint16array-builder-append-null
           uint16array-builder-append-nulls
           uint16array-builder-append-value
           uint16array-builder-append-values
           uint16array-builder
           make-uint16data-type-new
           uint16data-type make-uint32array-new
           uint32array-compare
           uint32array-get-value
           uint32array-get-values
           uint32array-sum uint32array
           make-uint32array-builder-new
           uint32array-builder-append
           uint32array-builder-append-null
           uint32array-builder-append-nulls
           uint32array-builder-append-value
           uint32array-builder-append-values
           uint32array-builder
           make-uint32data-type-new
           uint32data-type make-uint64array-new
           uint64array-compare
           uint64array-get-value
           uint64array-get-values
           uint64array-sum uint64array
           make-uint64array-builder-new
           uint64array-builder-append
           uint64array-builder-append-null
           uint64array-builder-append-nulls
           uint64array-builder-append-value
           uint64array-builder-append-values
           uint64array-builder
           make-uint64data-type-new
           uint64data-type make-uint8array-new
           uint8array-compare
           uint8array-get-value
           uint8array-get-values uint8array-sum
           uint8array
           make-uint8array-builder-new
           uint8array-builder-append
           uint8array-builder-append-null
           uint8array-builder-append-nulls
           uint8array-builder-append-value
           uint8array-builder-append-values
           uint8array-builder
           make-uint8data-type-new
           uint8data-type
           make-uint-array-builder-new
           uint-array-builder-append
           uint-array-builder-append-null
           uint-array-builder-append-nulls
           uint-array-builder-append-value
           uint-array-builder-append-values
           uint-array-builder
           union-array-get-field union-array
           union-data-type-get-field
           union-data-type-get-fields
           union-data-type-get-n-fields
           union-data-type-get-type-codes
           union-data-type))

(defpackage #:parquet-low-level
  (:use #:cl)
  (:import-from #:gir)
  (:export gir-object
           native-pointer
           make-arrow-file-reader-new-arrow
           make-arrow-file-reader-new-path
           arrow-file-reader-get-n-row-groups
           arrow-file-reader-get-schema
           arrow-file-reader-read-column-data
           arrow-file-reader-read-table
           arrow-file-reader-set-use-threads
           arrow-file-reader
           make-arrow-file-writer-new-arrow
           make-arrow-file-writer-new-path
           arrow-file-writer-close
           arrow-file-writer-write-table
           arrow-file-writer))

(defpackage #:arrow
  (:use #:cl
        #:arrow-low-level)
  (:shadowing-import-from #:arrow-low-level)
  (:import-from #:closer-mop)
  (:export schema-from-object
           entity-class
           entity-slot-definition
           arrow-field-name
           with-field-builders))

(defpackage #:parquet
  (:use #:cl)
  (:shadowing-import-from #:parquet-low-level)
  (:export with-open-file-writer))
