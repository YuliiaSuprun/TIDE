:- dynamic domain_name/1.

domain_name(rover).

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

:- dynamic poss/2.

poss(navigate(A, B, C), and(can_traverse(A, B, C), and(available(A), and(at(A, B), visible(B, C))))).
poss(sample_soil(A, B, C), and(at(A, C), and(at_soil_sample(C), and(equipped_for_soil_analysis(A), and(store_of(B, A), empty(B)))))).
poss(sample_rock(A, B, C), and(at(A, C), and(at_rock_sample(C), and(equipped_for_rock_analysis(A), and(store_of(B, A), empty(B)))))).
poss(drop(A, B), and(store_of(B, A), full(B))).
poss(calibrate(A, B, C, D), and(equipped_for_imaging(A), and(calibration_target(B, C), and(at(A, D), and(visible_from(C, D), on_board(B, A)))))).
poss(take_image(A, B, C, D, E), and(calibrated(D, A), and(on_board(D, A), and(equipped_for_imaging(A), and(supports(D, E), and(visible_from(C, B), at(A, B))))))).
poss(communicate_soil_data(A, B, C, D, E), and(at(A, D), and(at_lander(B, E), and(have_soil_analysis(A, C), and(visible(D, E), and(available(A), channel_free(B))))))).
poss(communicate_rock_data(A, B, C, D, E), and(at(A, D), and(at_lander(B, E), and(have_rock_analysis(A, C), and(visible(D, E), and(available(A), channel_free(B))))))).
poss(communicate_image_data(A, B, C, D, E, F), and(at(A, E), and(at_lander(B, F), and(have_image(A, C, D), and(visible(E, F), and(available(A), channel_free(B))))))).

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

