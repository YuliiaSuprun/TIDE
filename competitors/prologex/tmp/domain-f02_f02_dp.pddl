(define (domain 'domain-f02')
  (:types
    rover - NO_TYPE
    waypoint - NO_TYPE
    store - NO_TYPE
    camera - NO_TYPE
    mode - NO_TYPE
    lander - NO_TYPE
    objective - NO_TYPE
  )

  (:predicates
    (at ?x0 - rover ?x1 - waypoint)
    (at_lander ?x0 - lander ?x1 - waypoint)
    (can_traverse ?x0 - rover ?x1 - waypoint ?x2 - waypoint)
    (equipped_for_soil_analysis ?x0 - rover)
    (equipped_for_rock_analysis ?x0 - rover)
    (equipped_for_imaging ?x0 - rover)
    (empty ?x0 - store)
    (have_rock_analysis ?x0 - rover ?x1 - waypoint)
    (have_soil_analysis ?x0 - rover ?x1 - waypoint)
    (full ?x0 - store)
    (calibrated ?x0 - camera ?x1 - rover)
    (supports ?x0 - camera ?x1 - mode)
    (available ?x0 - rover)
    (visible ?x0 - waypoint ?x1 - waypoint)
    (have_image ?x0 - rover ?x1 - objective ?x2 - mode)
    (communicated_soil_data ?x0 - waypoint)
    (communicated_rock_data ?x0 - waypoint)
    (communicated_image_data ?x0 - objective ?x1 - mode)
    (at_soil_sample ?x0 - waypoint)
    (at_rock_sample ?x0 - waypoint)
    (visible_from ?x0 - objective ?x1 - waypoint)
    (store_of ?x0 - store ?x1 - rover)
    (calibration_target ?x0 - camera ?x1 - objective)
    (on_board ?x0 - camera ?x1 - rover)
    (channel_free ?x0 - lander)
    (f_copy)
    (f_sync)
    (f_world)
    (f_ok)
    (f_goal)
    (q_1)
    (q_1s)
    (q_1t)
    (q_2)
    (q_2s)
    (q_2t)
    (q_3)
    (q_3s)
    (q_3t)
    (q_4)
    (q_4s)
    (q_4t)
    (q_5)
    (q_5s)
    (q_5t)
    (q_6)
    (q_6s)
    (q_6t)
    (q_7)
    (q_7s)
    (q_7t)
  )
  (:action navigate
    :parameters (?x0 - rover ?x1 - waypoint ?x2 - waypoint)
    :precondition 
      (and
        (can_traverse ?x0 ?x1 ?x2)
        (available ?x0)
        (at ?x0 ?x1)
        (visible ?x1 ?x2)
        (f_ok)
        (f_world))
    :effect
      (and
        (at ?x0 ?x2)
        (f_copy)
        (not 
          (at ?x0 ?x1))
        (not 
          (f_world))
      )
    )
  (:action sample_soil
    :parameters (?x0 - rover ?x1 - store ?x2 - waypoint)
    :precondition 
      (and
        (at ?x0 ?x2)
        (at_soil_sample ?x2)
        (equipped_for_soil_analysis ?x0)
        (store_of ?x1 ?x0)
        (empty ?x1)
        (f_ok)
        (f_world))
    :effect
      (and
        (full ?x1)
        (have_soil_analysis ?x0 ?x2)
        (f_copy)
        (not 
          (empty ?x1))
        (not 
          (at_soil_sample ?x2))
        (not 
          (f_world))
      )
    )
  (:action sample_rock
    :parameters (?x0 - rover ?x1 - store ?x2 - waypoint)
    :precondition 
      (and
        (at ?x0 ?x2)
        (at_rock_sample ?x2)
        (equipped_for_rock_analysis ?x0)
        (store_of ?x1 ?x0)
        (empty ?x1)
        (f_ok)
        (f_world))
    :effect
      (and
        (full ?x1)
        (have_rock_analysis ?x0 ?x2)
        (f_copy)
        (not 
          (empty ?x1))
        (not 
          (at_rock_sample ?x2))
        (not 
          (f_world))
      )
    )
  (:action drop
    :parameters (?x0 - rover ?x1 - store)
    :precondition 
      (and
        (store_of ?x1 ?x0)
        (full ?x1)
        (f_ok)
        (f_world))
    :effect
      (and
        (empty ?x1)
        (f_copy)
        (not 
          (full ?x1))
        (not 
          (f_world))
      )
    )
  (:action calibrate
    :parameters (?x0 - rover ?x1 - camera ?x2 - objective ?x3 - waypoint)
    :precondition 
      (and
        (equipped_for_imaging ?x0)
        (calibration_target ?x1 ?x2)
        (at ?x0 ?x3)
        (visible_from ?x2 ?x3)
        (on_board ?x1 ?x0)
        (f_ok)
        (f_world))
    :effect
      (and
        (calibrated ?x1 ?x0)
        (f_copy)
        (not 
          (f_world))
      )
    )
  (:action take_image
    :parameters (?x0 - rover ?x1 - waypoint ?x2 - objective ?x3 - camera ?x4 - mode)
    :precondition 
      (and
        (calibrated ?x3 ?x0)
        (on_board ?x3 ?x0)
        (equipped_for_imaging ?x0)
        (supports ?x3 ?x4)
        (visible_from ?x2 ?x1)
        (at ?x0 ?x1)
        (f_ok)
        (f_world))
    :effect
      (and
        (have_image ?x0 ?x2 ?x4)
        (f_copy)
        (not 
          (calibrated ?x3 ?x0))
        (not 
          (f_world))
      )
    )
  (:action communicate_soil_data
    :parameters (?x0 - rover ?x1 - lander ?x2 - waypoint ?x3 - waypoint ?x4 - waypoint)
    :precondition 
      (and
        (at ?x0 ?x3)
        (at_lander ?x1 ?x4)
        (have_soil_analysis ?x0 ?x2)
        (visible ?x3 ?x4)
        (available ?x0)
        (channel_free ?x1)
        (f_ok)
        (f_world))
    :effect
      (and
        (channel_free ?x1)
        (communicated_soil_data ?x2)
        (available ?x0)
        (f_copy)
        (not 
          (available ?x0))
        (not 
          (channel_free ?x1))
        (not 
          (f_world))
      )
    )
  (:action communicate_rock_data
    :parameters (?x0 - rover ?x1 - lander ?x2 - waypoint ?x3 - waypoint ?x4 - waypoint)
    :precondition 
      (and
        (at ?x0 ?x3)
        (at_lander ?x1 ?x4)
        (have_rock_analysis ?x0 ?x2)
        (visible ?x3 ?x4)
        (available ?x0)
        (channel_free ?x1)
        (f_ok)
        (f_world))
    :effect
      (and
        (channel_free ?x1)
        (communicated_rock_data ?x2)
        (available ?x0)
        (f_copy)
        (not 
          (available ?x0))
        (not 
          (channel_free ?x1))
        (not 
          (f_world))
      )
    )
  (:action communicate_image_data
    :parameters (?x0 - rover ?x1 - lander ?x2 - objective ?x3 - mode ?x4 - waypoint ?x5 - waypoint)
    :precondition 
      (and
        (at ?x0 ?x4)
        (at_lander ?x1 ?x5)
        (have_image ?x0 ?x2 ?x3)
        (visible ?x4 ?x5)
        (available ?x0)
        (channel_free ?x1)
        (f_ok)
        (f_world))
    :effect
      (and
        (channel_free ?x1)
        (communicated_image_data ?x2 ?x3)
        (available ?x0)
        (f_copy)
        (not 
          (available ?x0))
        (not 
          (channel_free ?x1))
        (not 
          (f_world))
      )
    )
  (:action o_copy
    :parameters ()
    :precondition 
      (and
        (f_ok)
        (f_copy))
    :effect
      (and
        (f_sync)
        (q_1t)
        (when
          (q_1)
          (q_1s))
        (when
          (q_2)
          (q_2s))
        (when
          (q_3)
          (q_3s))
        (when
          (q_4)
          (q_4s))
        (when
          (q_5)
          (q_5s))
        (when
          (q_6)
          (q_6s))
        (when
          (q_7)
          (q_7s))
        (not 
          (f_copy))
        (not 
          (q_1))
        (not 
          (q_2))
        (not 
          (q_3))
        (not 
          (q_4))
        (not 
          (q_5))
        (not 
          (q_6))
        (not 
          (q_7))
      )
    )
  (:action o_goal
    :parameters ()
    :precondition 
      (and
        (f_world)
        (f_ok)
        (not 
          (q_1))
        (not 
          (q_2))
        (not 
          (q_3))
        (not 
          (q_4))
        (not 
          (q_5))
        (not 
          (q_6)))
    :effect
(f_goal)    )
  (:action o_sync_q_1s
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_1t))
    :effect
      (and
        (when
          (q_1s)
          (q_3s))
        (when
          (q_1s)
          (q_2s))
        (q_2t)
        (when
          (q_1s)
          (not 
            (q_1s)))
        (not 
          (q_1t))
      )
    )
  (:action o_sync_q_2s_1
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_2t))
    :effect
      (and
        (when
          (q_2s)
          (q_4s))
        (q_3t)
        (when
          (q_2s)
          (not 
            (q_2s)))
        (not 
          (q_2t))
      )
    )
  (:action o_sync_q_2s_2
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_2t))
    :effect
      (and
        (when
          (q_2s)
          (q_6))
        (when
          (q_2s)
          (q_2))
        (q_3t)
        (when
          (q_2s)
          (not 
            (q_2s)))
        (not 
          (q_2t))
      )
    )
  (:action o_sync_q_3s_1
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_3t))
    :effect
      (and
        (when
          (q_3s)
          (q_5s))
        (q_4t)
        (when
          (q_3s)
          (not 
            (q_3s)))
        (not 
          (q_3t))
      )
    )
  (:action o_sync_q_3s_2
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_3t))
    :effect
      (and
        (when
          (q_3s)
          (q_6))
        (when
          (q_3s)
          (q_3))
        (q_4t)
        (when
          (q_3s)
          (not 
            (q_3s)))
        (not 
          (q_3t))
      )
    )
  (:action o_sync_q_4s
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_4t))
    :effect
      (and
        (q_5t)
        (when
          (q_4s)
          (not 
            (q_4s)))
        (when
          (and
            (q_4s)
            (not 
              (communicated_soil_data waypoint2)))
          (not 
            (f_ok)))
        (not 
          (q_4t))
      )
    )
  (:action o_sync_q_5s
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_5t))
    :effect
      (and
        (q_6t)
        (when
          (q_5s)
          (not 
            (q_5s)))
        (when
          (and
            (q_5s)
            (not 
              (communicated_soil_data waypoint1)))
          (not 
            (f_ok)))
        (not 
          (q_5t))
      )
    )
  (:action o_sync_q_6s
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_6t))
    :effect
      (and
        (q_7t)
        (when
          (q_6s)
          (not 
            (q_6s)))
        (not 
          (q_6t))
      )
    )
  (:action o_sync_q_7s
    :parameters ()
    :precondition 
      (and
        (f_sync)
        (f_ok)
        (q_7t))
    :effect
      (and
        (f_world)
        (when
          (q_1s)
          (q_1))
        (when
          (q_2s)
          (q_2))
        (when
          (q_3s)
          (q_3))
        (when
          (q_4s)
          (q_4))
        (when
          (q_5s)
          (q_5))
        (when
          (q_6s)
          (q_6))
        (when
          (q_7s)
          (q_7))
        (when
          (q_7s)
          (not 
            (f_ok)))
        (not 
          (q_7t))
        (not 
          (f_sync))
        (not 
          (q_1s))
        (not 
          (q_2s))
        (not 
          (q_3s))
        (not 
          (q_4s))
        (not 
          (q_5s))
        (not 
          (q_6s))
        (not 
          (q_7s))
      )
    )
)