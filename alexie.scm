;;; Double-entry accounting

(define *accounts* '())
(define *transactions* '())

(define (add-account account)
  (set! *accounts* (cons account *accounts*)))

(define (add-transaction transaction)
  (set! *transactions* (cons transaction *transactions*)))

(define (reset!)
  (set! *accounts* '())
  (set! *transactions* '()))

;;; account types
(define *account-types*
  '((asset 1)
    (expense 1)
    (liability -1)
    (income -1)
    (equity -1)))

(define (account-type-sign type)
  (letrec ((rec (lambda (account-types)
                  (if (null? account-types)
                      'account-type-not-found
                      (if (equal? type (caar account-types))
                          (cadar account-types)
                          (rec (cdr account-types)))))))
           (rec *account-types*)))

;;; populate data
(reset!)

;;; account is an identifier and type
(add-account '(sal income))  ;; salary
(add-account '(bank asset))
(add-account '(open equity))  ;; opening balance
(add-account '(groc expense))  ;; groceries
(add-account '(cred liability))  ;; credit card
(add-account '(elec expense))  ;; electronics

;;; transaction is a date, description, amount, debit, and credit
(add-transaction '(2016-03-01 opening-balance 140 bank open))
(add-transaction '(2016-03-02 feb-salary 2300 bank sal))
(add-transaction '(2016-03-04 vegetables 28 groc bank))
(add-transaction '(2016-03-04 new-phone 560 elec cred))
(add-transaction '(2016-03-10 soup-and-rice 12 groc bank))

(define (get collection key)
  (if (null? collection)
      'key-not-found
      (if (equal? key (caar collection))
          (car collection)
          (get (cdr collection) key))))

(define (account-sign account)
  (account-type-sign (cadr (get *accounts* account))))
  
(define (transaction-date transaction)
  (car transaction))

(define (transaction-description transaction)
  (cadr transaction))

(define (transaction-amount transaction)
  (caddr transaction))

(define (transaction-debit transaction)
  (cadddr transaction))

(define (transaction-credit transaction)
  (cadddr (cdr transaction)))  ;; ugly, but want to keep format order

;;; (define (debit-transactions-for-account-specific account)
;;;   (filter (lambda (transaction)
;;;            (equal? account (transaction-debit transaction)))
;;;               *transactions*))

(define (transactions-matching-account-name fn account)
  ;;; generic version of the previous function
  ;;; (transactions-matching-account-name transaction-credit 'open)
  (map (if (= -1 (account-sign account))
           invert-sign
           identity)
       (filter (lambda (transaction)
                 (equal? account (fn transaction)))
               *transactions*)))

(define (significant-transaction? transaction)
  (> (transaction-amount transaction) 100))

(define (transactions-filter fn)
  (filter fn *transactions*))

(use-modules (srfi srfi-1))  ;; for fold

(define (sum-transaction-amounts transactions)
  (fold + 0 (map transaction-amount transactions)))

(define (debit-transactions-for-account account)
  (transactions-matching-account-name transaction-debit account))

(define (credit-transactions-for-account account)
  (map invert-sign
       (transactions-matching-account-name transaction-credit account)))

(define (invert-sign transaction)
  (list
   (transaction-date transaction)
   (transaction-description transaction)
   (- (transaction-amount transaction))
   (transaction-debit transaction)
   (transaction-credit transaction)))

(define (balance account)
  (apply + (map sum-transaction-amounts
                (list (debit-transactions-for-account account)
                      (credit-transactions-for-account account)))))
