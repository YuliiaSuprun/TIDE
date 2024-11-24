:- dynamic problem_name/1.

problem_name(bw_6).

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

goal(and(until(ontable(b1), on(b2, b3)), and(until(ontable(b1), on(b3, b4)), and(until(ontable(b1), on(b4, b5)), until(ontable(b1), holding(b1)))))).

:- dynamic preference/2.


:- dynamic hard_constraint/1.


:- dynamic metric/2.


