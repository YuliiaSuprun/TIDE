:- dynamic problem_name/1.

problem_name(roverprob2435).

:- dynamic initially_true/1.

initially_true(visible(waypoint0, waypoint2)).
initially_true(visible(waypoint2, waypoint0)).
initially_true(visible(waypoint1, waypoint0)).
initially_true(visible(waypoint0, waypoint1)).
initially_true(visible(waypoint1, waypoint3)).
initially_true(visible(waypoint3, waypoint1)).
initially_true(visible(waypoint2, waypoint1)).
initially_true(visible(waypoint1, waypoint2)).
initially_true(visible(waypoint3, waypoint0)).
initially_true(visible(waypoint0, waypoint3)).
initially_true(visible(waypoint3, waypoint2)).
initially_true(visible(waypoint2, waypoint3)).
initially_true(at_rock_sample(waypoint0)).
initially_true(at_soil_sample(waypoint1)).
initially_true(at_rock_sample(waypoint1)).
initially_true(at_soil_sample(waypoint2)).
initially_true(at_soil_sample(waypoint3)).
initially_true(at_lander(general, waypoint3)).
initially_true(channel_free(general)).
initially_true(at(rover0, waypoint0)).
initially_true(available(rover0)).
initially_true(store_of(rover0store, rover0)).
initially_true(empty(rover0store)).
initially_true(equipped_for_rock_analysis(rover0)).
initially_true(equipped_for_imaging(rover0)).
initially_true(can_traverse(rover0, waypoint0, waypoint1)).
initially_true(can_traverse(rover0, waypoint1, waypoint0)).
initially_true(can_traverse(rover0, waypoint0, waypoint3)).
initially_true(can_traverse(rover0, waypoint3, waypoint0)).
initially_true(at(rover1, waypoint0)).
initially_true(available(rover1)).
initially_true(store_of(rover1store, rover1)).
initially_true(empty(rover1store)).
initially_true(equipped_for_soil_analysis(rover1)).
initially_true(equipped_for_imaging(rover1)).
initially_true(can_traverse(rover1, waypoint0, waypoint1)).
initially_true(can_traverse(rover1, waypoint1, waypoint0)).
initially_true(can_traverse(rover1, waypoint1, waypoint2)).
initially_true(can_traverse(rover1, waypoint2, waypoint1)).
initially_true(can_traverse(rover1, waypoint1, waypoint3)).
initially_true(can_traverse(rover1, waypoint3, waypoint1)).
initially_true(on_board(camera0, rover1)).
initially_true(calibration_target(camera0, objective1)).
initially_true(supports(camera0, high_res)).
initially_true(supports(camera0, low_res)).
initially_true(on_board(camera1, rover1)).
initially_true(calibration_target(camera1, objective1)).
initially_true(supports(camera1, colour)).
initially_true(supports(camera1, high_res)).
initially_true(on_board(camera2, rover0)).
initially_true(calibration_target(camera2, objective1)).
initially_true(supports(camera2, colour)).
initially_true(supports(camera2, high_res)).
initially_true(supports(camera2, low_res)).
initially_true(visible_from(objective0, waypoint0)).
initially_true(visible_from(objective0, waypoint1)).
initially_true(visible_from(objective0, waypoint2)).
initially_true(visible_from(objective0, waypoint3)).
initially_true(visible_from(objective1, waypoint0)).
initially_true(visible_from(objective1, waypoint1)).
initially_true(visible_from(objective1, waypoint2)).
initially_true(visible_from(objective2, waypoint0)).
initially_true(visible_from(objective2, waypoint1)).
initially_true(visible_from(objective2, waypoint2)).

:- dynamic constant/1.

constant(camera0).
constant(camera1).
constant(camera2).
constant(colour).
constant(general).
constant(high_res).
constant(low_res).
constant(objective0).
constant(objective1).
constant(objective2).
constant(rover0).
constant(rover0store).
constant(rover1).
constant(rover1store).
constant(waypoint0).
constant(waypoint1).
constant(waypoint2).
constant(waypoint3).

:- dynamic of_type/2.

of_type(general, lander).
of_type(colour, mode).
of_type(high_res, mode).
of_type(low_res, mode).
of_type(rover0, rover).
of_type(rover1, rover).
of_type(rover0store, store).
of_type(rover1store, store).
of_type(waypoint0, waypoint).
of_type(waypoint1, waypoint).
of_type(waypoint2, waypoint).
of_type(waypoint3, waypoint).
of_type(camera0, camera).
of_type(camera1, camera).
of_type(camera2, camera).
of_type(objective0, objective).
of_type(objective1, objective).
of_type(objective2, objective).

:- dynamic goal/1.

goal(and(eventually(communicated_soil_data(waypoint1)), eventually(communicated_soil_data(waypoint2)))).

:- dynamic preference/2.


:- dynamic hard_constraint/1.


:- dynamic metric/2.


