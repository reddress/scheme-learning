(use-modules (ice-9 rdelim))
(define *standard-out* (current-output-port))

(define (read-line-loop)
  (let ((user-input (read-line)))
    (if (equal? user-input "q")
        (display "leaving loop\n" *standard-out*)
        (begin
          (display (string-append user-input user-input) *standard-out*)
          (newline *standard-out*)
          
          (display user-input)  ;; to file
          (newline)  ;; to file
          
          (read-line-loop)))))

(write-to "guile-read-line-loop-20160409.txt"
          (read-line-loop))
