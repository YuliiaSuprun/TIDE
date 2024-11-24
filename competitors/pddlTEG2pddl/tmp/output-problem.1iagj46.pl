:- dynamic problem_name/1.

problem_name(bw_chain).

:- dynamic initially_true/1.

initially_true(emptyhand).
initially_true(ontable(b1)).
initially_true(ontable(b2)).
initially_true(ontable(b3)).
initially_true(ontable(b4)).
initially_true(clear(b1)).
initially_true(clear(b2)).
initially_true(clear(b3)).
initially_true(clear(b4)).

:- dynamic constant/1.

constant(b1).
constant(b2).
constant(b3).
constant(b4).

:- dynamic of_type/2.

of_type(b1, block).
of_type(b2, block).
of_type(b3, block).
of_type(b4, block).

:- dynamic goal/1.

goal(and(eventually(clear(b1)), and(always(or(not(clear(b1)), and(eventually(clear(b2)), always(or(not(clear(b1)), and(eventually(clear(b2)), always(or(not(clear(b2)), eventually(holding(b3)))))))))), always(not(holding(b4)))))).

:- dynamic preference/2.


:- dynamic hard_constraint/1.


:- dynamic metric/2.


