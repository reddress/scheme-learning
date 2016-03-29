(use-modules (srfi srfi-1))  ;; for fold
(use-modules (srfi srfi-9))  ;; for records

(define-record-type <account-type>
  (make-account-type name sign)
  account-type?
  (name account-type-name)
  (sign account-type-sign))

(define *account-types* (list (make-account-type 'asset 1)
                              (make-account-type 'expense 1)
                              (make-account-type 'liability -1)
                              (make-account-type 'income -1)
                              (make-account-type 'equity -1)))
