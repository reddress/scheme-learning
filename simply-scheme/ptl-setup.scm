(define RESOUCES-PATH "c:/Users/Heitor/Desktop/emacs-24.3/bin/scheme-learning/simply-scheme/book-resources/")

(define (load-resource filename)
  (load (string-append RESOUCES-PATH filename)))

(load-resource "simply.scm")
(load-resource "functions.scm")
