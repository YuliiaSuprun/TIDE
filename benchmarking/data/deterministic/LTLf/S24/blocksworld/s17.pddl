(define (problem bw_7)
  (:domain blocks-domain)
  (:objects b1 b2 b3 b4 b5 b6 b7 - block)
  (:init (emptyhand) (ontable b1) (ontable b2) (ontable b3) (ontable b4) (ontable b5) (ontable b6) (ontable b7) (clear b1) (clear b2) (clear b3) (clear b4) (clear b5) (clear b6) (clear b7))
  

 (:goal
            (eventually (and 
              (on b2 b1) 
              (on b3 b2)
              (on b4 b3)
              (on b5 b4)
              (on b6 b5)
              (on b7 b6)
              (next (eventually (and
                (on b6 b7)
                (on b5 b6)
                (on b4 b5)
                (on b3 b4)
                (on b2 b3)
                (on b1 b2)
              )))))
 )

)