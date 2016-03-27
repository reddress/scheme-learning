;;; write to file

(define PATH "/home/heitor/tmp/")

;;; guile
(use-modules (ice-9 rdelim))

(with-output-to-file
    (string-append PATH "chicken-outfile.txt")
  (lambda ()
    (format #t "Hello Chicken")
    (newline)
    (format #t "3523891")))

;;; read file

(display 
 (with-input-from-file
     (string-append PATH "chicken-infile.txt")
   (lambda ()
     (let lp ((text "")  ;; named let
              (line (read-line)))
       (if (eof-object? line) text
           (lp (string-append text line "\n")
               (read-line)))))))
