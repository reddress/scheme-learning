;;; open string port

;;; (define i (open-input string "hello world"))

(define o (open-output-string))

(write 'hello o)

(get-output-string o)

(close-output-port o)
