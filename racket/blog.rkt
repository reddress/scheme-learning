#lang web-server/insta

;;; https://docs.racket-lang.org/continue/

;; (define (start request)
;;   (response/xexpr
;;    '(html
;;      (head
;;       (title "My blog"))
;;      (body
;;       (h1 "Under construction")))))

(struct post (title body))
(define BLOG (list
              (post "First post!"
                    "Hey, it's my first post!")
              (post "Second post"
                    "Not bad")))

;; (define xexper/c
;;   (flat-rec-contract

(define (render-greeting a-name)
  (response/xexpr
   `(html (head (title "Welcome"))
          (body (p ,(string-append "Hello " a-name))))))

(define (render-as-itemized-list fragments)
  `(ul ,@(map render-as-item fragments)))

(define (render-as-item a-fragment)
  `(li ,a-fragment))

(define (start request)
  (render-blog-page BLOG request))

(define (render-blog-page a-blog request)
  (response/xexpr
   `(html (head (title "My Blog"))
          (body (h1 "My blog")
                ,(render-posts a-blog)))))

(define (render-post a-post)
  `(div ((class "post"))
        ,(post-title a-post)
        (p ,(post-body a-post))))

(define (render-posts a-blog)
  `(div ((class "posts"))
        ,@(map render-post a-blog)))
