(define (problem bw_5)
  (:domain blocks-domain)
  (:objects b1 b2 b3 b4 b5 - block)
  (:init (emptyhand) (ontable b1) (ontable b2) (ontable b3) (ontable b4) (ontable b5) (clear b1) (clear b2) (clear b3) (clear b4) (clear b5))
  

 (:goal 
            (eventually (and (on b2 b1) 
            (next (next (and (on b3 b2) 
            (next (next (and (on b4 b3)
            (next (next (and (on b5 b4)
            
            (next (eventually (and (on b4 b5)
            (next (next (and (on b3 b4)
            (next (next (and (on b2 b3)
            (next (next (on b1 b2)))))))))))))))))))))))
 )

)