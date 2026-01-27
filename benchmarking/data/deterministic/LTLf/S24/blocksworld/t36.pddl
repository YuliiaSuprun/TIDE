(define (problem bw_36)
  (:domain blocks-domain)
  (:objects b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 - block)
  (:init (emptyhand) (ontable b1) (clear b1) (ontable b2) (clear b2) (ontable b3) (clear b3) (ontable b4) (clear b4) (ontable b5) (clear b5) (ontable b6) (clear b6) (ontable b7) (clear b7) (ontable b8) (clear b8) (ontable b9) (clear b9) (ontable b10) (clear b10) (ontable b11) (clear b11) (ontable b12) (clear b12) (ontable b13) (clear b13) (ontable b14) (clear b14) (ontable b15) (clear b15) (ontable b16) (clear b16) (ontable b17) (clear b17) (ontable b18) (clear b18) (ontable b19) (clear b19) (ontable b20) (clear b20) (ontable b21) (clear b21) (ontable b22) (clear b22) (ontable b23) (clear b23) (ontable b24) (clear b24) (ontable b25) (clear b25) (ontable b26) (clear b26) (ontable b27) (clear b27) (ontable b28) (clear b28) (ontable b29) (clear b29) (ontable b30) (clear b30) (ontable b31) (clear b31) (ontable b32) (clear b32) (ontable b33) (clear b33) (ontable b34) (clear b34) (ontable b35) (clear b35) (ontable b36) (clear b36))
  
  (:goal
    (eventually (and 
      (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (on b9 b8) (on b10 b9) (on b11 b10) (on b12 b11) (on b13 b12) (on b14 b13) (on b15 b14) (on b16 b15) (on b17 b16) (on b18 b17) (on b19 b18) (on b20 b19) (on b21 b20) (on b22 b21) (on b23 b22) (on b24 b23) (on b25 b24) (on b26 b25) (on b27 b26) (on b28 b27) (on b29 b28) (on b30 b29) (on b31 b30) (on b32 b31) (on b33 b32) (on b34 b33) (on b35 b34) (on b36 b35)
      (next (eventually (and
        (on b35 b36) (on b34 b35) (on b33 b34) (on b32 b33) (on b31 b32) (on b30 b31) (on b29 b30) (on b28 b29) (on b27 b28) (on b26 b27) (on b25 b26) (on b24 b25) (on b23 b24) (on b22 b23) (on b21 b22) (on b20 b21) (on b19 b20) (on b18 b19) (on b17 b18) (on b16 b17) (on b15 b16) (on b14 b15) (on b13 b14) (on b12 b13) (on b11 b12) (on b10 b11) (on b9 b10) (on b8 b9) (on b7 b8) (on b6 b7) (on b5 b6) (on b4 b5) (on b3 b4) (on b2 b3) (on b1 b2)
      )))))
  )
)
