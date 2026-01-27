:- dynamic is_verbose.

%% verbosity

%is_verbose.
%noverbose.
verbose :- assert(is_verbose).
noverbose :- retractall(is_verbose).

dwritef(X,Y) :-
	(is_verbose -> writef(X,Y);true).
