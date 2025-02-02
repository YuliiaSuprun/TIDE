(define (problem bw_3)
  (:domain blocks-domain)
  (:objects b1 b2 b3 - block)
  (:init (emptyhand) (ontable b1) (ontable b2) (ontable b3) (clear b1) (clear b2) (clear b3))
  

 (:goal 
            (eventually (and (on b2 b1)
            (next (eventually (and (on b3 b2)
            (next (eventually (and (on b2 b3)
            (next (eventually (on b1 b2)))))))))))
 )

)