:- dynamic problem_name/1.

problem_name(bw_11).

:- dynamic initially_true/1.

initially_true(emptyhand).
initially_true(ontable(b1)).
initially_true(ontable(b2)).
initially_true(ontable(b3)).
initially_true(ontable(b4)).
initially_true(ontable(b5)).
initially_true(ontable(b6)).
initially_true(ontable(b7)).
initially_true(ontable(b8)).
initially_true(ontable(b9)).
initially_true(ontable(b10)).
initially_true(ontable(b11)).
initially_true(clear(b1)).
initially_true(clear(b2)).
initially_true(clear(b3)).
initially_true(clear(b4)).
initially_true(clear(b5)).
initially_true(clear(b6)).
initially_true(clear(b7)).
initially_true(clear(b8)).
initially_true(clear(b9)).
initially_true(clear(b10)).
initially_true(clear(b11)).

:- dynamic constant/1.

constant(b1).
constant(b10).
constant(b11).
constant(b2).
constant(b3).
constant(b4).
constant(b5).
constant(b6).
constant(b7).
constant(b8).
constant(b9).

:- dynamic of_type/2.

of_type(b1, block).
of_type(b2, block).
of_type(b3, block).
of_type(b4, block).
of_type(b5, block).
of_type(b6, block).
of_type(b7, block).
of_type(b8, block).
of_type(b9, block).
of_type(b10, block).
of_type(b11, block).

:- dynamic goal/1.

goal(and(eventually(and(on(b2, b1), next(eventually(and(on(b3, b2), and(next(eventually(on(b5, b4))), and(next(eventually(on(b7, b6))), and(next(eventually(on(b9, b8))), next(eventually(on(b11, b10))))))))))), eventually(and(on(b10, b11), next(eventually(and(on(b9, b10), next(eventually(and(on(b8, b9), next(eventually(and(on(b7, b8), next(eventually(and(on(b6, b7), next(eventually(and(on(b5, b6), next(eventually(and(on(b4, b5), next(eventually(and(on(b3, b4), next(eventually(and(on(b2, b3), next(eventually(on(b1, b2))))))))))))))))))))))))))))))).

:- dynamic preference/2.


:- dynamic hard_constraint/1.


:- dynamic metric/2.

