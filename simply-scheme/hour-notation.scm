(define (european-time american-time)
  (+ (if (= 12 (first american-time))
         0
         (first american-time))
     (if (equal? (last american-time) 'pm)
         12
         0)))

(define (american-time european-time)
  (se (if (= (remainder european-time 12) 0)
          12
          (remainder european-time 12))
      (if (>= european-time 12)
          'pm
          'am)))
