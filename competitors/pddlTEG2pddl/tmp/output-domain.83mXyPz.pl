:- dynamic domain_name/1.

domain_name('blocks-domain').

:- dynamic is_subtype/2.

is_subtype(block, 'NO_TYPE').

:- dynamic fluent/1.

fluent(ontable(_)).
fluent(on(_, _)).
fluent(clear(_)).
fluent(emptyhand).
fluent(holding(_)).

:- dynamic fluent_args/2.

fluent_args(ontable, [block]).
fluent_args(on, [block, block]).
fluent_args(clear, [block]).
fluent_args(emptyhand, []).
fluent_args(holding, [block]).

:- dynamic action/1.

action('pick-up'(_)).
action('put-down'(_)).
action(stack(_, _)).
action(unstack(_, _)).

:- dynamic action_args/2.

action_args('pick-up', [block]).
action_args('put-down', [block]).
action_args(stack, [block, block]).
action_args(unstack, [block, block]).

:- dynamic poss/2.

poss('pick-up'(A), and(clear(A), and(ontable(A), emptyhand))).
poss('put-down'(A), holding(A)).
poss(stack(A, B), and(holding(A), clear(B))).
poss(unstack(A, B), and(on(A, B), and(clear(A), emptyhand))).

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

