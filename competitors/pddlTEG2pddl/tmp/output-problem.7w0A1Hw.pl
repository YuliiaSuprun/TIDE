:- dynamic problem_name/1.

problem_name(bw_22).

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
initially_true(ontable(b12)).
initially_true(ontable(b13)).
initially_true(ontable(b14)).
initially_true(ontable(b15)).
initially_true(ontable(b16)).
initially_true(ontable(b17)).
initially_true(ontable(b18)).
initially_true(ontable(b19)).
initially_true(ontable(b20)).
initially_true(ontable(b21)).
initially_true(ontable(b22)).
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
initially_true(clear(b12)).
initially_true(clear(b13)).
initially_true(clear(b14)).
initially_true(clear(b15)).
initially_true(clear(b16)).
initially_true(clear(b17)).
initially_true(clear(b18)).
initially_true(clear(b19)).
initially_true(clear(b20)).
initially_true(clear(b21)).
initially_true(clear(b22)).

:- dynamic constant/1.

constant(b1).
constant(b10).
constant(b11).
constant(b12).
constant(b13).
constant(b14).
constant(b15).
constant(b16).
constant(b17).
constant(b18).
constant(b19).
constant(b2).
constant(b20).
constant(b21).
constant(b22).
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
of_type(b12, block).
of_type(b13, block).
of_type(b14, block).
of_type(b15, block).
of_type(b16, block).
of_type(b17, block).
of_type(b18, block).
of_type(b19, block).
of_type(b20, block).
of_type(b21, block).
of_type(b22, block).

:- dynamic goal/1.

goal(and(eventually(and(on(b2, b1), next(eventually(and(on(b3, b2), next(eventually(and(on(b4, b3), and(next(eventually(on(b6, b5))), and(next(eventually(on(b8, b7))), and(next(eventually(on(b10, b9))), and(next(eventually(on(b12, b11))), and(next(eventually(on(b14, b13))), and(next(eventually(on(b16, b15))), and(next(eventually(on(b18, b17))), and(next(eventually(on(b20, b19))), next(eventually(on(b22, b21))))))))))))))))))), eventually(and(on(b21, b22), next(eventually(and(on(b20, b21), next(eventually(and(on(b19, b20), next(eventually(and(on(b18, b19), next(eventually(and(on(b17, b18), next(eventually(and(on(b16, b17), next(eventually(and(on(b15, b16), next(eventually(and(on(b14, b15), next(eventually(and(on(b13, b14), next(eventually(and(on(b12, b13), next(eventually(and(on(b11, b12), next(eventually(and(on(b10, b11), next(eventually(and(on(b9, b10), next(eventually(and(on(b8, b9), next(eventually(and(on(b7, b8), next(eventually(and(on(b6, b7), next(eventually(and(on(b5, b6), next(eventually(and(on(b4, b5), next(eventually(and(on(b3, b4), next(eventually(and(on(b2, b3), next(eventually(on(b1, b2)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))).

:- dynamic preference/2.


:- dynamic hard_constraint/1.


:- dynamic metric/2.

