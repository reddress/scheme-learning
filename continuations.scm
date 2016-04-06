;;; http://www.madore.org/~david/computers/callcc.html

;; (let ((cont #f))
;;  (call/cc (lambda (k) (set! cont k)))
;;  (cont #f))  ;;; Loops forever

;;; http://courses.cs.washington.edu/courses/cse341/04wi/lectures/15-scheme-continuations.html

;;; an expression's continuation is "the computation that will receive the result of that expression"

(+ 4 (call/cc
      (lambda (cont) (cont (+ 1 2)))))
