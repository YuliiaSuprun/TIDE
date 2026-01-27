(define (problem bw_4)
  (:domain blocks-domain)
  (:objects b1 b2 b3 b4 - block)
  (:init (emptyhand) (ontable b1) (clear b1) (ontable b2) (clear b2) (ontable b3) (clear b3) (ontable b4) (clear b4))
  
  (:goal
    (eventually (and 
      (on b2 b1) (on b3 b2) (on b4 b3)
      (next (eventually (and
        (on b4 b3) (on b3 b2) (on b1 b4)
      )))))
  )
)
