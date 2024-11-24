:- dynamic is_subtype/2.

is_subtype(block, 'NO_TYPE').

:- dynamic fluent/1.

fluent(ontable(_)).
fluent(on(_, _)).
fluent(clear(_)).
fluent(emptyhand).
fluent(holding(_)).
fluent(f_copy).
fluent(f_sync).
fluent(f_world).
fluent(f_ok).
fluent(f_goal).
fluent(q_1).
fluent(q_1s).
fluent(q_1t).
fluent(q_2).
fluent(q_2s).
fluent(q_2t).
fluent(q_3).
fluent(q_3s).
fluent(q_3t).
fluent(q_4).
fluent(q_4s).
fluent(q_4t).
fluent(q_5).
fluent(q_5s).
fluent(q_5t).
fluent(q_6).
fluent(q_6s).
fluent(q_6t).
fluent(q_7).
fluent(q_7s).
fluent(q_7t).
fluent(q_8).
fluent(q_8s).
fluent(q_8t).
fluent(q_9).
fluent(q_9s).
fluent(q_9t).
fluent(q_10).
fluent(q_10s).
fluent(q_10t).
fluent(q_11).
fluent(q_11s).
fluent(q_11t).
fluent(q_12).
fluent(q_12s).
fluent(q_12t).
fluent(q_13).
fluent(q_13s).
fluent(q_13t).
fluent(q_14).
fluent(q_14s).
fluent(q_14t).
fluent(q_15).
fluent(q_15s).
fluent(q_15t).
fluent(q_16).
fluent(q_16s).
fluent(q_16t).
fluent(q_17).
fluent(q_17s).
fluent(q_17t).
fluent(q_18).
fluent(q_18s).
fluent(q_18t).
fluent(q_19).
fluent(q_19s).
fluent(q_19t).

:- dynamic fluent_args/2.

fluent_args(ontable, [block]).
fluent_args(on, [block, block]).
fluent_args(clear, [block]).
fluent_args(emptyhand, []).
fluent_args(holding, [block]).
fluent_args(f_goal, []).
fluent_args(f_copy, []).
fluent_args(f_sync, []).
fluent_args(f_world, []).
fluent_args(f_ok, []).
fluent_args(q_1, []).
fluent_args(q_1s, []).
fluent_args(q_1t, []).
fluent_args(q_2, []).
fluent_args(q_2s, []).
fluent_args(q_2t, []).
fluent_args(q_3, []).
fluent_args(q_3s, []).
fluent_args(q_3t, []).
fluent_args(q_4, []).
fluent_args(q_4s, []).
fluent_args(q_4t, []).
fluent_args(q_5, []).
fluent_args(q_5s, []).
fluent_args(q_5t, []).
fluent_args(q_6, []).
fluent_args(q_6s, []).
fluent_args(q_6t, []).
fluent_args(q_7, []).
fluent_args(q_7s, []).
fluent_args(q_7t, []).
fluent_args(q_8, []).
fluent_args(q_8s, []).
fluent_args(q_8t, []).
fluent_args(q_9, []).
fluent_args(q_9s, []).
fluent_args(q_9t, []).
fluent_args(q_10, []).
fluent_args(q_10s, []).
fluent_args(q_10t, []).
fluent_args(q_11, []).
fluent_args(q_11s, []).
fluent_args(q_11t, []).
fluent_args(q_12, []).
fluent_args(q_12s, []).
fluent_args(q_12t, []).
fluent_args(q_13, []).
fluent_args(q_13s, []).
fluent_args(q_13t, []).
fluent_args(q_14, []).
fluent_args(q_14s, []).
fluent_args(q_14t, []).
fluent_args(q_15, []).
fluent_args(q_15s, []).
fluent_args(q_15t, []).
fluent_args(q_16, []).
fluent_args(q_16s, []).
fluent_args(q_16t, []).
fluent_args(q_17, []).
fluent_args(q_17s, []).
fluent_args(q_17t, []).
fluent_args(q_18, []).
fluent_args(q_18s, []).
fluent_args(q_18t, []).
fluent_args(q_19, []).
fluent_args(q_19s, []).
fluent_args(q_19t, []).

:- dynamic action/1.

action('pick-up'(_)).
action('put-down'(_)).
action(stack(_, _)).
action(unstack(_, _)).
action(o_copy).
action(o_goal).
action(o_sync_q_1s_1).
action(o_sync_q_1s_2).
action(o_sync_q_2s).
action(o_sync_q_3s).
action(o_sync_q_4s).
action(o_sync_q_5s).
action(o_sync_q_6s).
action(o_sync_q_7s_1).
action(o_sync_q_7s_2).
action(o_sync_q_8s_1).
action(o_sync_q_8s_2).
action(o_sync_q_9s_1).
action(o_sync_q_9s_2).
action(o_sync_q_10s_1).
action(o_sync_q_10s_2).
action(o_sync_q_11s_1).
action(o_sync_q_11s_2).
action(o_sync_q_12s).
action(o_sync_q_13s).
action(o_sync_q_14s).
action(o_sync_q_15s).
action(o_sync_q_16s).
action(o_sync_q_17s).
action(o_sync_q_18s).
action(o_sync_q_19s).

:- dynamic action_args/2.

action_args('pick-up', [block]).
action_args('put-down', [block]).
action_args(stack, [block, block]).
action_args(unstack, [block, block]).
action_args(o_copy, []).
action_args(o_goal, []).
action_args(o_sync_q_1s_1, []).
action_args(o_sync_q_1s_2, []).
action_args(o_sync_q_2s, []).
action_args(o_sync_q_3s, []).
action_args(o_sync_q_4s, []).
action_args(o_sync_q_5s, []).
action_args(o_sync_q_6s, []).
action_args(o_sync_q_7s_1, []).
action_args(o_sync_q_7s_2, []).
action_args(o_sync_q_8s_1, []).
action_args(o_sync_q_8s_2, []).
action_args(o_sync_q_9s_1, []).
action_args(o_sync_q_9s_2, []).
action_args(o_sync_q_10s_1, []).
action_args(o_sync_q_10s_2, []).
action_args(o_sync_q_11s_1, []).
action_args(o_sync_q_11s_2, []).
action_args(o_sync_q_12s, []).
action_args(o_sync_q_13s, []).
action_args(o_sync_q_14s, []).
action_args(o_sync_q_15s, []).
action_args(o_sync_q_16s, []).
action_args(o_sync_q_17s, []).
action_args(o_sync_q_18s, []).
action_args(o_sync_q_19s, []).

:- dynamic poss/2.

poss('pick-up'(A), and(and(clear(A), and(ontable(A), emptyhand)), and(f_ok, f_world))).
poss('put-down'(A), and(holding(A), and(f_ok, f_world))).
poss(stack(A, B), and(and(holding(A), clear(B)), and(f_ok, f_world))).
poss(unstack(A, B), and(and(on(A, B), and(clear(A), emptyhand)), and(f_ok, f_world))).
poss(o_copy, and(f_ok, f_copy)).
poss(o_goal, and(and(f_world, f_ok), and(not(q_1), and(not(q_2), and(not(q_3), and(not(q_4), and(not(q_5), and(not(q_6), and(not(q_7), and(not(q_8), and(not(q_9), and(not(q_10), and(not(q_11), and(not(q_12), and(not(q_13), and(not(q_14), and(not(q_15), and(not(q_16), and(not(q_17), not(q_18)))))))))))))))))))).
poss(o_sync_q_1s_1, and(and(f_sync, f_ok), q_1t)).
poss(o_sync_q_1s_2, and(and(f_sync, f_ok), q_1t)).
poss(o_sync_q_2s, and(and(f_sync, f_ok), q_2t)).
poss(o_sync_q_3s, and(and(f_sync, f_ok), q_3t)).
poss(o_sync_q_4s, and(and(f_sync, f_ok), q_4t)).
poss(o_sync_q_5s, and(and(f_sync, f_ok), q_5t)).
poss(o_sync_q_6s, and(and(f_sync, f_ok), q_6t)).
poss(o_sync_q_7s_1, and(and(f_sync, f_ok), q_7t)).
poss(o_sync_q_7s_2, and(and(f_sync, f_ok), q_7t)).
poss(o_sync_q_8s_1, and(and(f_sync, f_ok), q_8t)).
poss(o_sync_q_8s_2, and(and(f_sync, f_ok), q_8t)).
poss(o_sync_q_9s_1, and(and(f_sync, f_ok), q_9t)).
poss(o_sync_q_9s_2, and(and(f_sync, f_ok), q_9t)).
poss(o_sync_q_10s_1, and(and(f_sync, f_ok), q_10t)).
poss(o_sync_q_10s_2, and(and(f_sync, f_ok), q_10t)).
poss(o_sync_q_11s_1, and(and(f_sync, f_ok), q_11t)).
poss(o_sync_q_11s_2, and(and(f_sync, f_ok), q_11t)).
poss(o_sync_q_12s, and(and(f_sync, f_ok), q_12t)).
poss(o_sync_q_13s, and(and(f_sync, f_ok), q_13t)).
poss(o_sync_q_14s, and(and(f_sync, f_ok), q_14t)).
poss(o_sync_q_15s, and(and(f_sync, f_ok), q_15t)).
poss(o_sync_q_16s, and(and(f_sync, f_ok), q_16t)).
poss(o_sync_q_17s, and(and(f_sync, f_ok), q_17t)).
poss(o_sync_q_18s, and(and(f_sync, f_ok), q_18t)).
poss(o_sync_q_19s, and(and(f_sync, f_ok), q_19t)).

:- dynamic causes_true/3.

causes_true(holding(A), 'pick-up'(A), true).
causes_true(clear(A), 'put-down'(A), true).
causes_true(emptyhand, 'put-down'(_), true).
causes_true(ontable(A), 'put-down'(A), true).
causes_true(clear(A), stack(A, _), true).
causes_true(emptyhand, stack(_, _), true).
causes_true(on(A, B), stack(A, B), true).
causes_true(holding(A), unstack(A, _), true).
causes_true(clear(A), unstack(_, A), true).
causes_true(f_copy, 'pick-up'(_), true).
causes_true(f_copy, 'put-down'(_), true).
causes_true(f_copy, stack(_, _), true).
causes_true(f_copy, unstack(_, _), true).
causes_true(f_sync, o_copy, true).
causes_true(q_1t, o_copy, true).
causes_true(q_1s, o_copy, q_1).
causes_true(q_2s, o_copy, q_2).
causes_true(q_3s, o_copy, q_3).
causes_true(q_4s, o_copy, q_4).
causes_true(q_5s, o_copy, q_5).
causes_true(q_6s, o_copy, q_6).
causes_true(q_7s, o_copy, q_7).
causes_true(q_8s, o_copy, q_8).
causes_true(q_9s, o_copy, q_9).
causes_true(q_10s, o_copy, q_10).
causes_true(q_11s, o_copy, q_11).
causes_true(q_12s, o_copy, q_12).
causes_true(q_13s, o_copy, q_13).
causes_true(q_14s, o_copy, q_14).
causes_true(q_15s, o_copy, q_15).
causes_true(q_16s, o_copy, q_16).
causes_true(q_17s, o_copy, q_17).
causes_true(q_18s, o_copy, q_18).
causes_true(q_19s, o_copy, q_19).
causes_true(f_goal, o_goal, true).
causes_true(q_2s, o_sync_q_1s_1, q_1s).
causes_true(q_2t, o_sync_q_1s_1, true).
causes_true(q_18, o_sync_q_1s_2, q_1s).
causes_true(q_1, o_sync_q_1s_2, q_1s).
causes_true(q_2t, o_sync_q_1s_2, true).
causes_true(q_3s, o_sync_q_2s, q_2s).
causes_true(q_12s, o_sync_q_2s, q_2s).
causes_true(q_3t, o_sync_q_2s, true).
causes_true(q_11s, o_sync_q_3s, q_3s).
causes_true(q_4s, o_sync_q_3s, q_3s).
causes_true(q_4t, o_sync_q_3s, true).
causes_true(q_10s, o_sync_q_4s, q_4s).
causes_true(q_5s, o_sync_q_4s, q_4s).
causes_true(q_5t, o_sync_q_4s, true).
causes_true(q_9s, o_sync_q_5s, q_5s).
causes_true(q_6s, o_sync_q_5s, q_5s).
causes_true(q_6t, o_sync_q_5s, true).
causes_true(q_8s, o_sync_q_6s, q_6s).
causes_true(q_7s, o_sync_q_6s, q_6s).
causes_true(q_7t, o_sync_q_6s, true).
causes_true(q_13s, o_sync_q_7s_1, q_7s).
causes_true(q_8t, o_sync_q_7s_1, true).
causes_true(q_18, o_sync_q_7s_2, q_7s).
causes_true(q_7, o_sync_q_7s_2, q_7s).
causes_true(q_8t, o_sync_q_7s_2, true).
causes_true(q_14s, o_sync_q_8s_1, q_8s).
causes_true(q_9t, o_sync_q_8s_1, true).
causes_true(q_18, o_sync_q_8s_2, q_8s).
causes_true(q_8, o_sync_q_8s_2, q_8s).
causes_true(q_9t, o_sync_q_8s_2, true).
causes_true(q_15s, o_sync_q_9s_1, q_9s).
causes_true(q_10t, o_sync_q_9s_1, true).
causes_true(q_18, o_sync_q_9s_2, q_9s).
causes_true(q_9, o_sync_q_9s_2, q_9s).
causes_true(q_10t, o_sync_q_9s_2, true).
causes_true(q_16s, o_sync_q_10s_1, q_10s).
causes_true(q_11t, o_sync_q_10s_1, true).
causes_true(q_18, o_sync_q_10s_2, q_10s).
causes_true(q_10, o_sync_q_10s_2, q_10s).
causes_true(q_11t, o_sync_q_10s_2, true).
causes_true(q_17s, o_sync_q_11s_1, q_11s).
causes_true(q_12t, o_sync_q_11s_1, true).
causes_true(q_18, o_sync_q_11s_2, q_11s).
causes_true(q_11, o_sync_q_11s_2, q_11s).
causes_true(q_12t, o_sync_q_11s_2, true).
causes_true(q_13t, o_sync_q_12s, true).
causes_true(q_14t, o_sync_q_13s, true).
causes_true(q_15t, o_sync_q_14s, true).
causes_true(q_16t, o_sync_q_15s, true).
causes_true(q_17t, o_sync_q_16s, true).
causes_true(q_18t, o_sync_q_17s, true).
causes_true(q_19t, o_sync_q_18s, true).
causes_true(f_world, o_sync_q_19s, true).
causes_true(q_1, o_sync_q_19s, q_1s).
causes_true(q_2, o_sync_q_19s, q_2s).
causes_true(q_3, o_sync_q_19s, q_3s).
causes_true(q_4, o_sync_q_19s, q_4s).
causes_true(q_5, o_sync_q_19s, q_5s).
causes_true(q_6, o_sync_q_19s, q_6s).
causes_true(q_7, o_sync_q_19s, q_7s).
causes_true(q_8, o_sync_q_19s, q_8s).
causes_true(q_9, o_sync_q_19s, q_9s).
causes_true(q_10, o_sync_q_19s, q_10s).
causes_true(q_11, o_sync_q_19s, q_11s).
causes_true(q_12, o_sync_q_19s, q_12s).
causes_true(q_13, o_sync_q_19s, q_13s).
causes_true(q_14, o_sync_q_19s, q_14s).
causes_true(q_15, o_sync_q_19s, q_15s).
causes_true(q_16, o_sync_q_19s, q_16s).
causes_true(q_17, o_sync_q_19s, q_17s).
causes_true(q_18, o_sync_q_19s, q_18s).
causes_true(q_19, o_sync_q_19s, q_19s).

:- dynamic causes_false/3.

causes_false(ontable(A), 'pick-up'(A), true).
causes_false(clear(A), 'pick-up'(A), true).
causes_false(emptyhand, 'pick-up'(_), true).
causes_false(holding(A), 'put-down'(A), true).
causes_false(holding(A), stack(A, _), true).
causes_false(clear(A), stack(_, A), true).
causes_false(clear(A), unstack(A, _), true).
causes_false(emptyhand, unstack(_, _), true).
causes_false(on(A, B), unstack(A, B), true).
causes_false(f_world, 'pick-up'(_), true).
causes_false(f_world, 'put-down'(_), true).
causes_false(f_world, stack(_, _), true).
causes_false(f_world, unstack(_, _), true).
causes_false(f_copy, o_copy, true).
causes_false(q_1, o_copy, true).
causes_false(q_2, o_copy, true).
causes_false(q_3, o_copy, true).
causes_false(q_4, o_copy, true).
causes_false(q_5, o_copy, true).
causes_false(q_6, o_copy, true).
causes_false(q_7, o_copy, true).
causes_false(q_8, o_copy, true).
causes_false(q_9, o_copy, true).
causes_false(q_10, o_copy, true).
causes_false(q_11, o_copy, true).
causes_false(q_12, o_copy, true).
causes_false(q_13, o_copy, true).
causes_false(q_14, o_copy, true).
causes_false(q_15, o_copy, true).
causes_false(q_16, o_copy, true).
causes_false(q_17, o_copy, true).
causes_false(q_18, o_copy, true).
causes_false(q_19, o_copy, true).
causes_false(q_1s, o_sync_q_1s_1, q_1s).
causes_false(q_1t, o_sync_q_1s_1, true).
causes_false(q_1s, o_sync_q_1s_2, q_1s).
causes_false(q_1t, o_sync_q_1s_2, true).
causes_false(q_2s, o_sync_q_2s, q_2s).
causes_false(q_2t, o_sync_q_2s, true).
causes_false(q_3s, o_sync_q_3s, q_3s).
causes_false(q_3t, o_sync_q_3s, true).
causes_false(q_4s, o_sync_q_4s, q_4s).
causes_false(q_4t, o_sync_q_4s, true).
causes_false(q_5s, o_sync_q_5s, q_5s).
causes_false(q_5t, o_sync_q_5s, true).
causes_false(q_6s, o_sync_q_6s, q_6s).
causes_false(q_6t, o_sync_q_6s, true).
causes_false(q_7s, o_sync_q_7s_1, q_7s).
causes_false(q_7t, o_sync_q_7s_1, true).
causes_false(q_7s, o_sync_q_7s_2, q_7s).
causes_false(q_7t, o_sync_q_7s_2, true).
causes_false(q_8s, o_sync_q_8s_1, q_8s).
causes_false(q_8t, o_sync_q_8s_1, true).
causes_false(q_8s, o_sync_q_8s_2, q_8s).
causes_false(q_8t, o_sync_q_8s_2, true).
causes_false(q_9s, o_sync_q_9s_1, q_9s).
causes_false(q_9t, o_sync_q_9s_1, true).
causes_false(q_9s, o_sync_q_9s_2, q_9s).
causes_false(q_9t, o_sync_q_9s_2, true).
causes_false(q_10s, o_sync_q_10s_1, q_10s).
causes_false(q_10t, o_sync_q_10s_1, true).
causes_false(q_10s, o_sync_q_10s_2, q_10s).
causes_false(q_10t, o_sync_q_10s_2, true).
causes_false(q_11s, o_sync_q_11s_1, q_11s).
causes_false(q_11t, o_sync_q_11s_1, true).
causes_false(q_11s, o_sync_q_11s_2, q_11s).
causes_false(q_11t, o_sync_q_11s_2, true).
causes_false(q_12s, o_sync_q_12s, q_12s).
causes_false(f_ok, o_sync_q_12s, and(q_12s, not(on(b6, b1)))).
causes_false(q_12t, o_sync_q_12s, true).
causes_false(q_13s, o_sync_q_13s, q_13s).
causes_false(f_ok, o_sync_q_13s, and(q_13s, not(on(b5, b6)))).
causes_false(q_13t, o_sync_q_13s, true).
causes_false(q_14s, o_sync_q_14s, q_14s).
causes_false(f_ok, o_sync_q_14s, and(q_14s, not(on(b4, b5)))).
causes_false(q_14t, o_sync_q_14s, true).
causes_false(q_15s, o_sync_q_15s, q_15s).
causes_false(f_ok, o_sync_q_15s, and(q_15s, not(on(b3, b4)))).
causes_false(q_15t, o_sync_q_15s, true).
causes_false(q_16s, o_sync_q_16s, q_16s).
causes_false(f_ok, o_sync_q_16s, and(q_16s, not(on(b2, b3)))).
causes_false(q_16t, o_sync_q_16s, true).
causes_false(q_17s, o_sync_q_17s, q_17s).
causes_false(f_ok, o_sync_q_17s, and(q_17s, not(on(b1, b2)))).
causes_false(q_17t, o_sync_q_17s, true).
causes_false(q_18s, o_sync_q_18s, q_18s).
causes_false(q_18t, o_sync_q_18s, true).
causes_false(f_ok, o_sync_q_19s, q_19s).
causes_false(q_19t, o_sync_q_19s, true).
causes_false(f_sync, o_sync_q_19s, true).
causes_false(q_1s, o_sync_q_19s, true).
causes_false(q_2s, o_sync_q_19s, true).
causes_false(q_3s, o_sync_q_19s, true).
causes_false(q_4s, o_sync_q_19s, true).
causes_false(q_5s, o_sync_q_19s, true).
causes_false(q_6s, o_sync_q_19s, true).
causes_false(q_7s, o_sync_q_19s, true).
causes_false(q_8s, o_sync_q_19s, true).
causes_false(q_9s, o_sync_q_19s, true).
causes_false(q_10s, o_sync_q_19s, true).
causes_false(q_11s, o_sync_q_19s, true).
causes_false(q_12s, o_sync_q_19s, true).
causes_false(q_13s, o_sync_q_19s, true).
causes_false(q_14s, o_sync_q_19s, true).
causes_false(q_15s, o_sync_q_19s, true).
causes_false(q_16s, o_sync_q_19s, true).
causes_false(q_17s, o_sync_q_19s, true).
causes_false(q_18s, o_sync_q_19s, true).
causes_false(q_19s, o_sync_q_19s, true).

