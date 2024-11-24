:- dynamic is_subtype/2.

is_subtype(rover, 'NO_TYPE').
is_subtype(waypoint, 'NO_TYPE').
is_subtype(store, 'NO_TYPE').
is_subtype(camera, 'NO_TYPE').
is_subtype(mode, 'NO_TYPE').
is_subtype(lander, 'NO_TYPE').
is_subtype(objective, 'NO_TYPE').

:- dynamic fluent/1.

fluent(at(_, _)).
fluent(at_lander(_, _)).
fluent(can_traverse(_, _, _)).
fluent(equipped_for_soil_analysis(_)).
fluent(equipped_for_rock_analysis(_)).
fluent(equipped_for_imaging(_)).
fluent(empty(_)).
fluent(have_rock_analysis(_, _)).
fluent(have_soil_analysis(_, _)).
fluent(full(_)).
fluent(calibrated(_, _)).
fluent(supports(_, _)).
fluent(available(_)).
fluent(visible(_, _)).
fluent(have_image(_, _, _)).
fluent(communicated_soil_data(_)).
fluent(communicated_rock_data(_)).
fluent(communicated_image_data(_, _)).
fluent(at_soil_sample(_)).
fluent(at_rock_sample(_)).
fluent(visible_from(_, _)).
fluent(store_of(_, _)).
fluent(calibration_target(_, _)).
fluent(on_board(_, _)).
fluent(channel_free(_)).
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

:- dynamic fluent_args/2.

fluent_args(at, [rover, waypoint]).
fluent_args(at_lander, [lander, waypoint]).
fluent_args(can_traverse, [rover, waypoint, waypoint]).
fluent_args(equipped_for_soil_analysis, [rover]).
fluent_args(equipped_for_rock_analysis, [rover]).
fluent_args(equipped_for_imaging, [rover]).
fluent_args(empty, [store]).
fluent_args(have_rock_analysis, [rover, waypoint]).
fluent_args(have_soil_analysis, [rover, waypoint]).
fluent_args(full, [store]).
fluent_args(calibrated, [camera, rover]).
fluent_args(supports, [camera, mode]).
fluent_args(available, [rover]).
fluent_args(visible, [waypoint, waypoint]).
fluent_args(have_image, [rover, objective, mode]).
fluent_args(communicated_soil_data, [waypoint]).
fluent_args(communicated_rock_data, [waypoint]).
fluent_args(communicated_image_data, [objective, mode]).
fluent_args(at_soil_sample, [waypoint]).
fluent_args(at_rock_sample, [waypoint]).
fluent_args(visible_from, [objective, waypoint]).
fluent_args(store_of, [store, rover]).
fluent_args(calibration_target, [camera, objective]).
fluent_args(on_board, [camera, rover]).
fluent_args(channel_free, [lander]).
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

:- dynamic action/1.

action(navigate(_, _, _)).
action(sample_soil(_, _, _)).
action(sample_rock(_, _, _)).
action(drop(_, _)).
action(calibrate(_, _, _, _)).
action(take_image(_, _, _, _, _)).
action(communicate_soil_data(_, _, _, _, _)).
action(communicate_rock_data(_, _, _, _, _)).
action(communicate_image_data(_, _, _, _, _, _)).
action(o_copy).
action(o_goal).
action(o_sync_q_1s).
action(o_sync_q_2s_1).
action(o_sync_q_2s_2).
action(o_sync_q_3s_1).
action(o_sync_q_3s_2).
action(o_sync_q_4s).
action(o_sync_q_5s).
action(o_sync_q_6s).
action(o_sync_q_7s).

:- dynamic action_args/2.

action_args(navigate, [rover, waypoint, waypoint]).
action_args(sample_soil, [rover, store, waypoint]).
action_args(sample_rock, [rover, store, waypoint]).
action_args(drop, [rover, store]).
action_args(calibrate, [rover, camera, objective, waypoint]).
action_args(take_image, [rover, waypoint, objective, camera, mode]).
action_args(communicate_soil_data, [rover, lander, waypoint, waypoint, waypoint]).
action_args(communicate_rock_data, [rover, lander, waypoint, waypoint, waypoint]).
action_args(communicate_image_data, [rover, lander, objective, mode, waypoint, waypoint]).
action_args(o_copy, []).
action_args(o_goal, []).
action_args(o_sync_q_1s, []).
action_args(o_sync_q_2s_1, []).
action_args(o_sync_q_2s_2, []).
action_args(o_sync_q_3s_1, []).
action_args(o_sync_q_3s_2, []).
action_args(o_sync_q_4s, []).
action_args(o_sync_q_5s, []).
action_args(o_sync_q_6s, []).
action_args(o_sync_q_7s, []).

:- dynamic poss/2.

poss(navigate(A, B, C), and(and(can_traverse(A, B, C), and(available(A), and(at(A, B), visible(B, C)))), and(f_ok, f_world))).
poss(sample_soil(A, B, C), and(and(at(A, C), and(at_soil_sample(C), and(equipped_for_soil_analysis(A), and(store_of(B, A), empty(B))))), and(f_ok, f_world))).
poss(sample_rock(A, B, C), and(and(at(A, C), and(at_rock_sample(C), and(equipped_for_rock_analysis(A), and(store_of(B, A), empty(B))))), and(f_ok, f_world))).
poss(drop(A, B), and(and(store_of(B, A), full(B)), and(f_ok, f_world))).
poss(calibrate(A, B, C, D), and(and(equipped_for_imaging(A), and(calibration_target(B, C), and(at(A, D), and(visible_from(C, D), on_board(B, A))))), and(f_ok, f_world))).
poss(take_image(A, B, C, D, E), and(and(calibrated(D, A), and(on_board(D, A), and(equipped_for_imaging(A), and(supports(D, E), and(visible_from(C, B), at(A, B)))))), and(f_ok, f_world))).
poss(communicate_soil_data(A, B, C, D, E), and(and(at(A, D), and(at_lander(B, E), and(have_soil_analysis(A, C), and(visible(D, E), and(available(A), channel_free(B)))))), and(f_ok, f_world))).
poss(communicate_rock_data(A, B, C, D, E), and(and(at(A, D), and(at_lander(B, E), and(have_rock_analysis(A, C), and(visible(D, E), and(available(A), channel_free(B)))))), and(f_ok, f_world))).
poss(communicate_image_data(A, B, C, D, E, F), and(and(at(A, E), and(at_lander(B, F), and(have_image(A, C, D), and(visible(E, F), and(available(A), channel_free(B)))))), and(f_ok, f_world))).
poss(o_copy, and(f_ok, f_copy)).
poss(o_goal, and(and(f_world, f_ok), and(not(q_1), and(not(q_2), and(not(q_3), and(not(q_4), and(not(q_5), not(q_6)))))))).
poss(o_sync_q_1s, and(and(f_sync, f_ok), q_1t)).
poss(o_sync_q_2s_1, and(and(f_sync, f_ok), q_2t)).
poss(o_sync_q_2s_2, and(and(f_sync, f_ok), q_2t)).
poss(o_sync_q_3s_1, and(and(f_sync, f_ok), q_3t)).
poss(o_sync_q_3s_2, and(and(f_sync, f_ok), q_3t)).
poss(o_sync_q_4s, and(and(f_sync, f_ok), q_4t)).
poss(o_sync_q_5s, and(and(f_sync, f_ok), q_5t)).
poss(o_sync_q_6s, and(and(f_sync, f_ok), q_6t)).
poss(o_sync_q_7s, and(and(f_sync, f_ok), q_7t)).

:- dynamic causes_true/3.

causes_true(at(A, B), navigate(A, _, B), true).
causes_true(full(A), sample_soil(_, A, _), true).
causes_true(have_soil_analysis(A, B), sample_soil(A, _, B), true).
causes_true(full(A), sample_rock(_, A, _), true).
causes_true(have_rock_analysis(A, B), sample_rock(A, _, B), true).
causes_true(empty(A), drop(_, A), true).
causes_true(calibrated(A, B), calibrate(B, A, _, _), true).
causes_true(have_image(A, B, C), take_image(A, _, B, _, C), true).
causes_true(channel_free(A), communicate_soil_data(_, A, _, _, _), true).
causes_true(communicated_soil_data(A), communicate_soil_data(_, _, A, _, _), true).
causes_true(available(A), communicate_soil_data(A, _, _, _, _), true).
causes_true(channel_free(A), communicate_rock_data(_, A, _, _, _), true).
causes_true(communicated_rock_data(A), communicate_rock_data(_, _, A, _, _), true).
causes_true(available(A), communicate_rock_data(A, _, _, _, _), true).
causes_true(channel_free(A), communicate_image_data(_, A, _, _, _, _), true).
causes_true(communicated_image_data(A, B), communicate_image_data(_, _, A, B, _, _), true).
causes_true(available(A), communicate_image_data(A, _, _, _, _, _), true).
causes_true(f_copy, navigate(_, _, _), true).
causes_true(f_copy, sample_soil(_, _, _), true).
causes_true(f_copy, sample_rock(_, _, _), true).
causes_true(f_copy, drop(_, _), true).
causes_true(f_copy, calibrate(_, _, _, _), true).
causes_true(f_copy, take_image(_, _, _, _, _), true).
causes_true(f_copy, communicate_soil_data(_, _, _, _, _), true).
causes_true(f_copy, communicate_rock_data(_, _, _, _, _), true).
causes_true(f_copy, communicate_image_data(_, _, _, _, _, _), true).
causes_true(f_sync, o_copy, true).
causes_true(q_1t, o_copy, true).
causes_true(q_1s, o_copy, q_1).
causes_true(q_2s, o_copy, q_2).
causes_true(q_3s, o_copy, q_3).
causes_true(q_4s, o_copy, q_4).
causes_true(q_5s, o_copy, q_5).
causes_true(q_6s, o_copy, q_6).
causes_true(q_7s, o_copy, q_7).
causes_true(f_goal, o_goal, true).
causes_true(q_3s, o_sync_q_1s, q_1s).
causes_true(q_2s, o_sync_q_1s, q_1s).
causes_true(q_2t, o_sync_q_1s, true).
causes_true(q_4s, o_sync_q_2s_1, q_2s).
causes_true(q_3t, o_sync_q_2s_1, true).
causes_true(q_6, o_sync_q_2s_2, q_2s).
causes_true(q_2, o_sync_q_2s_2, q_2s).
causes_true(q_3t, o_sync_q_2s_2, true).
causes_true(q_5s, o_sync_q_3s_1, q_3s).
causes_true(q_4t, o_sync_q_3s_1, true).
causes_true(q_6, o_sync_q_3s_2, q_3s).
causes_true(q_3, o_sync_q_3s_2, q_3s).
causes_true(q_4t, o_sync_q_3s_2, true).
causes_true(q_5t, o_sync_q_4s, true).
causes_true(q_6t, o_sync_q_5s, true).
causes_true(q_7t, o_sync_q_6s, true).
causes_true(f_world, o_sync_q_7s, true).
causes_true(q_1, o_sync_q_7s, q_1s).
causes_true(q_2, o_sync_q_7s, q_2s).
causes_true(q_3, o_sync_q_7s, q_3s).
causes_true(q_4, o_sync_q_7s, q_4s).
causes_true(q_5, o_sync_q_7s, q_5s).
causes_true(q_6, o_sync_q_7s, q_6s).
causes_true(q_7, o_sync_q_7s, q_7s).

:- dynamic causes_false/3.

causes_false(at(A, B), navigate(A, B, _), true).
causes_false(empty(A), sample_soil(_, A, _), true).
causes_false(at_soil_sample(A), sample_soil(_, _, A), true).
causes_false(empty(A), sample_rock(_, A, _), true).
causes_false(at_rock_sample(A), sample_rock(_, _, A), true).
causes_false(full(A), drop(_, A), true).
causes_false(calibrated(A, B), take_image(B, _, _, A, _), true).
causes_false(available(A), communicate_soil_data(A, _, _, _, _), true).
causes_false(channel_free(A), communicate_soil_data(_, A, _, _, _), true).
causes_false(available(A), communicate_rock_data(A, _, _, _, _), true).
causes_false(channel_free(A), communicate_rock_data(_, A, _, _, _), true).
causes_false(available(A), communicate_image_data(A, _, _, _, _, _), true).
causes_false(channel_free(A), communicate_image_data(_, A, _, _, _, _), true).
causes_false(f_world, navigate(_, _, _), true).
causes_false(f_world, sample_soil(_, _, _), true).
causes_false(f_world, sample_rock(_, _, _), true).
causes_false(f_world, drop(_, _), true).
causes_false(f_world, calibrate(_, _, _, _), true).
causes_false(f_world, take_image(_, _, _, _, _), true).
causes_false(f_world, communicate_soil_data(_, _, _, _, _), true).
causes_false(f_world, communicate_rock_data(_, _, _, _, _), true).
causes_false(f_world, communicate_image_data(_, _, _, _, _, _), true).
causes_false(f_copy, o_copy, true).
causes_false(q_1, o_copy, true).
causes_false(q_2, o_copy, true).
causes_false(q_3, o_copy, true).
causes_false(q_4, o_copy, true).
causes_false(q_5, o_copy, true).
causes_false(q_6, o_copy, true).
causes_false(q_7, o_copy, true).
causes_false(q_1s, o_sync_q_1s, q_1s).
causes_false(q_1t, o_sync_q_1s, true).
causes_false(q_2s, o_sync_q_2s_1, q_2s).
causes_false(q_2t, o_sync_q_2s_1, true).
causes_false(q_2s, o_sync_q_2s_2, q_2s).
causes_false(q_2t, o_sync_q_2s_2, true).
causes_false(q_3s, o_sync_q_3s_1, q_3s).
causes_false(q_3t, o_sync_q_3s_1, true).
causes_false(q_3s, o_sync_q_3s_2, q_3s).
causes_false(q_3t, o_sync_q_3s_2, true).
causes_false(q_4s, o_sync_q_4s, q_4s).
causes_false(f_ok, o_sync_q_4s, and(q_4s, not(communicated_soil_data(waypoint2)))).
causes_false(q_4t, o_sync_q_4s, true).
causes_false(q_5s, o_sync_q_5s, q_5s).
causes_false(f_ok, o_sync_q_5s, and(q_5s, not(communicated_soil_data(waypoint1)))).
causes_false(q_5t, o_sync_q_5s, true).
causes_false(q_6s, o_sync_q_6s, q_6s).
causes_false(q_6t, o_sync_q_6s, true).
causes_false(f_ok, o_sync_q_7s, q_7s).
causes_false(q_7t, o_sync_q_7s, true).
causes_false(f_sync, o_sync_q_7s, true).
causes_false(q_1s, o_sync_q_7s, true).
causes_false(q_2s, o_sync_q_7s, true).
causes_false(q_3s, o_sync_q_7s, true).
causes_false(q_4s, o_sync_q_7s, true).
causes_false(q_5s, o_sync_q_7s, true).
causes_false(q_6s, o_sync_q_7s, true).
causes_false(q_7s, o_sync_q_7s, true).

