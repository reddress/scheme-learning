;;; Racket DB interface
(require db)

;;; Use ~a to convert anything to string
(require racket/format)

;;; Vulnerable to SQL Injection, etc. Use only in localhost

;;; Using EasyPHP in PTL
(define *CONNECTION*
  (mysql-connect #:user "root"
                 #:database "racketdb"
                 #:server "127.0.0.1"))

;;; table "vehicle"
;;; id, wheels, name
;;; PK

(define keys '("id" "wheels" "name"))

(define my-rows (query-rows *CONNECTION* "select id, wheels, name from vehicle"))
;; (query-exec conn "insert into vehicle (wheels, name)
;; values (2, 'bicycle')")

(define (select-assoc-rows table keys)
  (define (make-assoc-list keys vals)
    (map (lambda (k v) (cons k v)) keys vals))
  
  (define (process-row keys row)
    (make-assoc-list keys (vector->list row)))
  
  (let ((raw-rows (query-rows *CONNECTION* (string-append "select " (string-join keys ",") " from " table))))
    (map (lambda (row) (process-row keys row)) raw-rows)))

(define (get-column-values rows col-name)
  (map (lambda (row) (cdr (assoc col-name row))) rows))

(define my-assoc-rows (assoc-rows '("wheels" "name") "vehicle"))

(define first-row (list-ref my-assoc-rows 0))

(define vehicle-names (column-values my-assoc-rows "name"))

(define (insert-keys-values table keys values)
  (let ((sql-string
         (string-append "insert into " table " ("
                        (string-join keys ",") ") values (\""
                        (string-join (map ~a values) "\",\"") "\")")))
    (query-exec *CONNECTION* sql-string))
  'insert-keys-values-OK)
