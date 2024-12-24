(define (problem bw_3)
  (:domain blocks-domain)
  (:objects b1 b2 b3 - block)
  (:init (emptyhand) (ontable b1) (clear b1) (ontable b2) (clear b2) (ontable b3) (clear b3))
  
  (:goal
    (eventually (and 
      (on b2 b1) (on b3 b2)
      (next (eventually (and
        (on b2 b3) (on b1 b2)
      )))))
  )
)
