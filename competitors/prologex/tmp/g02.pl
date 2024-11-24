:- dynamic initially_true/1.

initially_true('not-made-p1').
initially_true('not-made-p2').
initially_true('not-made-p3').
initially_true('not-made-p4').
initially_true('not-made-p5').
initially_true('waiting-o5').
initially_true('waiting-o4').
initially_true('waiting-o3').
initially_true('waiting-o2').
initially_true('waiting-o1').
initially_true('stacks-avail-n0').
initially_true('machine-available').
initially_true(q_1).
initially_true(f_copy).
initially_true(f_ok).

:- dynamic constant/1.

constant(noobjects).

:- dynamic of_type/2.

of_type(noobjects, 'NO_TYPE').

:- dynamic goal/1.

goal(f_goal).

:- dynamic preference/2.


:- dynamic hard_constraint/1.


:- dynamic metric/2.


