:- dynamic initially_true/1.

initially_true(emptyhand).
initially_true(ontable(b1)).
initially_true(ontable(b2)).
initially_true(ontable(b3)).
initially_true(ontable(b4)).
initially_true(ontable(b5)).
initially_true(ontable(b6)).
initially_true(clear(b1)).
initially_true(clear(b2)).
initially_true(clear(b3)).
initially_true(clear(b4)).
initially_true(clear(b5)).
initially_true(clear(b6)).
initially_true(q_1).
initially_true(f_copy).
initially_true(f_ok).

:- dynamic constant/1.

constant(b1).
constant(b2).
constant(b3).
constant(b4).
constant(b5).
constant(b6).

:- dynamic of_type/2.

of_type(b1, block).
of_type(b2, block).
of_type(b3, block).
of_type(b4, block).
of_type(b5, block).
of_type(b6, block).

:- dynamic goal/1.

goal(f_goal).

:- dynamic preference/2.


:- dynamic hard_constraint/1.


:- dynamic metric/2.


