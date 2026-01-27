(define (domain 'blocks-domain')
  (:types
    block - NO_TYPE
  )

  (:predicates
    (ontable ?x0 - block)
    (on ?x0 - block ?x1 - block)
    (clear ?x0 - block)
    (emptyhand)
    (holding ?x0 - block)
    (autstate_1_2)
    (autstate_1_3)
    (autstate_1_4)
    (autstate_1_5)
    (autstate_1_6)
    (autstate_1_7)
    (autstate_1_8)
    (autstate_1_1)
    (prev_autstate_1_2)
    (prev_autstate_1_3)
    (prev_autstate_1_4)
    (prev_autstate_1_5)
    (prev_autstate_1_6)
    (prev_autstate_1_7)
    (prev_autstate_1_8)
    (prev_autstate_1_1)
    (aut_in_final_1)
  )
  (:action pick-up
    :parameters (?x0 - block)
    :precondition 
      (and
        (clear ?x0)
        (ontable ?x0)
        (emptyhand))
    :effect
      (and
        (holding ?x0)
        (when
          (autstate_1_2)
          (prev_autstate_1_2))
        (when
          (autstate_1_3)
          (prev_autstate_1_3))
        (when
          (autstate_1_4)
          (prev_autstate_1_4))
        (when
          (autstate_1_5)
          (prev_autstate_1_5))
        (when
          (autstate_1_6)
          (prev_autstate_1_6))
        (when
          (autstate_1_7)
          (prev_autstate_1_7))
        (when
          (autstate_1_8)
          (prev_autstate_1_8))
        (when
          (autstate_1_1)
          (prev_autstate_1_1))
        (not 
          (ontable ?x0))
        (not 
          (clear ?x0))
        (not 
          (emptyhand))
        (when
          (not 
            (autstate_1_2))
          (not 
            (prev_autstate_1_2)))
        (when
          (not 
            (autstate_1_3))
          (not 
            (prev_autstate_1_3)))
        (when
          (not 
            (autstate_1_4))
          (not 
            (prev_autstate_1_4)))
        (when
          (not 
            (autstate_1_5))
          (not 
            (prev_autstate_1_5)))
        (when
          (not 
            (autstate_1_6))
          (not 
            (prev_autstate_1_6)))
        (when
          (not 
            (autstate_1_7))
          (not 
            (prev_autstate_1_7)))
        (when
          (not 
            (autstate_1_8))
          (not 
            (prev_autstate_1_8)))
        (when
          (not 
            (autstate_1_1))
          (not 
            (prev_autstate_1_1)))
      )
    )
  (:action put-down
    :parameters (?x0 - block)
    :precondition 
      (holding ?x0)
    :effect
      (and
        (clear ?x0)
        (emptyhand)
        (ontable ?x0)
        (when
          (autstate_1_2)
          (prev_autstate_1_2))
        (when
          (autstate_1_3)
          (prev_autstate_1_3))
        (when
          (autstate_1_4)
          (prev_autstate_1_4))
        (when
          (autstate_1_5)
          (prev_autstate_1_5))
        (when
          (autstate_1_6)
          (prev_autstate_1_6))
        (when
          (autstate_1_7)
          (prev_autstate_1_7))
        (when
          (autstate_1_8)
          (prev_autstate_1_8))
        (when
          (autstate_1_1)
          (prev_autstate_1_1))
        (not 
          (holding ?x0))
        (when
          (not 
            (autstate_1_2))
          (not 
            (prev_autstate_1_2)))
        (when
          (not 
            (autstate_1_3))
          (not 
            (prev_autstate_1_3)))
        (when
          (not 
            (autstate_1_4))
          (not 
            (prev_autstate_1_4)))
        (when
          (not 
            (autstate_1_5))
          (not 
            (prev_autstate_1_5)))
        (when
          (not 
            (autstate_1_6))
          (not 
            (prev_autstate_1_6)))
        (when
          (not 
            (autstate_1_7))
          (not 
            (prev_autstate_1_7)))
        (when
          (not 
            (autstate_1_8))
          (not 
            (prev_autstate_1_8)))
        (when
          (not 
            (autstate_1_1))
          (not 
            (prev_autstate_1_1)))
      )
    )
  (:action stack
    :parameters (?x0 - block ?x1 - block)
    :precondition 
      (and
        (holding ?x0)
        (clear ?x1))
    :effect
      (and
        (clear ?x0)
        (emptyhand)
        (on ?x0 ?x1)
        (when
          (autstate_1_2)
          (prev_autstate_1_2))
        (when
          (autstate_1_3)
          (prev_autstate_1_3))
        (when
          (autstate_1_4)
          (prev_autstate_1_4))
        (when
          (autstate_1_5)
          (prev_autstate_1_5))
        (when
          (autstate_1_6)
          (prev_autstate_1_6))
        (when
          (autstate_1_7)
          (prev_autstate_1_7))
        (when
          (autstate_1_8)
          (prev_autstate_1_8))
        (when
          (autstate_1_1)
          (prev_autstate_1_1))
        (not 
          (holding ?x0))
        (not 
          (clear ?x1))
        (when
          (not 
            (autstate_1_2))
          (not 
            (prev_autstate_1_2)))
        (when
          (not 
            (autstate_1_3))
          (not 
            (prev_autstate_1_3)))
        (when
          (not 
            (autstate_1_4))
          (not 
            (prev_autstate_1_4)))
        (when
          (not 
            (autstate_1_5))
          (not 
            (prev_autstate_1_5)))
        (when
          (not 
            (autstate_1_6))
          (not 
            (prev_autstate_1_6)))
        (when
          (not 
            (autstate_1_7))
          (not 
            (prev_autstate_1_7)))
        (when
          (not 
            (autstate_1_8))
          (not 
            (prev_autstate_1_8)))
        (when
          (not 
            (autstate_1_1))
          (not 
            (prev_autstate_1_1)))
      )
    )
  (:action unstack
    :parameters (?x0 - block ?x1 - block)
    :precondition 
      (and
        (on ?x0 ?x1)
        (clear ?x0)
        (emptyhand))
    :effect
      (and
        (holding ?x0)
        (clear ?x1)
        (when
          (autstate_1_2)
          (prev_autstate_1_2))
        (when
          (autstate_1_3)
          (prev_autstate_1_3))
        (when
          (autstate_1_4)
          (prev_autstate_1_4))
        (when
          (autstate_1_5)
          (prev_autstate_1_5))
        (when
          (autstate_1_6)
          (prev_autstate_1_6))
        (when
          (autstate_1_7)
          (prev_autstate_1_7))
        (when
          (autstate_1_8)
          (prev_autstate_1_8))
        (when
          (autstate_1_1)
          (prev_autstate_1_1))
        (not 
          (clear ?x0))
        (not 
          (emptyhand))
        (not 
          (on ?x0 ?x1))
        (when
          (not 
            (autstate_1_2))
          (not 
            (prev_autstate_1_2)))
        (when
          (not 
            (autstate_1_3))
          (not 
            (prev_autstate_1_3)))
        (when
          (not 
            (autstate_1_4))
          (not 
            (prev_autstate_1_4)))
        (when
          (not 
            (autstate_1_5))
          (not 
            (prev_autstate_1_5)))
        (when
          (not 
            (autstate_1_6))
          (not 
            (prev_autstate_1_6)))
        (when
          (not 
            (autstate_1_7))
          (not 
            (prev_autstate_1_7)))
        (when
          (not 
            (autstate_1_8))
          (not 
            (prev_autstate_1_8)))
        (when
          (not 
            (autstate_1_1))
          (not 
            (prev_autstate_1_1)))
      )
    )
(:derived 
    (autstate_1_2)
    (prev_autstate_1_2)
)

(:derived 
    (autstate_1_3)
    (or
      (and
        (prev_autstate_1_2)
        (on b2 b3))
      (prev_autstate_1_3))
)

(:derived 
    (autstate_1_4)
    (or
      (and
        (prev_autstate_1_2)
        (on b1 b2))
      (prev_autstate_1_4))
)

(:derived 
    (autstate_1_5)
    (or
      (and
        (prev_autstate_1_2)
        (on b1 b2)
        (on b2 b3))
      (and
        (prev_autstate_1_3)
        (on b1 b2))
      (and
        (prev_autstate_1_4)
        (on b2 b3))
      (prev_autstate_1_5))
)

(:derived 
    (autstate_1_6)
    (or
      (and
        (prev_autstate_1_2)
        (holding b4))
      (prev_autstate_1_6))
)

(:derived 
    (autstate_1_7)
    (or
      (and
        (prev_autstate_1_2)
        (holding b4)
        (on b2 b3))
      (and
        (prev_autstate_1_3)
        (holding b4))
      (and
        (prev_autstate_1_6)
        (on b2 b3))
      (prev_autstate_1_7))
)

(:derived 
    (autstate_1_8)
    (or
      (and
        (prev_autstate_1_2)
        (holding b4)
        (on b1 b2))
      (and
        (prev_autstate_1_4)
        (holding b4))
      (and
        (prev_autstate_1_6)
        (on b1 b2))
      (prev_autstate_1_8))
)

(:derived 
    (autstate_1_1)
    (or
      (and
        (prev_autstate_1_2)
        (holding b4)
        (on b1 b2)
        (on b2 b3))
      (and
        (prev_autstate_1_3)
        (holding b4)
        (on b1 b2))
      (and
        (prev_autstate_1_4)
        (holding b4)
        (on b2 b3))
      (and
        (prev_autstate_1_5)
        (holding b4))
      (and
        (prev_autstate_1_6)
        (on b1 b2)
        (on b2 b3))
      (and
        (prev_autstate_1_7)
        (on b1 b2))
      (and
        (prev_autstate_1_8)
        (on b2 b3))
      (prev_autstate_1_1))
)

(:derived 
    (aut_in_final_1)
    (autstate_1_1)
)

)