(define (problem bw_22)
  (:domain blocks-domain)
  (:objects b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 - block)
  (:init (emptyhand) (ontable b1) (clear b1) (ontable b2) (clear b2) (ontable b3) (clear b3) (ontable b4) (clear b4) (ontable b5) (clear b5) (ontable b6) (clear b6) (ontable b7) (clear b7) (ontable b8) (clear b8) (ontable b9) (clear b9) (ontable b10) (clear b10) (ontable b11) (clear b11) (ontable b12) (clear b12) (ontable b13) (clear b13) (ontable b14) (clear b14) (ontable b15) (clear b15) (ontable b16) (clear b16) (ontable b17) (clear b17) (ontable b18) (clear b18) (ontable b19) (clear b19) (ontable b20) (clear b20) (ontable b21) (clear b21) (ontable b22) (clear b22))
  
  (:goal
    (eventually (and 
      (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (on b9 b8) (on b10 b9) (on b11 b10) (on b12 b11) (on b13 b12) (on b14 b13) (on b15 b14) (on b16 b15) (on b17 b16) (on b18 b17) (on b19 b18) (on b20 b19) (on b21 b20) (on b22 b21)
      (next (eventually (and
        (on b22 b21) (on b21 b20) (on b20 b19) (on b19 b18) (on b18 b17) (on b17 b16) (on b16 b15) (on b15 b14) (on b14 b13) (on b13 b12) (on b12 b11) (on b11 b10) (on b10 b9) (on b9 b8) (on b8 b7) (on b7 b6) (on b6 b5) (on b5 b4) (on b4 b3) (on b3 b2) (on b1 b22)
      )))))
  )
)
