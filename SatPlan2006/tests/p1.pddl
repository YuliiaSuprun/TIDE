(define (problem blocks-problem)
  (:domain blocks-domain)
  (:objects
      A B - block)
  (:init
      (ontable A)
      (ontable B)
      (clear A)
      (clear B)
      (emptyhand))
  (:goal
      (and (holding A)))
)
