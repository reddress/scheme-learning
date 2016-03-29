(define PATH "C:/Users/Heitor/Desktop/emacs-24.3/bin/scheme-learning/")
(use-modules (ice-9 rdelim))

(display 
 (with-input-from-file
     (string-append PATH "chinese.txt")
   (lambda ()
     (let loop ((text "")  ;; named let
              (line (read-line)))
       (if (eof-object? line) text
           (loop (string-append text line "\n")
               (read-line)))))))
