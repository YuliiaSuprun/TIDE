(define (problem bw_2)
  (:domain blocks-domain)
  (:objects b1 b2 b3 - block)
  (:init (emptyhand) (ontable b1) (ontable b2) (ontable b3) (clear b1) (clear b2) (clear b3))

  (:goal (and
    (eventually (on b2 b1)) 
    (always (imply (on b2 b1) (next (on b3 b2))))
  ))
)
