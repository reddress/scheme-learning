;;;; ~/.guile

(use-modules (srfi srfi-9))
(use-modules (oop goops))
(use-syntax (ice-9 syncase))

(define base-dir #f)

(if (equal? (substring (vector-ref (uname) 0) 0 3) "CYG")
    (set! base-dir "/cygdrive/c/Users/Heitor/Desktop/emacs-24.3/bin/scheme-learning/out/")
    (set! base-dir "/home/heitor/scheme-learning/out/"))

(define (base-file filename)
        (string-append base-dir filename))


(define-macro (write-to-macro filename . body)
  `(with-output-to-file
       (base-file ,filename)
     (lambda ()
       ,@body)))

(define-syntax write-to
  (syntax-rules ()
    ((write-to-syn filename body ...)
     (with-output-to-file (base-file filename)
       (lambda ()
         body ...)))))


;;; http://www.gnu.org/software/guile/manual/html_node/SRFI_002d9-Records.html#SRFI_002d9-Records

;; (define-record-type <employee>
;;   (make-employee name age salary)
;;   employee?
;;   (name employee-name)
;;   (age employee-age set-employee-age!)
;;   (salary employee-salary set-employee-salary!))

(define (symbol-concat . syms)
  (let ((strs (map symbol->string syms)))
    (string->symbol (apply string-append strs))))

(define (field-to-full-spec type-name field-name)
  (list field-name
        (symbol-concat type-name '- field-name)
        (symbol-concat 'set- type-name '- field-name '!)))

(define-macro (generic-record-type type-name . field-names)
  `(define-record-type ,type-name
     (,(symbol-concat 'make '- type-name) ,@field-names)
     ,(symbol-concat type-name '?)
     ,@(map
        (lambda (field-name) (field-to-full-spec type-name field-name))
        field-names)))

(define-syntax repeat
  (syntax-rules ()
    ((repeat n body ...)
     (do ((j 1 (+ j 1)))
         ((> j n))
       body ...))))
