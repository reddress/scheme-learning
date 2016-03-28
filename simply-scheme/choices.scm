;;; pig latin
#;15> (define (pigl wd)
(if (member? (first wd) 'aeiou)
(word wd 'ay)
(pigl (word (butfirst wd) (first wd)))))


;;; Ch. 1 Example: Ice Cream choices

(define (choices menu)
  (if (null? menu)
      '(())
      (let ((smaller (choices (cdr menu))))
        (reduce append
                (map (lambda (item) (prepend-every item smaller))
                     (car menu))))))

(define (prepend-every item lst)
  (map (lambda (choice) (se item choice)) lst))
