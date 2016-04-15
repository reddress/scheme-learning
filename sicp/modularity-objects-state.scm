;;; p. 276, 3 Modularity, Objects, and State

;;; To organize a large problem, there are two prominent organizational strategies: one using OBJECTS, and another using STREAMS.

;;; With objects, we must be concerned with how a computational object can change, yet maintain its identity. The substitution model must be replaced by the more mechanistic ENVIRONMENT MODEL of computation.

;;; p. 277, 3.1 Assignment and Local State

;;; An object "has state" if its behavior is influenced by its history. For example, a bank account has state in that the answer to "Can I withdraw $100?" depends on the history of deposits and withdrawals.

;;; p. 291, 3.1.3 The costs of introducing Assignment

(define (make-simplified-withdraw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))

;;; Calling ((make-simplified-withdraw 25) 20)

; ((lambda (amount)
;    (set! balance (- 25 amount))
;    25) 20)
;
; (set! balance (-25 20)) 25
;;; To get the right answer, we need to distinguish the first occurrence of balance (before set!) from the second occurrence. The substitution model cannot do this.

;;; p. 293 Sameness and change

;;; A language that supports the concept that "equals can be substituted for equals" in an expression without changing the value of the expression is said to be REFERENTIALLY TRANSPARENT. When set! is included, referential transparency is violated.

;;; We cannot determine "change" without some a priori notion of "sameness", and we cannot determine sameness without observing the effects of change

;;; The phenomenon of a single computational object being accessed by more than one name is known as ALIASING.
