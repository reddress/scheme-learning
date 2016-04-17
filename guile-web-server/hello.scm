(use-modules (web server))

(define (hello-handler request request-body)
  (values '((content-type . (text/plain)))
          "Hello world from Guile"))

(run-server hello-handler)
