:- dynamic is_subtype/2.


:- dynamic fluent/1.

fluent('machine-configured-p1').
fluent('machine-configured-p2').
fluent('machine-configured-p3').
fluent('machine-configured-p4').
fluent('machine-configured-p5').
fluent('stacks-avail-n1').
fluent('started-o1').
fluent('started-o2').
fluent('started-o3').
fluent('started-o4').
fluent('started-o5').
fluent('stacks-avail-n2').
fluent('made-p1').
fluent('made-p2').
fluent('made-p3').
fluent('made-p4').
fluent('made-p5').
fluent('shipped-o1').
fluent('stacks-avail-n3').
fluent('stacks-avail-n4').
fluent('stacks-avail-n5').
fluent('shipped-o2').
fluent('shipped-o3').
fluent('shipped-o4').
fluent('shipped-o5').
fluent('not-made-p5').
fluent('not-made-p4').
fluent('not-made-p3').
fluent('not-made-p2').
fluent('not-made-p1').
fluent('waiting-o5').
fluent('waiting-o4').
fluent('waiting-o3').
fluent('waiting-o2').
fluent('waiting-o1').
fluent('machine-available').
fluent('stacks-avail-n0').
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

:- dynamic fluent_args/2.

fluent_args('machine-configured-p1', []).
fluent_args('machine-configured-p2', []).
fluent_args('machine-configured-p3', []).
fluent_args('machine-configured-p4', []).
fluent_args('machine-configured-p5', []).
fluent_args('stacks-avail-n1', []).
fluent_args('started-o1', []).
fluent_args('started-o2', []).
fluent_args('started-o3', []).
fluent_args('started-o4', []).
fluent_args('started-o5', []).
fluent_args('stacks-avail-n2', []).
fluent_args('made-p1', []).
fluent_args('made-p2', []).
fluent_args('made-p3', []).
fluent_args('made-p4', []).
fluent_args('made-p5', []).
fluent_args('shipped-o1', []).
fluent_args('stacks-avail-n3', []).
fluent_args('stacks-avail-n4', []).
fluent_args('stacks-avail-n5', []).
fluent_args('shipped-o2', []).
fluent_args('shipped-o3', []).
fluent_args('shipped-o4', []).
fluent_args('shipped-o5', []).
fluent_args('not-made-p5', []).
fluent_args('not-made-p4', []).
fluent_args('not-made-p3', []).
fluent_args('not-made-p2', []).
fluent_args('not-made-p1', []).
fluent_args('waiting-o5', []).
fluent_args('waiting-o4', []).
fluent_args('waiting-o3', []).
fluent_args('waiting-o2', []).
fluent_args('waiting-o1', []).
fluent_args('machine-available', []).
fluent_args('stacks-avail-n0', []).
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

:- dynamic action/1.

action('make-product-p5-n5').
action('make-product-p5-n4').
action('make-product-p5-n3').
action('make-product-p4-n5').
action('make-product-p4-n4').
action('make-product-p4-n3').
action('make-product-p3-n5').
action('make-product-p3-n4').
action('make-product-p3-n3').
action('make-product-p2-n5').
action('make-product-p2-n4').
action('make-product-p2-n3').
action('make-product-p1-n5').
action('make-product-p1-n4').
action('make-product-p1-n3').
action('open-new-stack-n2-n3').
action('open-new-stack-n3-n4').
action('open-new-stack-n4-n5').
action('start-order-o5-n2-n1').
action('start-order-o4-n2-n1').
action('start-order-o3-n2-n1').
action('start-order-o2-n2-n1').
action('start-order-o1-n2-n1').
action('start-order-o5-n3-n2').
action('start-order-o4-n3-n2').
action('start-order-o3-n3-n2').
action('start-order-o2-n3-n2').
action('start-order-o1-n3-n2').
action('start-order-o5-n4-n3').
action('start-order-o4-n4-n3').
action('start-order-o3-n4-n3').
action('start-order-o2-n4-n3').
action('start-order-o1-n4-n3').
action('start-order-o5-n5-n4').
action('start-order-o4-n5-n4').
action('start-order-o3-n5-n4').
action('start-order-o2-n5-n4').
action('start-order-o1-n5-n4').
action('setup-machine-p5-n5').
action('setup-machine-p5-n4').
action('setup-machine-p5-n3').
action('setup-machine-p5-n2').
action('setup-machine-p4-n5').
action('setup-machine-p4-n4').
action('setup-machine-p4-n3').
action('setup-machine-p4-n2').
action('setup-machine-p3-n5').
action('setup-machine-p3-n4').
action('setup-machine-p3-n3').
action('setup-machine-p3-n2').
action('setup-machine-p2-n5').
action('setup-machine-p2-n4').
action('setup-machine-p2-n3').
action('setup-machine-p2-n2').
action('setup-machine-p1-n5').
action('setup-machine-p1-n4').
action('setup-machine-p1-n3').
action('setup-machine-p1-n2').
action('ship-order-o5-n4-n5').
action('ship-order-o5-n3-n4').
action('ship-order-o5-n2-n3').
action('ship-order-o5-n1-n2').
action('ship-order-o5-n0-n1').
action('ship-order-o4-n4-n5').
action('ship-order-o4-n3-n4').
action('ship-order-o4-n2-n3').
action('ship-order-o4-n1-n2').
action('ship-order-o4-n0-n1').
action('ship-order-o3-n4-n5').
action('ship-order-o3-n3-n4').
action('ship-order-o3-n2-n3').
action('ship-order-o3-n1-n2').
action('ship-order-o3-n0-n1').
action('ship-order-o2-n4-n5').
action('ship-order-o2-n3-n4').
action('ship-order-o2-n2-n3').
action('ship-order-o2-n1-n2').
action('ship-order-o2-n0-n1').
action('ship-order-o1-n4-n5').
action('ship-order-o1-n3-n4').
action('ship-order-o1-n2-n3').
action('ship-order-o1-n1-n2').
action('ship-order-o1-n0-n1').
action('make-product-p5-n2').
action('make-product-p5-n1').
action('make-product-p5-n0').
action('make-product-p4-n2').
action('make-product-p4-n1').
action('make-product-p4-n0').
action('make-product-p3-n2').
action('make-product-p3-n1').
action('make-product-p3-n0').
action('make-product-p2-n2').
action('make-product-p2-n1').
action('make-product-p2-n0').
action('make-product-p1-n2').
action('make-product-p1-n1').
action('make-product-p1-n0').
action('open-new-stack-n1-n2').
action('start-order-o5-n1-n0').
action('start-order-o4-n1-n0').
action('start-order-o3-n1-n0').
action('start-order-o2-n1-n0').
action('start-order-o1-n1-n0').
action('setup-machine-p5-n1').
action('setup-machine-p4-n1').
action('setup-machine-p3-n1').
action('setup-machine-p2-n1').
action('setup-machine-p1-n1').
action('open-new-stack-n0-n1').
action('setup-machine-p5-n0').
action('setup-machine-p4-n0').
action('setup-machine-p3-n0').
action('setup-machine-p2-n0').
action('setup-machine-p1-n0').
action(o_copy).
action(o_goal).
action(o_sync_q_1s).
action(o_sync_q_2s).
action(o_sync_q_3s).
action(o_sync_q_4s).
action(o_sync_q_5s_1).
action(o_sync_q_5s_2).
action(o_sync_q_6s_1).
action(o_sync_q_6s_2).
action(o_sync_q_7s_1).
action(o_sync_q_7s_2).
action(o_sync_q_8s_1).
action(o_sync_q_8s_2).
action(o_sync_q_9s_1).
action(o_sync_q_9s_2).
action(o_sync_q_10s).
action(o_sync_q_11s).
action(o_sync_q_12s).
action(o_sync_q_13s).
action(o_sync_q_14s).
action(o_sync_q_15s).
action(o_sync_q_16s).

:- dynamic action_args/2.

action_args('make-product-p5-n5', []).
action_args('make-product-p5-n4', []).
action_args('make-product-p5-n3', []).
action_args('make-product-p4-n5', []).
action_args('make-product-p4-n4', []).
action_args('make-product-p4-n3', []).
action_args('make-product-p3-n5', []).
action_args('make-product-p3-n4', []).
action_args('make-product-p3-n3', []).
action_args('make-product-p2-n5', []).
action_args('make-product-p2-n4', []).
action_args('make-product-p2-n3', []).
action_args('make-product-p1-n5', []).
action_args('make-product-p1-n4', []).
action_args('make-product-p1-n3', []).
action_args('open-new-stack-n2-n3', []).
action_args('open-new-stack-n3-n4', []).
action_args('open-new-stack-n4-n5', []).
action_args('start-order-o5-n2-n1', []).
action_args('start-order-o4-n2-n1', []).
action_args('start-order-o3-n2-n1', []).
action_args('start-order-o2-n2-n1', []).
action_args('start-order-o1-n2-n1', []).
action_args('start-order-o5-n3-n2', []).
action_args('start-order-o4-n3-n2', []).
action_args('start-order-o3-n3-n2', []).
action_args('start-order-o2-n3-n2', []).
action_args('start-order-o1-n3-n2', []).
action_args('start-order-o5-n4-n3', []).
action_args('start-order-o4-n4-n3', []).
action_args('start-order-o3-n4-n3', []).
action_args('start-order-o2-n4-n3', []).
action_args('start-order-o1-n4-n3', []).
action_args('start-order-o5-n5-n4', []).
action_args('start-order-o4-n5-n4', []).
action_args('start-order-o3-n5-n4', []).
action_args('start-order-o2-n5-n4', []).
action_args('start-order-o1-n5-n4', []).
action_args('setup-machine-p5-n5', []).
action_args('setup-machine-p5-n4', []).
action_args('setup-machine-p5-n3', []).
action_args('setup-machine-p5-n2', []).
action_args('setup-machine-p4-n5', []).
action_args('setup-machine-p4-n4', []).
action_args('setup-machine-p4-n3', []).
action_args('setup-machine-p4-n2', []).
action_args('setup-machine-p3-n5', []).
action_args('setup-machine-p3-n4', []).
action_args('setup-machine-p3-n3', []).
action_args('setup-machine-p3-n2', []).
action_args('setup-machine-p2-n5', []).
action_args('setup-machine-p2-n4', []).
action_args('setup-machine-p2-n3', []).
action_args('setup-machine-p2-n2', []).
action_args('setup-machine-p1-n5', []).
action_args('setup-machine-p1-n4', []).
action_args('setup-machine-p1-n3', []).
action_args('setup-machine-p1-n2', []).
action_args('ship-order-o5-n4-n5', []).
action_args('ship-order-o5-n3-n4', []).
action_args('ship-order-o5-n2-n3', []).
action_args('ship-order-o5-n1-n2', []).
action_args('ship-order-o5-n0-n1', []).
action_args('ship-order-o4-n4-n5', []).
action_args('ship-order-o4-n3-n4', []).
action_args('ship-order-o4-n2-n3', []).
action_args('ship-order-o4-n1-n2', []).
action_args('ship-order-o4-n0-n1', []).
action_args('ship-order-o3-n4-n5', []).
action_args('ship-order-o3-n3-n4', []).
action_args('ship-order-o3-n2-n3', []).
action_args('ship-order-o3-n1-n2', []).
action_args('ship-order-o3-n0-n1', []).
action_args('ship-order-o2-n4-n5', []).
action_args('ship-order-o2-n3-n4', []).
action_args('ship-order-o2-n2-n3', []).
action_args('ship-order-o2-n1-n2', []).
action_args('ship-order-o2-n0-n1', []).
action_args('ship-order-o1-n4-n5', []).
action_args('ship-order-o1-n3-n4', []).
action_args('ship-order-o1-n2-n3', []).
action_args('ship-order-o1-n1-n2', []).
action_args('ship-order-o1-n0-n1', []).
action_args('make-product-p5-n2', []).
action_args('make-product-p5-n1', []).
action_args('make-product-p5-n0', []).
action_args('make-product-p4-n2', []).
action_args('make-product-p4-n1', []).
action_args('make-product-p4-n0', []).
action_args('make-product-p3-n2', []).
action_args('make-product-p3-n1', []).
action_args('make-product-p3-n0', []).
action_args('make-product-p2-n2', []).
action_args('make-product-p2-n1', []).
action_args('make-product-p2-n0', []).
action_args('make-product-p1-n2', []).
action_args('make-product-p1-n1', []).
action_args('make-product-p1-n0', []).
action_args('open-new-stack-n1-n2', []).
action_args('start-order-o5-n1-n0', []).
action_args('start-order-o4-n1-n0', []).
action_args('start-order-o3-n1-n0', []).
action_args('start-order-o2-n1-n0', []).
action_args('start-order-o1-n1-n0', []).
action_args('setup-machine-p5-n1', []).
action_args('setup-machine-p4-n1', []).
action_args('setup-machine-p3-n1', []).
action_args('setup-machine-p2-n1', []).
action_args('setup-machine-p1-n1', []).
action_args('open-new-stack-n0-n1', []).
action_args('setup-machine-p5-n0', []).
action_args('setup-machine-p4-n0', []).
action_args('setup-machine-p3-n0', []).
action_args('setup-machine-p2-n0', []).
action_args('setup-machine-p1-n0', []).
action_args(o_copy, []).
action_args(o_goal, []).
action_args(o_sync_q_1s, []).
action_args(o_sync_q_2s, []).
action_args(o_sync_q_3s, []).
action_args(o_sync_q_4s, []).
action_args(o_sync_q_5s_1, []).
action_args(o_sync_q_5s_2, []).
action_args(o_sync_q_6s_1, []).
action_args(o_sync_q_6s_2, []).
action_args(o_sync_q_7s_1, []).
action_args(o_sync_q_7s_2, []).
action_args(o_sync_q_8s_1, []).
action_args(o_sync_q_8s_2, []).
action_args(o_sync_q_9s_1, []).
action_args(o_sync_q_9s_2, []).
action_args(o_sync_q_10s, []).
action_args(o_sync_q_11s, []).
action_args(o_sync_q_12s, []).
action_args(o_sync_q_13s, []).
action_args(o_sync_q_14s, []).
action_args(o_sync_q_15s, []).
action_args(o_sync_q_16s, []).

:- dynamic poss/2.

poss('make-product-p5-n5', and(and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n5'))), and(f_ok, f_world))).
poss('make-product-p5-n4', and(and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('make-product-p5-n3', and(and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('make-product-p4-n5', and(and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n5'))), and(f_ok, f_world))).
poss('make-product-p4-n4', and(and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('make-product-p4-n3', and(and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('make-product-p3-n5', and(and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n5'))), and(f_ok, f_world))).
poss('make-product-p3-n4', and(and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('make-product-p3-n3', and(and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('make-product-p2-n5', and(and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n5'))), and(f_ok, f_world))).
poss('make-product-p2-n4', and(and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('make-product-p2-n3', and(and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('make-product-p1-n5', and(and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n5'))), and(f_ok, f_world))).
poss('make-product-p1-n4', and(and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('make-product-p1-n3', and(and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('open-new-stack-n2-n3', and('stacks-avail-n2', and(f_ok, f_world))).
poss('open-new-stack-n3-n4', and('stacks-avail-n3', and(f_ok, f_world))).
poss('open-new-stack-n4-n5', and('stacks-avail-n4', and(f_ok, f_world))).
poss('start-order-o5-n2-n1', and(and('stacks-avail-n2', 'waiting-o5'), and(f_ok, f_world))).
poss('start-order-o4-n2-n1', and(and('stacks-avail-n2', 'waiting-o4'), and(f_ok, f_world))).
poss('start-order-o3-n2-n1', and(and('stacks-avail-n2', 'waiting-o3'), and(f_ok, f_world))).
poss('start-order-o2-n2-n1', and(and('stacks-avail-n2', 'waiting-o2'), and(f_ok, f_world))).
poss('start-order-o1-n2-n1', and(and('stacks-avail-n2', 'waiting-o1'), and(f_ok, f_world))).
poss('start-order-o5-n3-n2', and(and('stacks-avail-n3', 'waiting-o5'), and(f_ok, f_world))).
poss('start-order-o4-n3-n2', and(and('stacks-avail-n3', 'waiting-o4'), and(f_ok, f_world))).
poss('start-order-o3-n3-n2', and(and('stacks-avail-n3', 'waiting-o3'), and(f_ok, f_world))).
poss('start-order-o2-n3-n2', and(and('stacks-avail-n3', 'waiting-o2'), and(f_ok, f_world))).
poss('start-order-o1-n3-n2', and(and('stacks-avail-n3', 'waiting-o1'), and(f_ok, f_world))).
poss('start-order-o5-n4-n3', and(and('stacks-avail-n4', 'waiting-o5'), and(f_ok, f_world))).
poss('start-order-o4-n4-n3', and(and('stacks-avail-n4', 'waiting-o4'), and(f_ok, f_world))).
poss('start-order-o3-n4-n3', and(and('stacks-avail-n4', 'waiting-o3'), and(f_ok, f_world))).
poss('start-order-o2-n4-n3', and(and('stacks-avail-n4', 'waiting-o2'), and(f_ok, f_world))).
poss('start-order-o1-n4-n3', and(and('stacks-avail-n4', 'waiting-o1'), and(f_ok, f_world))).
poss('start-order-o5-n5-n4', and(and('stacks-avail-n5', 'waiting-o5'), and(f_ok, f_world))).
poss('start-order-o4-n5-n4', and(and('stacks-avail-n5', 'waiting-o4'), and(f_ok, f_world))).
poss('start-order-o3-n5-n4', and(and('stacks-avail-n5', 'waiting-o3'), and(f_ok, f_world))).
poss('start-order-o2-n5-n4', and(and('stacks-avail-n5', 'waiting-o2'), and(f_ok, f_world))).
poss('start-order-o1-n5-n4', and(and('stacks-avail-n5', 'waiting-o1'), and(f_ok, f_world))).
poss('setup-machine-p5-n5', and(and('stacks-avail-n5', and('not-made-p5', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p5-n4', and(and('stacks-avail-n4', and('not-made-p5', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p5-n3', and(and('stacks-avail-n3', and('not-made-p5', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p5-n2', and(and('stacks-avail-n2', and('not-made-p5', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p4-n5', and(and('stacks-avail-n5', and('not-made-p4', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p4-n4', and(and('stacks-avail-n4', and('not-made-p4', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p4-n3', and(and('stacks-avail-n3', and('not-made-p4', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p4-n2', and(and('stacks-avail-n2', and('not-made-p4', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p3-n5', and(and('stacks-avail-n5', and('not-made-p3', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p3-n4', and(and('stacks-avail-n4', and('not-made-p3', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p3-n3', and(and('stacks-avail-n3', and('not-made-p3', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p3-n2', and(and('stacks-avail-n2', and('not-made-p3', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p2-n5', and(and('stacks-avail-n5', and('not-made-p2', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p2-n4', and(and('stacks-avail-n4', and('not-made-p2', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p2-n3', and(and('stacks-avail-n3', and('not-made-p2', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p2-n2', and(and('stacks-avail-n2', and('not-made-p2', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p1-n5', and(and('stacks-avail-n5', and('not-made-p1', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p1-n4', and(and('stacks-avail-n4', and('not-made-p1', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p1-n3', and(and('stacks-avail-n3', and('not-made-p1', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p1-n2', and(and('stacks-avail-n2', and('not-made-p1', 'machine-available')), and(f_ok, f_world))).
poss('ship-order-o5-n4-n5', and(and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('ship-order-o5-n3-n4', and(and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('ship-order-o5-n2-n3', and(and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('ship-order-o5-n1-n2', and(and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('ship-order-o5-n0-n1', and(and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('ship-order-o4-n4-n5', and(and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('ship-order-o4-n3-n4', and(and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('ship-order-o4-n2-n3', and(and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('ship-order-o4-n1-n2', and(and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('ship-order-o4-n0-n1', and(and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('ship-order-o3-n4-n5', and(and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('ship-order-o3-n3-n4', and(and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('ship-order-o3-n2-n3', and(and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('ship-order-o3-n1-n2', and(and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('ship-order-o3-n0-n1', and(and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('ship-order-o2-n4-n5', and(and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('ship-order-o2-n3-n4', and(and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('ship-order-o2-n2-n3', and(and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('ship-order-o2-n1-n2', and(and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('ship-order-o2-n0-n1', and(and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('ship-order-o1-n4-n5', and(and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n4'))), and(f_ok, f_world))).
poss('ship-order-o1-n3-n4', and(and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n3'))), and(f_ok, f_world))).
poss('ship-order-o1-n2-n3', and(and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('ship-order-o1-n1-n2', and(and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('ship-order-o1-n0-n1', and(and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('make-product-p5-n2', and(and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('make-product-p5-n1', and(and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('make-product-p5-n0', and(and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('make-product-p4-n2', and(and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('make-product-p4-n1', and(and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('make-product-p4-n0', and(and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('make-product-p3-n2', and(and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('make-product-p3-n1', and(and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('make-product-p3-n0', and(and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('make-product-p2-n2', and(and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('make-product-p2-n1', and(and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('make-product-p2-n0', and(and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('make-product-p1-n2', and(and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n2'))), and(f_ok, f_world))).
poss('make-product-p1-n1', and(and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n1'))), and(f_ok, f_world))).
poss('make-product-p1-n0', and(and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n0'))), and(f_ok, f_world))).
poss('open-new-stack-n1-n2', and('stacks-avail-n1', and(f_ok, f_world))).
poss('start-order-o5-n1-n0', and(and('stacks-avail-n1', 'waiting-o5'), and(f_ok, f_world))).
poss('start-order-o4-n1-n0', and(and('stacks-avail-n1', 'waiting-o4'), and(f_ok, f_world))).
poss('start-order-o3-n1-n0', and(and('stacks-avail-n1', 'waiting-o3'), and(f_ok, f_world))).
poss('start-order-o2-n1-n0', and(and('stacks-avail-n1', 'waiting-o2'), and(f_ok, f_world))).
poss('start-order-o1-n1-n0', and(and('stacks-avail-n1', 'waiting-o1'), and(f_ok, f_world))).
poss('setup-machine-p5-n1', and(and('stacks-avail-n1', and('not-made-p5', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p4-n1', and(and('stacks-avail-n1', and('not-made-p4', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p3-n1', and(and('stacks-avail-n1', and('not-made-p3', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p2-n1', and(and('stacks-avail-n1', and('not-made-p2', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p1-n1', and(and('stacks-avail-n1', and('not-made-p1', 'machine-available')), and(f_ok, f_world))).
poss('open-new-stack-n0-n1', and('stacks-avail-n0', and(f_ok, f_world))).
poss('setup-machine-p5-n0', and(and('stacks-avail-n0', and('not-made-p5', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p4-n0', and(and('stacks-avail-n0', and('not-made-p4', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p3-n0', and(and('stacks-avail-n0', and('not-made-p3', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p2-n0', and(and('stacks-avail-n0', and('not-made-p2', 'machine-available')), and(f_ok, f_world))).
poss('setup-machine-p1-n0', and(and('stacks-avail-n0', and('not-made-p1', 'machine-available')), and(f_ok, f_world))).
poss(o_copy, and(f_ok, f_copy)).
poss(o_goal, and(and(f_world, f_ok), and(not(q_1), and(not(q_2), and(not(q_3), and(not(q_4), and(not(q_5), and(not(q_6), and(not(q_7), and(not(q_8), and(not(q_9), and(not(q_10), and(not(q_11), and(not(q_12), and(not(q_13), and(not(q_14), not(q_15))))))))))))))))).
poss(o_sync_q_1s, and(and(f_sync, f_ok), q_1t)).
poss(o_sync_q_2s, and(and(f_sync, f_ok), q_2t)).
poss(o_sync_q_3s, and(and(f_sync, f_ok), q_3t)).
poss(o_sync_q_4s, and(and(f_sync, f_ok), q_4t)).
poss(o_sync_q_5s_1, and(and(f_sync, f_ok), q_5t)).
poss(o_sync_q_5s_2, and(and(f_sync, f_ok), q_5t)).
poss(o_sync_q_6s_1, and(and(f_sync, f_ok), q_6t)).
poss(o_sync_q_6s_2, and(and(f_sync, f_ok), q_6t)).
poss(o_sync_q_7s_1, and(and(f_sync, f_ok), q_7t)).
poss(o_sync_q_7s_2, and(and(f_sync, f_ok), q_7t)).
poss(o_sync_q_8s_1, and(and(f_sync, f_ok), q_8t)).
poss(o_sync_q_8s_2, and(and(f_sync, f_ok), q_8t)).
poss(o_sync_q_9s_1, and(and(f_sync, f_ok), q_9t)).
poss(o_sync_q_9s_2, and(and(f_sync, f_ok), q_9t)).
poss(o_sync_q_10s, and(and(f_sync, f_ok), q_10t)).
poss(o_sync_q_11s, and(and(f_sync, f_ok), q_11t)).
poss(o_sync_q_12s, and(and(f_sync, f_ok), q_12t)).
poss(o_sync_q_13s, and(and(f_sync, f_ok), q_13t)).
poss(o_sync_q_14s, and(and(f_sync, f_ok), q_14t)).
poss(o_sync_q_15s, and(and(f_sync, f_ok), q_15t)).
poss(o_sync_q_16s, and(and(f_sync, f_ok), q_16t)).

:- dynamic causes_true/3.

causes_true('made-p5', 'make-product-p5-n5', true).
causes_true('machine-available', 'make-product-p5-n5', true).
causes_true('made-p5', 'make-product-p5-n4', true).
causes_true('machine-available', 'make-product-p5-n4', true).
causes_true('made-p5', 'make-product-p5-n3', true).
causes_true('machine-available', 'make-product-p5-n3', true).
causes_true('made-p4', 'make-product-p4-n5', true).
causes_true('machine-available', 'make-product-p4-n5', true).
causes_true('made-p4', 'make-product-p4-n4', true).
causes_true('machine-available', 'make-product-p4-n4', true).
causes_true('made-p4', 'make-product-p4-n3', true).
causes_true('machine-available', 'make-product-p4-n3', true).
causes_true('made-p3', 'make-product-p3-n5', true).
causes_true('machine-available', 'make-product-p3-n5', true).
causes_true('made-p3', 'make-product-p3-n4', true).
causes_true('machine-available', 'make-product-p3-n4', true).
causes_true('made-p3', 'make-product-p3-n3', true).
causes_true('machine-available', 'make-product-p3-n3', true).
causes_true('made-p2', 'make-product-p2-n5', true).
causes_true('machine-available', 'make-product-p2-n5', true).
causes_true('made-p2', 'make-product-p2-n4', true).
causes_true('machine-available', 'make-product-p2-n4', true).
causes_true('made-p2', 'make-product-p2-n3', true).
causes_true('machine-available', 'make-product-p2-n3', true).
causes_true('made-p1', 'make-product-p1-n5', true).
causes_true('machine-available', 'make-product-p1-n5', true).
causes_true('made-p1', 'make-product-p1-n4', true).
causes_true('machine-available', 'make-product-p1-n4', true).
causes_true('made-p1', 'make-product-p1-n3', true).
causes_true('machine-available', 'make-product-p1-n3', true).
causes_true('stacks-avail-n3', 'open-new-stack-n2-n3', true).
causes_true('stacks-avail-n4', 'open-new-stack-n3-n4', true).
causes_true('stacks-avail-n5', 'open-new-stack-n4-n5', true).
causes_true('started-o5', 'start-order-o5-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o5-n2-n1', true).
causes_true('started-o4', 'start-order-o4-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o4-n2-n1', true).
causes_true('started-o3', 'start-order-o3-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o3-n2-n1', true).
causes_true('started-o2', 'start-order-o2-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o2-n2-n1', true).
causes_true('started-o1', 'start-order-o1-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o1-n2-n1', true).
causes_true('started-o5', 'start-order-o5-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o5-n3-n2', true).
causes_true('started-o4', 'start-order-o4-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o4-n3-n2', true).
causes_true('started-o3', 'start-order-o3-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o3-n3-n2', true).
causes_true('started-o2', 'start-order-o2-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o2-n3-n2', true).
causes_true('started-o1', 'start-order-o1-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o1-n3-n2', true).
causes_true('started-o5', 'start-order-o5-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o5-n4-n3', true).
causes_true('started-o4', 'start-order-o4-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o4-n4-n3', true).
causes_true('started-o3', 'start-order-o3-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o3-n4-n3', true).
causes_true('started-o2', 'start-order-o2-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o2-n4-n3', true).
causes_true('started-o1', 'start-order-o1-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o1-n4-n3', true).
causes_true('started-o5', 'start-order-o5-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o5-n5-n4', true).
causes_true('started-o4', 'start-order-o4-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o4-n5-n4', true).
causes_true('started-o3', 'start-order-o3-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o3-n5-n4', true).
causes_true('started-o2', 'start-order-o2-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o2-n5-n4', true).
causes_true('started-o1', 'start-order-o1-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o1-n5-n4', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n5', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n4', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n3', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n2', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n5', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n4', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n3', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n2', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n5', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n4', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n3', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n2', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n5', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n4', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n3', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n2', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n5', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n4', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n3', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n2', true).
causes_true('stacks-avail-n5', 'ship-order-o5-n4-n5', true).
causes_true('shipped-o5', 'ship-order-o5-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o5-n3-n4', true).
causes_true('shipped-o5', 'ship-order-o5-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o5-n2-n3', true).
causes_true('shipped-o5', 'ship-order-o5-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o5-n1-n2', true).
causes_true('shipped-o5', 'ship-order-o5-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o5-n0-n1', true).
causes_true('shipped-o5', 'ship-order-o5-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o4-n4-n5', true).
causes_true('shipped-o4', 'ship-order-o4-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o4-n3-n4', true).
causes_true('shipped-o4', 'ship-order-o4-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o4-n2-n3', true).
causes_true('shipped-o4', 'ship-order-o4-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o4-n1-n2', true).
causes_true('shipped-o4', 'ship-order-o4-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o4-n0-n1', true).
causes_true('shipped-o4', 'ship-order-o4-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o3-n4-n5', true).
causes_true('shipped-o3', 'ship-order-o3-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o3-n3-n4', true).
causes_true('shipped-o3', 'ship-order-o3-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o3-n2-n3', true).
causes_true('shipped-o3', 'ship-order-o3-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o3-n1-n2', true).
causes_true('shipped-o3', 'ship-order-o3-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o3-n0-n1', true).
causes_true('shipped-o3', 'ship-order-o3-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o2-n4-n5', true).
causes_true('shipped-o2', 'ship-order-o2-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o2-n3-n4', true).
causes_true('shipped-o2', 'ship-order-o2-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o2-n2-n3', true).
causes_true('shipped-o2', 'ship-order-o2-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o2-n1-n2', true).
causes_true('shipped-o2', 'ship-order-o2-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o2-n0-n1', true).
causes_true('shipped-o2', 'ship-order-o2-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o1-n4-n5', true).
causes_true('shipped-o1', 'ship-order-o1-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o1-n3-n4', true).
causes_true('shipped-o1', 'ship-order-o1-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o1-n2-n3', true).
causes_true('shipped-o1', 'ship-order-o1-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o1-n1-n2', true).
causes_true('shipped-o1', 'ship-order-o1-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o1-n0-n1', true).
causes_true('shipped-o1', 'ship-order-o1-n0-n1', true).
causes_true('made-p5', 'make-product-p5-n2', true).
causes_true('machine-available', 'make-product-p5-n2', true).
causes_true('made-p5', 'make-product-p5-n1', true).
causes_true('machine-available', 'make-product-p5-n1', true).
causes_true('made-p5', 'make-product-p5-n0', true).
causes_true('machine-available', 'make-product-p5-n0', true).
causes_true('made-p4', 'make-product-p4-n2', true).
causes_true('machine-available', 'make-product-p4-n2', true).
causes_true('made-p4', 'make-product-p4-n1', true).
causes_true('machine-available', 'make-product-p4-n1', true).
causes_true('made-p4', 'make-product-p4-n0', true).
causes_true('machine-available', 'make-product-p4-n0', true).
causes_true('made-p3', 'make-product-p3-n2', true).
causes_true('machine-available', 'make-product-p3-n2', true).
causes_true('made-p3', 'make-product-p3-n1', true).
causes_true('machine-available', 'make-product-p3-n1', true).
causes_true('made-p3', 'make-product-p3-n0', true).
causes_true('machine-available', 'make-product-p3-n0', true).
causes_true('made-p2', 'make-product-p2-n2', true).
causes_true('machine-available', 'make-product-p2-n2', true).
causes_true('made-p2', 'make-product-p2-n1', true).
causes_true('machine-available', 'make-product-p2-n1', true).
causes_true('made-p2', 'make-product-p2-n0', true).
causes_true('machine-available', 'make-product-p2-n0', true).
causes_true('made-p1', 'make-product-p1-n2', true).
causes_true('machine-available', 'make-product-p1-n2', true).
causes_true('made-p1', 'make-product-p1-n1', true).
causes_true('machine-available', 'make-product-p1-n1', true).
causes_true('made-p1', 'make-product-p1-n0', true).
causes_true('machine-available', 'make-product-p1-n0', true).
causes_true('stacks-avail-n2', 'open-new-stack-n1-n2', true).
causes_true('started-o5', 'start-order-o5-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o5-n1-n0', true).
causes_true('started-o4', 'start-order-o4-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o4-n1-n0', true).
causes_true('started-o3', 'start-order-o3-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o3-n1-n0', true).
causes_true('started-o2', 'start-order-o2-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o2-n1-n0', true).
causes_true('started-o1', 'start-order-o1-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o1-n1-n0', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n1', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n1', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n1', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n1', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n1', true).
causes_true('stacks-avail-n1', 'open-new-stack-n0-n1', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n0', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n0', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n0', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n0', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n0', true).
causes_true(f_copy, 'make-product-p5-n5', true).
causes_true(f_copy, 'make-product-p5-n4', true).
causes_true(f_copy, 'make-product-p5-n3', true).
causes_true(f_copy, 'make-product-p4-n5', true).
causes_true(f_copy, 'make-product-p4-n4', true).
causes_true(f_copy, 'make-product-p4-n3', true).
causes_true(f_copy, 'make-product-p3-n5', true).
causes_true(f_copy, 'make-product-p3-n4', true).
causes_true(f_copy, 'make-product-p3-n3', true).
causes_true(f_copy, 'make-product-p2-n5', true).
causes_true(f_copy, 'make-product-p2-n4', true).
causes_true(f_copy, 'make-product-p2-n3', true).
causes_true(f_copy, 'make-product-p1-n5', true).
causes_true(f_copy, 'make-product-p1-n4', true).
causes_true(f_copy, 'make-product-p1-n3', true).
causes_true(f_copy, 'open-new-stack-n2-n3', true).
causes_true(f_copy, 'open-new-stack-n3-n4', true).
causes_true(f_copy, 'open-new-stack-n4-n5', true).
causes_true(f_copy, 'start-order-o5-n2-n1', true).
causes_true(f_copy, 'start-order-o4-n2-n1', true).
causes_true(f_copy, 'start-order-o3-n2-n1', true).
causes_true(f_copy, 'start-order-o2-n2-n1', true).
causes_true(f_copy, 'start-order-o1-n2-n1', true).
causes_true(f_copy, 'start-order-o5-n3-n2', true).
causes_true(f_copy, 'start-order-o4-n3-n2', true).
causes_true(f_copy, 'start-order-o3-n3-n2', true).
causes_true(f_copy, 'start-order-o2-n3-n2', true).
causes_true(f_copy, 'start-order-o1-n3-n2', true).
causes_true(f_copy, 'start-order-o5-n4-n3', true).
causes_true(f_copy, 'start-order-o4-n4-n3', true).
causes_true(f_copy, 'start-order-o3-n4-n3', true).
causes_true(f_copy, 'start-order-o2-n4-n3', true).
causes_true(f_copy, 'start-order-o1-n4-n3', true).
causes_true(f_copy, 'start-order-o5-n5-n4', true).
causes_true(f_copy, 'start-order-o4-n5-n4', true).
causes_true(f_copy, 'start-order-o3-n5-n4', true).
causes_true(f_copy, 'start-order-o2-n5-n4', true).
causes_true(f_copy, 'start-order-o1-n5-n4', true).
causes_true(f_copy, 'setup-machine-p5-n5', true).
causes_true(f_copy, 'setup-machine-p5-n4', true).
causes_true(f_copy, 'setup-machine-p5-n3', true).
causes_true(f_copy, 'setup-machine-p5-n2', true).
causes_true(f_copy, 'setup-machine-p4-n5', true).
causes_true(f_copy, 'setup-machine-p4-n4', true).
causes_true(f_copy, 'setup-machine-p4-n3', true).
causes_true(f_copy, 'setup-machine-p4-n2', true).
causes_true(f_copy, 'setup-machine-p3-n5', true).
causes_true(f_copy, 'setup-machine-p3-n4', true).
causes_true(f_copy, 'setup-machine-p3-n3', true).
causes_true(f_copy, 'setup-machine-p3-n2', true).
causes_true(f_copy, 'setup-machine-p2-n5', true).
causes_true(f_copy, 'setup-machine-p2-n4', true).
causes_true(f_copy, 'setup-machine-p2-n3', true).
causes_true(f_copy, 'setup-machine-p2-n2', true).
causes_true(f_copy, 'setup-machine-p1-n5', true).
causes_true(f_copy, 'setup-machine-p1-n4', true).
causes_true(f_copy, 'setup-machine-p1-n3', true).
causes_true(f_copy, 'setup-machine-p1-n2', true).
causes_true(f_copy, 'ship-order-o5-n4-n5', true).
causes_true(f_copy, 'ship-order-o5-n3-n4', true).
causes_true(f_copy, 'ship-order-o5-n2-n3', true).
causes_true(f_copy, 'ship-order-o5-n1-n2', true).
causes_true(f_copy, 'ship-order-o5-n0-n1', true).
causes_true(f_copy, 'ship-order-o4-n4-n5', true).
causes_true(f_copy, 'ship-order-o4-n3-n4', true).
causes_true(f_copy, 'ship-order-o4-n2-n3', true).
causes_true(f_copy, 'ship-order-o4-n1-n2', true).
causes_true(f_copy, 'ship-order-o4-n0-n1', true).
causes_true(f_copy, 'ship-order-o3-n4-n5', true).
causes_true(f_copy, 'ship-order-o3-n3-n4', true).
causes_true(f_copy, 'ship-order-o3-n2-n3', true).
causes_true(f_copy, 'ship-order-o3-n1-n2', true).
causes_true(f_copy, 'ship-order-o3-n0-n1', true).
causes_true(f_copy, 'ship-order-o2-n4-n5', true).
causes_true(f_copy, 'ship-order-o2-n3-n4', true).
causes_true(f_copy, 'ship-order-o2-n2-n3', true).
causes_true(f_copy, 'ship-order-o2-n1-n2', true).
causes_true(f_copy, 'ship-order-o2-n0-n1', true).
causes_true(f_copy, 'ship-order-o1-n4-n5', true).
causes_true(f_copy, 'ship-order-o1-n3-n4', true).
causes_true(f_copy, 'ship-order-o1-n2-n3', true).
causes_true(f_copy, 'ship-order-o1-n1-n2', true).
causes_true(f_copy, 'ship-order-o1-n0-n1', true).
causes_true(f_copy, 'make-product-p5-n2', true).
causes_true(f_copy, 'make-product-p5-n1', true).
causes_true(f_copy, 'make-product-p5-n0', true).
causes_true(f_copy, 'make-product-p4-n2', true).
causes_true(f_copy, 'make-product-p4-n1', true).
causes_true(f_copy, 'make-product-p4-n0', true).
causes_true(f_copy, 'make-product-p3-n2', true).
causes_true(f_copy, 'make-product-p3-n1', true).
causes_true(f_copy, 'make-product-p3-n0', true).
causes_true(f_copy, 'make-product-p2-n2', true).
causes_true(f_copy, 'make-product-p2-n1', true).
causes_true(f_copy, 'make-product-p2-n0', true).
causes_true(f_copy, 'make-product-p1-n2', true).
causes_true(f_copy, 'make-product-p1-n1', true).
causes_true(f_copy, 'make-product-p1-n0', true).
causes_true(f_copy, 'open-new-stack-n1-n2', true).
causes_true(f_copy, 'start-order-o5-n1-n0', true).
causes_true(f_copy, 'start-order-o4-n1-n0', true).
causes_true(f_copy, 'start-order-o3-n1-n0', true).
causes_true(f_copy, 'start-order-o2-n1-n0', true).
causes_true(f_copy, 'start-order-o1-n1-n0', true).
causes_true(f_copy, 'setup-machine-p5-n1', true).
causes_true(f_copy, 'setup-machine-p4-n1', true).
causes_true(f_copy, 'setup-machine-p3-n1', true).
causes_true(f_copy, 'setup-machine-p2-n1', true).
causes_true(f_copy, 'setup-machine-p1-n1', true).
causes_true(f_copy, 'open-new-stack-n0-n1', true).
causes_true(f_copy, 'setup-machine-p5-n0', true).
causes_true(f_copy, 'setup-machine-p4-n0', true).
causes_true(f_copy, 'setup-machine-p3-n0', true).
causes_true(f_copy, 'setup-machine-p2-n0', true).
causes_true(f_copy, 'setup-machine-p1-n0', true).
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
causes_true(f_goal, o_goal, true).
causes_true(q_9s, o_sync_q_1s, q_1s).
causes_true(q_2s, o_sync_q_1s, q_1s).
causes_true(q_2t, o_sync_q_1s, true).
causes_true(q_8s, o_sync_q_2s, q_2s).
causes_true(q_3s, o_sync_q_2s, q_2s).
causes_true(q_3t, o_sync_q_2s, true).
causes_true(q_7s, o_sync_q_3s, q_3s).
causes_true(q_4s, o_sync_q_3s, q_3s).
causes_true(q_4t, o_sync_q_3s, true).
causes_true(q_6s, o_sync_q_4s, q_4s).
causes_true(q_5s, o_sync_q_4s, q_4s).
causes_true(q_5t, o_sync_q_4s, true).
causes_true(q_10s, o_sync_q_5s_1, q_5s).
causes_true(q_6t, o_sync_q_5s_1, true).
causes_true(q_15, o_sync_q_5s_2, q_5s).
causes_true(q_5, o_sync_q_5s_2, q_5s).
causes_true(q_6t, o_sync_q_5s_2, true).
causes_true(q_11s, o_sync_q_6s_1, q_6s).
causes_true(q_7t, o_sync_q_6s_1, true).
causes_true(q_15, o_sync_q_6s_2, q_6s).
causes_true(q_6, o_sync_q_6s_2, q_6s).
causes_true(q_7t, o_sync_q_6s_2, true).
causes_true(q_12s, o_sync_q_7s_1, q_7s).
causes_true(q_8t, o_sync_q_7s_1, true).
causes_true(q_15, o_sync_q_7s_2, q_7s).
causes_true(q_7, o_sync_q_7s_2, q_7s).
causes_true(q_8t, o_sync_q_7s_2, true).
causes_true(q_13s, o_sync_q_8s_1, q_8s).
causes_true(q_9t, o_sync_q_8s_1, true).
causes_true(q_15, o_sync_q_8s_2, q_8s).
causes_true(q_8, o_sync_q_8s_2, q_8s).
causes_true(q_9t, o_sync_q_8s_2, true).
causes_true(q_14s, o_sync_q_9s_1, q_9s).
causes_true(q_10t, o_sync_q_9s_1, true).
causes_true(q_15, o_sync_q_9s_2, q_9s).
causes_true(q_9, o_sync_q_9s_2, q_9s).
causes_true(q_10t, o_sync_q_9s_2, true).
causes_true(q_11t, o_sync_q_10s, true).
causes_true(q_12t, o_sync_q_11s, true).
causes_true(q_13t, o_sync_q_12s, true).
causes_true(q_14t, o_sync_q_13s, true).
causes_true(q_15t, o_sync_q_14s, true).
causes_true(q_16t, o_sync_q_15s, true).
causes_true(f_world, o_sync_q_16s, true).
causes_true(q_1, o_sync_q_16s, q_1s).
causes_true(q_2, o_sync_q_16s, q_2s).
causes_true(q_3, o_sync_q_16s, q_3s).
causes_true(q_4, o_sync_q_16s, q_4s).
causes_true(q_5, o_sync_q_16s, q_5s).
causes_true(q_6, o_sync_q_16s, q_6s).
causes_true(q_7, o_sync_q_16s, q_7s).
causes_true(q_8, o_sync_q_16s, q_8s).
causes_true(q_9, o_sync_q_16s, q_9s).
causes_true(q_10, o_sync_q_16s, q_10s).
causes_true(q_11, o_sync_q_16s, q_11s).
causes_true(q_12, o_sync_q_16s, q_12s).
causes_true(q_13, o_sync_q_16s, q_13s).
causes_true(q_14, o_sync_q_16s, q_14s).
causes_true(q_15, o_sync_q_16s, q_15s).
causes_true(q_16, o_sync_q_16s, q_16s).

:- dynamic causes_false/3.

causes_false('not-made-p5', 'make-product-p5-n5', true).
causes_false('machine-configured-p5', 'make-product-p5-n5', true).
causes_false('not-made-p5', 'make-product-p5-n4', true).
causes_false('machine-configured-p5', 'make-product-p5-n4', true).
causes_false('not-made-p5', 'make-product-p5-n3', true).
causes_false('machine-configured-p5', 'make-product-p5-n3', true).
causes_false('not-made-p4', 'make-product-p4-n5', true).
causes_false('machine-configured-p4', 'make-product-p4-n5', true).
causes_false('not-made-p4', 'make-product-p4-n4', true).
causes_false('machine-configured-p4', 'make-product-p4-n4', true).
causes_false('not-made-p4', 'make-product-p4-n3', true).
causes_false('machine-configured-p4', 'make-product-p4-n3', true).
causes_false('not-made-p3', 'make-product-p3-n5', true).
causes_false('machine-configured-p3', 'make-product-p3-n5', true).
causes_false('not-made-p3', 'make-product-p3-n4', true).
causes_false('machine-configured-p3', 'make-product-p3-n4', true).
causes_false('not-made-p3', 'make-product-p3-n3', true).
causes_false('machine-configured-p3', 'make-product-p3-n3', true).
causes_false('not-made-p2', 'make-product-p2-n5', true).
causes_false('machine-configured-p2', 'make-product-p2-n5', true).
causes_false('not-made-p2', 'make-product-p2-n4', true).
causes_false('machine-configured-p2', 'make-product-p2-n4', true).
causes_false('not-made-p2', 'make-product-p2-n3', true).
causes_false('machine-configured-p2', 'make-product-p2-n3', true).
causes_false('not-made-p1', 'make-product-p1-n5', true).
causes_false('machine-configured-p1', 'make-product-p1-n5', true).
causes_false('not-made-p1', 'make-product-p1-n4', true).
causes_false('machine-configured-p1', 'make-product-p1-n4', true).
causes_false('not-made-p1', 'make-product-p1-n3', true).
causes_false('machine-configured-p1', 'make-product-p1-n3', true).
causes_false('stacks-avail-n2', 'open-new-stack-n2-n3', true).
causes_false('stacks-avail-n3', 'open-new-stack-n3-n4', true).
causes_false('stacks-avail-n4', 'open-new-stack-n4-n5', true).
causes_false('waiting-o5', 'start-order-o5-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o5-n2-n1', true).
causes_false('waiting-o4', 'start-order-o4-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o4-n2-n1', true).
causes_false('waiting-o3', 'start-order-o3-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o3-n2-n1', true).
causes_false('waiting-o2', 'start-order-o2-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o2-n2-n1', true).
causes_false('waiting-o1', 'start-order-o1-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o1-n2-n1', true).
causes_false('waiting-o5', 'start-order-o5-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o5-n3-n2', true).
causes_false('waiting-o4', 'start-order-o4-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o4-n3-n2', true).
causes_false('waiting-o3', 'start-order-o3-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o3-n3-n2', true).
causes_false('waiting-o2', 'start-order-o2-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o2-n3-n2', true).
causes_false('waiting-o1', 'start-order-o1-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o1-n3-n2', true).
causes_false('waiting-o5', 'start-order-o5-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o5-n4-n3', true).
causes_false('waiting-o4', 'start-order-o4-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o4-n4-n3', true).
causes_false('waiting-o3', 'start-order-o3-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o3-n4-n3', true).
causes_false('waiting-o2', 'start-order-o2-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o2-n4-n3', true).
causes_false('waiting-o1', 'start-order-o1-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o1-n4-n3', true).
causes_false('waiting-o5', 'start-order-o5-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o5-n5-n4', true).
causes_false('waiting-o4', 'start-order-o4-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o4-n5-n4', true).
causes_false('waiting-o3', 'start-order-o3-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o3-n5-n4', true).
causes_false('waiting-o2', 'start-order-o2-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o2-n5-n4', true).
causes_false('waiting-o1', 'start-order-o1-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o1-n5-n4', true).
causes_false('machine-available', 'setup-machine-p5-n5', true).
causes_false('machine-available', 'setup-machine-p5-n4', true).
causes_false('machine-available', 'setup-machine-p5-n3', true).
causes_false('machine-available', 'setup-machine-p5-n2', true).
causes_false('machine-available', 'setup-machine-p4-n5', true).
causes_false('machine-available', 'setup-machine-p4-n4', true).
causes_false('machine-available', 'setup-machine-p4-n3', true).
causes_false('machine-available', 'setup-machine-p4-n2', true).
causes_false('machine-available', 'setup-machine-p3-n5', true).
causes_false('machine-available', 'setup-machine-p3-n4', true).
causes_false('machine-available', 'setup-machine-p3-n3', true).
causes_false('machine-available', 'setup-machine-p3-n2', true).
causes_false('machine-available', 'setup-machine-p2-n5', true).
causes_false('machine-available', 'setup-machine-p2-n4', true).
causes_false('machine-available', 'setup-machine-p2-n3', true).
causes_false('machine-available', 'setup-machine-p2-n2', true).
causes_false('machine-available', 'setup-machine-p1-n5', true).
causes_false('machine-available', 'setup-machine-p1-n4', true).
causes_false('machine-available', 'setup-machine-p1-n3', true).
causes_false('machine-available', 'setup-machine-p1-n2', true).
causes_false('stacks-avail-n4', 'ship-order-o5-n4-n5', true).
causes_false('started-o5', 'ship-order-o5-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o5-n3-n4', true).
causes_false('started-o5', 'ship-order-o5-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o5-n2-n3', true).
causes_false('started-o5', 'ship-order-o5-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o5-n1-n2', true).
causes_false('started-o5', 'ship-order-o5-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o5-n0-n1', true).
causes_false('started-o5', 'ship-order-o5-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o4-n4-n5', true).
causes_false('started-o4', 'ship-order-o4-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o4-n3-n4', true).
causes_false('started-o4', 'ship-order-o4-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o4-n2-n3', true).
causes_false('started-o4', 'ship-order-o4-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o4-n1-n2', true).
causes_false('started-o4', 'ship-order-o4-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o4-n0-n1', true).
causes_false('started-o4', 'ship-order-o4-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o3-n4-n5', true).
causes_false('started-o3', 'ship-order-o3-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o3-n3-n4', true).
causes_false('started-o3', 'ship-order-o3-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o3-n2-n3', true).
causes_false('started-o3', 'ship-order-o3-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o3-n1-n2', true).
causes_false('started-o3', 'ship-order-o3-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o3-n0-n1', true).
causes_false('started-o3', 'ship-order-o3-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o2-n4-n5', true).
causes_false('started-o2', 'ship-order-o2-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o2-n3-n4', true).
causes_false('started-o2', 'ship-order-o2-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o2-n2-n3', true).
causes_false('started-o2', 'ship-order-o2-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o2-n1-n2', true).
causes_false('started-o2', 'ship-order-o2-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o2-n0-n1', true).
causes_false('started-o2', 'ship-order-o2-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o1-n4-n5', true).
causes_false('started-o1', 'ship-order-o1-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o1-n3-n4', true).
causes_false('started-o1', 'ship-order-o1-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o1-n2-n3', true).
causes_false('started-o1', 'ship-order-o1-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o1-n1-n2', true).
causes_false('started-o1', 'ship-order-o1-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o1-n0-n1', true).
causes_false('started-o1', 'ship-order-o1-n0-n1', true).
causes_false('not-made-p5', 'make-product-p5-n2', true).
causes_false('machine-configured-p5', 'make-product-p5-n2', true).
causes_false('not-made-p5', 'make-product-p5-n1', true).
causes_false('machine-configured-p5', 'make-product-p5-n1', true).
causes_false('not-made-p5', 'make-product-p5-n0', true).
causes_false('machine-configured-p5', 'make-product-p5-n0', true).
causes_false('not-made-p4', 'make-product-p4-n2', true).
causes_false('machine-configured-p4', 'make-product-p4-n2', true).
causes_false('not-made-p4', 'make-product-p4-n1', true).
causes_false('machine-configured-p4', 'make-product-p4-n1', true).
causes_false('not-made-p4', 'make-product-p4-n0', true).
causes_false('machine-configured-p4', 'make-product-p4-n0', true).
causes_false('not-made-p3', 'make-product-p3-n2', true).
causes_false('machine-configured-p3', 'make-product-p3-n2', true).
causes_false('not-made-p3', 'make-product-p3-n1', true).
causes_false('machine-configured-p3', 'make-product-p3-n1', true).
causes_false('not-made-p3', 'make-product-p3-n0', true).
causes_false('machine-configured-p3', 'make-product-p3-n0', true).
causes_false('not-made-p2', 'make-product-p2-n2', true).
causes_false('machine-configured-p2', 'make-product-p2-n2', true).
causes_false('not-made-p2', 'make-product-p2-n1', true).
causes_false('machine-configured-p2', 'make-product-p2-n1', true).
causes_false('not-made-p2', 'make-product-p2-n0', true).
causes_false('machine-configured-p2', 'make-product-p2-n0', true).
causes_false('not-made-p1', 'make-product-p1-n2', true).
causes_false('machine-configured-p1', 'make-product-p1-n2', true).
causes_false('not-made-p1', 'make-product-p1-n1', true).
causes_false('machine-configured-p1', 'make-product-p1-n1', true).
causes_false('not-made-p1', 'make-product-p1-n0', true).
causes_false('machine-configured-p1', 'make-product-p1-n0', true).
causes_false('stacks-avail-n1', 'open-new-stack-n1-n2', true).
causes_false('waiting-o5', 'start-order-o5-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o5-n1-n0', true).
causes_false('waiting-o4', 'start-order-o4-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o4-n1-n0', true).
causes_false('waiting-o3', 'start-order-o3-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o3-n1-n0', true).
causes_false('waiting-o2', 'start-order-o2-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o2-n1-n0', true).
causes_false('waiting-o1', 'start-order-o1-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o1-n1-n0', true).
causes_false('machine-available', 'setup-machine-p5-n1', true).
causes_false('machine-available', 'setup-machine-p4-n1', true).
causes_false('machine-available', 'setup-machine-p3-n1', true).
causes_false('machine-available', 'setup-machine-p2-n1', true).
causes_false('machine-available', 'setup-machine-p1-n1', true).
causes_false('stacks-avail-n0', 'open-new-stack-n0-n1', true).
causes_false('machine-available', 'setup-machine-p5-n0', true).
causes_false('machine-available', 'setup-machine-p4-n0', true).
causes_false('machine-available', 'setup-machine-p3-n0', true).
causes_false('machine-available', 'setup-machine-p2-n0', true).
causes_false('machine-available', 'setup-machine-p1-n0', true).
causes_false(f_world, 'make-product-p5-n5', true).
causes_false(f_world, 'make-product-p5-n4', true).
causes_false(f_world, 'make-product-p5-n3', true).
causes_false(f_world, 'make-product-p4-n5', true).
causes_false(f_world, 'make-product-p4-n4', true).
causes_false(f_world, 'make-product-p4-n3', true).
causes_false(f_world, 'make-product-p3-n5', true).
causes_false(f_world, 'make-product-p3-n4', true).
causes_false(f_world, 'make-product-p3-n3', true).
causes_false(f_world, 'make-product-p2-n5', true).
causes_false(f_world, 'make-product-p2-n4', true).
causes_false(f_world, 'make-product-p2-n3', true).
causes_false(f_world, 'make-product-p1-n5', true).
causes_false(f_world, 'make-product-p1-n4', true).
causes_false(f_world, 'make-product-p1-n3', true).
causes_false(f_world, 'open-new-stack-n2-n3', true).
causes_false(f_world, 'open-new-stack-n3-n4', true).
causes_false(f_world, 'open-new-stack-n4-n5', true).
causes_false(f_world, 'start-order-o5-n2-n1', true).
causes_false(f_world, 'start-order-o4-n2-n1', true).
causes_false(f_world, 'start-order-o3-n2-n1', true).
causes_false(f_world, 'start-order-o2-n2-n1', true).
causes_false(f_world, 'start-order-o1-n2-n1', true).
causes_false(f_world, 'start-order-o5-n3-n2', true).
causes_false(f_world, 'start-order-o4-n3-n2', true).
causes_false(f_world, 'start-order-o3-n3-n2', true).
causes_false(f_world, 'start-order-o2-n3-n2', true).
causes_false(f_world, 'start-order-o1-n3-n2', true).
causes_false(f_world, 'start-order-o5-n4-n3', true).
causes_false(f_world, 'start-order-o4-n4-n3', true).
causes_false(f_world, 'start-order-o3-n4-n3', true).
causes_false(f_world, 'start-order-o2-n4-n3', true).
causes_false(f_world, 'start-order-o1-n4-n3', true).
causes_false(f_world, 'start-order-o5-n5-n4', true).
causes_false(f_world, 'start-order-o4-n5-n4', true).
causes_false(f_world, 'start-order-o3-n5-n4', true).
causes_false(f_world, 'start-order-o2-n5-n4', true).
causes_false(f_world, 'start-order-o1-n5-n4', true).
causes_false(f_world, 'setup-machine-p5-n5', true).
causes_false(f_world, 'setup-machine-p5-n4', true).
causes_false(f_world, 'setup-machine-p5-n3', true).
causes_false(f_world, 'setup-machine-p5-n2', true).
causes_false(f_world, 'setup-machine-p4-n5', true).
causes_false(f_world, 'setup-machine-p4-n4', true).
causes_false(f_world, 'setup-machine-p4-n3', true).
causes_false(f_world, 'setup-machine-p4-n2', true).
causes_false(f_world, 'setup-machine-p3-n5', true).
causes_false(f_world, 'setup-machine-p3-n4', true).
causes_false(f_world, 'setup-machine-p3-n3', true).
causes_false(f_world, 'setup-machine-p3-n2', true).
causes_false(f_world, 'setup-machine-p2-n5', true).
causes_false(f_world, 'setup-machine-p2-n4', true).
causes_false(f_world, 'setup-machine-p2-n3', true).
causes_false(f_world, 'setup-machine-p2-n2', true).
causes_false(f_world, 'setup-machine-p1-n5', true).
causes_false(f_world, 'setup-machine-p1-n4', true).
causes_false(f_world, 'setup-machine-p1-n3', true).
causes_false(f_world, 'setup-machine-p1-n2', true).
causes_false(f_world, 'ship-order-o5-n4-n5', true).
causes_false(f_world, 'ship-order-o5-n3-n4', true).
causes_false(f_world, 'ship-order-o5-n2-n3', true).
causes_false(f_world, 'ship-order-o5-n1-n2', true).
causes_false(f_world, 'ship-order-o5-n0-n1', true).
causes_false(f_world, 'ship-order-o4-n4-n5', true).
causes_false(f_world, 'ship-order-o4-n3-n4', true).
causes_false(f_world, 'ship-order-o4-n2-n3', true).
causes_false(f_world, 'ship-order-o4-n1-n2', true).
causes_false(f_world, 'ship-order-o4-n0-n1', true).
causes_false(f_world, 'ship-order-o3-n4-n5', true).
causes_false(f_world, 'ship-order-o3-n3-n4', true).
causes_false(f_world, 'ship-order-o3-n2-n3', true).
causes_false(f_world, 'ship-order-o3-n1-n2', true).
causes_false(f_world, 'ship-order-o3-n0-n1', true).
causes_false(f_world, 'ship-order-o2-n4-n5', true).
causes_false(f_world, 'ship-order-o2-n3-n4', true).
causes_false(f_world, 'ship-order-o2-n2-n3', true).
causes_false(f_world, 'ship-order-o2-n1-n2', true).
causes_false(f_world, 'ship-order-o2-n0-n1', true).
causes_false(f_world, 'ship-order-o1-n4-n5', true).
causes_false(f_world, 'ship-order-o1-n3-n4', true).
causes_false(f_world, 'ship-order-o1-n2-n3', true).
causes_false(f_world, 'ship-order-o1-n1-n2', true).
causes_false(f_world, 'ship-order-o1-n0-n1', true).
causes_false(f_world, 'make-product-p5-n2', true).
causes_false(f_world, 'make-product-p5-n1', true).
causes_false(f_world, 'make-product-p5-n0', true).
causes_false(f_world, 'make-product-p4-n2', true).
causes_false(f_world, 'make-product-p4-n1', true).
causes_false(f_world, 'make-product-p4-n0', true).
causes_false(f_world, 'make-product-p3-n2', true).
causes_false(f_world, 'make-product-p3-n1', true).
causes_false(f_world, 'make-product-p3-n0', true).
causes_false(f_world, 'make-product-p2-n2', true).
causes_false(f_world, 'make-product-p2-n1', true).
causes_false(f_world, 'make-product-p2-n0', true).
causes_false(f_world, 'make-product-p1-n2', true).
causes_false(f_world, 'make-product-p1-n1', true).
causes_false(f_world, 'make-product-p1-n0', true).
causes_false(f_world, 'open-new-stack-n1-n2', true).
causes_false(f_world, 'start-order-o5-n1-n0', true).
causes_false(f_world, 'start-order-o4-n1-n0', true).
causes_false(f_world, 'start-order-o3-n1-n0', true).
causes_false(f_world, 'start-order-o2-n1-n0', true).
causes_false(f_world, 'start-order-o1-n1-n0', true).
causes_false(f_world, 'setup-machine-p5-n1', true).
causes_false(f_world, 'setup-machine-p4-n1', true).
causes_false(f_world, 'setup-machine-p3-n1', true).
causes_false(f_world, 'setup-machine-p2-n1', true).
causes_false(f_world, 'setup-machine-p1-n1', true).
causes_false(f_world, 'open-new-stack-n0-n1', true).
causes_false(f_world, 'setup-machine-p5-n0', true).
causes_false(f_world, 'setup-machine-p4-n0', true).
causes_false(f_world, 'setup-machine-p3-n0', true).
causes_false(f_world, 'setup-machine-p2-n0', true).
causes_false(f_world, 'setup-machine-p1-n0', true).
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
causes_false(q_1s, o_sync_q_1s, q_1s).
causes_false(q_1t, o_sync_q_1s, true).
causes_false(q_2s, o_sync_q_2s, q_2s).
causes_false(q_2t, o_sync_q_2s, true).
causes_false(q_3s, o_sync_q_3s, q_3s).
causes_false(q_3t, o_sync_q_3s, true).
causes_false(q_4s, o_sync_q_4s, q_4s).
causes_false(q_4t, o_sync_q_4s, true).
causes_false(q_5s, o_sync_q_5s_1, q_5s).
causes_false(q_5t, o_sync_q_5s_1, true).
causes_false(q_5s, o_sync_q_5s_2, q_5s).
causes_false(q_5t, o_sync_q_5s_2, true).
causes_false(q_6s, o_sync_q_6s_1, q_6s).
causes_false(q_6t, o_sync_q_6s_1, true).
causes_false(q_6s, o_sync_q_6s_2, q_6s).
causes_false(q_6t, o_sync_q_6s_2, true).
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
causes_false(q_10s, o_sync_q_10s, q_10s).
causes_false(f_ok, o_sync_q_10s, and(q_10s, not('shipped-o5'))).
causes_false(q_10t, o_sync_q_10s, true).
causes_false(q_11s, o_sync_q_11s, q_11s).
causes_false(f_ok, o_sync_q_11s, and(q_11s, not('shipped-o4'))).
causes_false(q_11t, o_sync_q_11s, true).
causes_false(q_12s, o_sync_q_12s, q_12s).
causes_false(f_ok, o_sync_q_12s, and(q_12s, not('shipped-o3'))).
causes_false(q_12t, o_sync_q_12s, true).
causes_false(q_13s, o_sync_q_13s, q_13s).
causes_false(f_ok, o_sync_q_13s, and(q_13s, not('shipped-o2'))).
causes_false(q_13t, o_sync_q_13s, true).
causes_false(q_14s, o_sync_q_14s, q_14s).
causes_false(f_ok, o_sync_q_14s, and(q_14s, not('shipped-o1'))).
causes_false(q_14t, o_sync_q_14s, true).
causes_false(q_15s, o_sync_q_15s, q_15s).
causes_false(q_15t, o_sync_q_15s, true).
causes_false(f_ok, o_sync_q_16s, q_16s).
causes_false(q_16t, o_sync_q_16s, true).
causes_false(f_sync, o_sync_q_16s, true).
causes_false(q_1s, o_sync_q_16s, true).
causes_false(q_2s, o_sync_q_16s, true).
causes_false(q_3s, o_sync_q_16s, true).
causes_false(q_4s, o_sync_q_16s, true).
causes_false(q_5s, o_sync_q_16s, true).
causes_false(q_6s, o_sync_q_16s, true).
causes_false(q_7s, o_sync_q_16s, true).
causes_false(q_8s, o_sync_q_16s, true).
causes_false(q_9s, o_sync_q_16s, true).
causes_false(q_10s, o_sync_q_16s, true).
causes_false(q_11s, o_sync_q_16s, true).
causes_false(q_12s, o_sync_q_16s, true).
causes_false(q_13s, o_sync_q_16s, true).
causes_false(q_14s, o_sync_q_16s, true).
causes_false(q_15s, o_sync_q_16s, true).
causes_false(q_16s, o_sync_q_16s, true).

