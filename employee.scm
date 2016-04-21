;;; http://www.gnu.org/software/guile/manual/html_node/SRFI_002d9-Records.html#SRFI_002d9-Records

(define-record-type <employee>
  (make-employee name age salary)
  employee?
  (name employee-name)
  (age employee-age set-employee-age!)
  (salary employee-salary set-employee-salary!))
