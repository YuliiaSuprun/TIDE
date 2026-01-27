(define (problem bw_4)
  (:domain blocks-domain)
  (:objects b1 b2 b3 b4 - block)
  (:init (emptyhand) (ontable b1) (ontable b2) (ontable b3) (ontable b4)  (clear b1) (clear b2) (clear b3) (clear b4))
  

 (:goal (and 

            (eventually (and (on b2 b1)
            (next (eventually (and (on b3 b2)
            (next (eventually (on b4 b3))))))))
            
            (eventually (and (on b3 b4)
            (next (eventually (and (on b2 b3)
            (next (eventually (on b1 b2))))))))
        )
 )

)