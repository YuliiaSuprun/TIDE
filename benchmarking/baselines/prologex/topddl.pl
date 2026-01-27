:- dynamic constant/1,action/1,initially_true/1,poss/2,fluent/1,new_fluent/1,new_initially_true/1,new_poss/2,causes_true/3,virtual_causes_true/3,causes_false/3, derived/2, of_type/2,is_subtype/2,fluent_args/2,action_args/2,implicit_action_args/2,implicit_of_type/2,landmark/3,implicit_is_subtype/2,static_fluent/1,goal/1, preference/2, new_preference/2.

:- dynamic(indent_val/1).

%:- verbose.

%% Predicates for the generation of new domain/problem

indent_val(0).

topddl_dp(Path,DomainName,ProblemName) :-
	topddl(Path,DomainName,ProblemName,dp).

topddl_cr(Path,DomainName,ProblemName) :-
	topddl(Path,DomainName,ProblemName,cr).

topddl(Path,DomainName,ProblemName,Type) :-
	clean_domain,
	retractall(indent_val(_)),
	asserta(indent_val(0)),
	concat_atom([Path,'/',DomainName],DomainFile),
	concat_atom([Path,'/',ProblemName],ProblemFile),
	consult(DomainFile),
	consult(ProblemFile),
	get_all_goals(NewGoal),
	writef("New Goal=%q",[NewGoal]),
%	time(compute_new_domain(NewGoal,Type)),
%	findall([Name,Formula],preference(Name,Formula),Preferences),
%	writef("Preferences=%q\n",[Preferences]),
%	time(compute_new_domain_preferences(Preferences,Type)),
	write_pddl(Path,DomainName,ProblemName,Type),
	statistics(cputime,H),
	statistics(inferences,Infe),
	nl, writef("ToPddl CPU time: %q, Number of Inferences: %q\n",[H,Infe]),nl.




limit(natural_ordering,100).
limit(necessary_ordering,100).
limit(greedy_necessary_ordering,100).
limit(reasonable_ordering,100).

remove_all_same_args(_,[],[]).
remove_all_same_args(X,[E|L],Lp) :-
	X=..[_|Args],
	E=..[_|Args2],
	copy_term(Args,Args2),!,
	remove_all_same_args(X,L,Lp).

remove_all_same_args(X,[E|L],[E|Lp]) :-
	remove_all_same_args(X,L,Lp).
	

filter_landmarks([],[]).
filter_landmarks([L|Ls],[L|Lp]) :-
	L=..[_,A,B],
	remove_all_same_args(any_landmark(A,_),Ls,Ls1),
	remove_all_same_args(any_landmark(_,B),Ls1,Ls2),
	remove_all_same_args(any_landmark(_,A),Ls2,Ls3),
	remove_all_same_args(any_landmark(B,_),Ls3,Ls4),
	filter_landmarks(Ls4,Lp).
	

get_all_goals(All) :-
	findall(X,goal(X),Additional),
	to_and(Additional,All).


first_N([],_,[]).
first_N(_,0,[]).
first_N([X|Xs],N,[X|Ys]) :- 
	N>0,
	M is N-1,
	first_N(Xs,M,Ys).

conjoin([],G,G).
conjoin([G|Gs],OrigGoal,and(G,Goal)) :-
	conjoin(Gs,OrigGoal,Goal).
		

write_pddl(Path,DomainName,ProblemName,Type) :-
	concat_atom([Path,'/',DomainName],_DomainFile),
	concat_atom([Path,'/',ProblemName],_ProblemFile),
%	consult(DomainFile),
%	consult(ProblemFile),
	concat_atom([Path,'/',DomainName,'_',ProblemName,'_',Type,'.pddl'],PddlDomainFile),
	concat_atom([Path,'/',ProblemName,'_',Type,'.pddl'],PddlProblemFile),
	tell(PddlDomainFile),
	write_domain(DomainName),
	told,
	tell(PddlProblemFile),
	write_problem(DomainName,ProblemName),
	told.


write_problem(DomainName,ProblemName) :-
	iwritef("(define (problem %q)\n",[ProblemName]),nl,
	inc_indent,
	iwritef("(:domain %q)\n",[DomainName]),
	write_objects,
	write_initial_state,
	write_goal,
	(write_constraints;true),
	(write_metric;true),
	writef(")"),
	dec_indent.

write_objects :-
	iwritef("(:objects "),
	findall(Obj,constant(Obj),Objects),
	(of_type(_,_) ->
	    findall(Type,(constant(Obj),of_type(Obj,Type)),Types),
	    integrate_types(Objects,Types,ObjType);
	    ObjType=Obj
	),
	write_list(ObjType),writef(")\n").

write_initial_state :-
	iwritef("(:init \n"),
	inc_indent,
	forall(initially_true(F),(iwritef(""),write_term(F),nl)),
	dec_indent,
	iwritef(")\n").

write_goal :-
	iwritef("(:goal "),
	goal(Fla),
	lisp_vars(Fla),
	flatten_and(Fla,GoalFla),
	write_formula(GoalFla),writef(")"),nl.

write_constraints :-
	nl,
	preference(_,_),
	iwritef("(:constraints (and"),
	inc_indent,
	forall(preference(Name,Pref),(iwritef(""),
	                                  lisp_vars(Pref),
					  nl,iwritef("(preference %q ",[Name]), 
					  write_formula(Pref),
				          writef(")"))),
	writef("))"),dec_indent,nl,nl.

write_metric :-
	metric(Dir,Formula),!,
	iwritef("(:metric %q ",[Dir]),
    write_formula(Formula),
	iwritef(")"),nl.

write_domain(DomainName) :-
	iwritef("(define (domain %q)\n",[DomainName]),
	inc_indent,
	write_domain_types,
	write_domain_predicates,
	write_domain_effs,
	write_derived_predicates,
	writef(")"),
	dec_indent.

write_derived_predicates :-
	forall(derived(F,DD),
	       (
		 flatten_and(DD,DD1),
		 flatten_or(DD1,D),
		 writef("(:derived "),nl,
		 inc_indent,iwritef(""),
		 lisp_vars(F,0,F1,_,_),	%% assuming F has no variables
		 write_term(F),
		 nl,
		 iwritef(""),
		 lisp_vars(D,F1,_,_,_), %% assuming D has no variables
		 write_formula(D),
		 dec_indent,
		 nl,writef(")\n\n")
	       )).

write_domain_types :- \+is_subtype(_,_).
write_domain_types :-
	is_subtype(_,_),
	iwritef("(:types\n"),
	inc_indent,
	forall(is_subtype(Type,Super),
	       (iwritef(Type),
	       writef(" - "),
	       writef(Super),
	       nl)),
	dec_indent,iwritef(")\n\n").


write_domain_predicates :-
	iwritef("(:predicates\n"),
	inc_indent,
	findall(F, (
		     fluent(F),
		     F=..[FluentName|_],
		     lisp_vars(F,0,_,_,FluentVars),
		     (fluent_args(FluentName,FluentTypes) ->
			 integrate_types(FluentVars,FluentTypes,FluentArgs);
			 FluentArgs=FluentVars
		     ),
		     iwritef(""),
		     PTerm=..[FluentName|FluentArgs],
		     write_term(PTerm),
		     nl
		   ),
		_),
	dec_indent,
	iwritef(")"),nl.


write_domain_effs :-
	findall(Action,
		(
		  action(Action),Action=..[ActionName|_],
		  lisp_vars(Action,0,F1,ActionFunctor,ActionVars),
		  action_args(ActionName,ArgTypes),
		  integrate_types(ActionVars,ArgTypes,ActionParams),
		  findall(Effect,
			  (
			    (causes_true(Fluent,Action,Condition)
			    ;
			    (causes_false(F,Action,Condition),Fluent=not(F))),
			    lisp_vars(Condition,F1,F2,_,ConditionVars),
			    lisp_vars(Fluent,F2,_,_,FluentVars),
			    (Condition = true ->
				Eff=forall(FluentVars,Fluent)
			    ;
				Eff=forall(ConditionVars,when(Condition,forall(FluentVars,Fluent)))
			    ),flatten_and(Eff,Eff1),flatten_or(Eff1,Effect)),  
			  Effects),
		  poss(Action,PossCond),
		  lisp_vars(PossCond,F1,_,_,PossVars),
		  vars_in_foralls(PossCond,ForallVars),
		  subtract(PossVars,ForallVars,AllVars),
		  write_effects_action(ActionFunctor,ActionParams,Effects,exists(AllVars,PossCond))
		),
		_).

integrate_types([Arg|As],[Type|Ts],[Arg,'-',Type|Rest]) :-
	Type\='NO_TYPE',
	integrate_types(As,Ts,Rest).
integrate_types([Arg|As],['NO_TYPE'|Ts],[Arg|Rest]) :-
	integrate_types(As,Ts,Rest).
integrate_types([],[],[]).
	
write_effects_action(ActionFunctor,ActionVars,Effects,PossCond) :-
	iwritef("(:action %w\n",[ActionFunctor]),
	inc_indent,
	iwritef(":parameters "),
	writef("("),write_arg_list(ActionVars),writef(")\n"),
	iwritef(":precondition \n"),
	inc_indent,
	iwritef(""),
	flatten_and(PossCond,FlatPossCond),
	write_formula(FlatPossCond),nl,
	dec_indent,
	iwritef(":effect\n"),inc_indent,
	length(Effects,N),
	(N=1 ->
	    Effects=[SingleEff],
	    write_formula(SingleEff)
	;
	    iwritef("(and"),nl,
	    inc_indent,
	    forall(member(E,Effects),(iwritef(""),write_formula(E),nl)),
	    dec_indent,
	    iwritef(")\n")
	),
	dec_indent,
	iwritef(")\n"),
	dec_indent.

write_formula(all(X,Fla)) :-
	\+ is_list(X),
	write_formula(forall([X],Fla)).
		     
write_formula(exists(X,Fla)) :-
	\+ is_list(X),
	write_formula(exists([X],Fla)).


write_formula(forall([],Fla)) :- !,write_formula(Fla).
write_formula(forall(L,Fla)) :- is_list(L),
	L\=[],!,
	writef("(forall ("),
	write_list(L),writef(")"),nl,
	inc_indent,
	iwritef(""),write_formula(Fla),
	writef(")"),nl,
	dec_indent.
	
write_formula(exists([],Fla)) :- !,write_formula(Fla).
write_formula(exists(L,Fla)) :- is_list(L),!,
	L\=[],
	writef("(exists ("),
	write_list(L),writef(")"),nl,
	inc_indent,
	iwritef(""),write_formula(Fla),
	writef(")"),nl,
	dec_indent.


write_formula(T) :- T=..[and|Args],!,
	writef("(and"),
	inc_indent,
	write_bool_args(Args),
	writef(")"),
	dec_indent.

write_formula(T) :- T=..[or|Args],!,
	writef("(or"),
	inc_indent,
	write_bool_args(Args),
	writef(")"),
	dec_indent.

write_formula(T) :- T=..[+|Args],!,
	writef("(+"),
	inc_indent,
	write_bool_args(Args),
	writef(")"),
	dec_indent.

write_formula(T) :- T=..[-|Args],!,
	writef("(-"),
	inc_indent,
	write_bool_args(Args),
	writef(")"),
	dec_indent.

write_formula(T) :- T=..[*|Args],!,
	writef("(*"),
	inc_indent,
	write_bool_args(Args),
	writef(")"),
	dec_indent.


write_formula(when(F1,F2)) :- !,
	writef("(when\n"),
	inc_indent,
	iwritef(""),write_formula(F1),nl,
	iwritef(""),write_formula(F2),
	writef(")"),
	dec_indent.

write_formula(imply(F1,F2)) :- !,
	writef("(imply\n"),
	inc_indent,
	iwritef(""),write_formula(F1),nl,
	iwritef(""),write_formula(F2),
	writef(")"),
	dec_indent.


write_formula(equal(X,Y)) :- !,
	writef("(= "),write_list([X,Y]),writef(")").

write_formula(EitherTerm) :- EitherTerm=..[either|TypeList],!,
	writef("(either "),write_list(TypeList),writef(")").


write_formula(not(F)) :- !,
	writef("(not \n"),
	inc_indent,
	iwritef(""),write_formula(F),
	writef(")"),
	dec_indent.

write_formula(F) :- 
	number(F),!,
	writef("%q",[F]).

write_formula(F) :-
	atom(F),
	atom_to_term(F,N,[]),
	number(N),!,
	writef("%q",[N]).


write_formula(F) :- %must be a term
	write_term(F).

write_term(F) :-
	F=..List,
	writef("("),
	write_arg_list(List),
	writef(")").


write_list([]).
write_list([X|Xs]) :-
	write(X),
	(Xs \= [] ->
	    writef(" "),
	    write_list(Xs)
	;
	    true).

write_arg_list([]).
write_arg_list([X|Xs]) :-
	\+ X=..[either|_],
	write(X),
	(Xs \= [] ->
	    writef(" "),
	    write_arg_list(Xs)
	;
	    true).

write_arg_list([X|Xs]) :-
	X=..[either|_],
	write_formula(X),
	(Xs \= [] ->
	    writef(" "),
	    write_arg_list(Xs)
	;
	    true).


write_bool_args([]).
write_bool_args([Arg|Args]) :-
	nl,
	iwritef(""),
	write_formula(Arg),
	write_bool_args(Args).



lisp_vars(Term) :-
	lisp_vars(Term,0,_,_,_).

lisp_vars(Term,Init,Fin,Functor,Vars) :-
	term_variables(Term,Vars),
	Term=..[Functor|_],
	lisp_inst_list(Vars,Init,Fin).

lisp_inst_list([],I,I).
lisp_inst_list([V|Vs],Init,Fin) :-
	concat_atom(['?x',Init],V),
	Ip is Init + 1,
	lisp_inst_list(Vs,Ip,Fin).
	

is_lisp_var(Var) :- concat_atom(['?',_],Var).

subterm(Term, Term).

subterm(Sub,Term) :-
	compound(Term),
	Term=..[_|L],
	subterm_list(Sub,L).

subterm_list(Sub,[Term|_L]) :-
	subterm(Sub,Term).

subterm_list(Sub,[_|L]) :-
	subterm_list(Sub,L).

vars_in_foralls(Formula,Vars) :-
	findall(Var,(subterm(forall(Args,_F),Formula),member(Var,Args),is_lisp_var(Var)),Vars).



%% Predicates for pretty printing of formulae

inc_indent :-
	indent_val(X),
	retract(indent_val(_)),
	Xp is X+1,
	asserta(indent_val(Xp)).

dec_indent :-
	indent_val(X),
	retract(indent_val(_)),
	(X>0 -> Xp is X-1),
	asserta(indent_val(Xp)).

write_indent :-
	indent_val(X),
	write_indent(X).

write_indent(0).
write_indent(X) :-
	X>0,
	writef("  "),
	Xp is X-1,
	write_indent(Xp).


iwritef(String) :-
	write_indent,
	(String \= [] -> writef(String);true).

iwritef(String,List) :-
	write_indent,
	(String \= [] -> writef(String,List);true).


flatten_and(V,V) :- var(V),!.
flatten_and(F,F) :- atomic(F),!.
flatten_and(X, Y) :-
	X=..[and|L],!,
	remove_and_all(L,Lp),
	Y=..[and|Lp].
flatten_and(F,Fp) :-
	F=..[X|L],
	X\==and,!,
	flatten_and_list(L,Lp),
	Fp=..[X|Lp].
	

%flatten_and(X,Y) :- writef("FAILED with arguments (%q,%q)\n",[X,Y]),!,fail.

	
flatten_and_list([],[]).
flatten_and_list([X|L],[Xp|Lp]) :-
	flatten_and(X,Xp),
	flatten_and_list(L,Lp).

remove_and_all([X|Rest],FRest) :-
	X=..[and|L],!,
	remove_and_all(L,Lp),
	remove_and_all(Rest,Restp),
	append(Lp,Restp,FRest).


remove_and_all([X|Rest],[Xp|Restp]) :-
	X=..[Z|L],
%	Z\==and,
	flatten_and_list(L,Lp),
	remove_and_all(Rest,Restp),
	Xp=..[Z|Lp].

remove_and_all([],[]).


flatten_or(V,V) :- var(V),!.
flatten_or(F,F) :- atomic(F),!.
	
flatten_or(X, Y) :-
	X=..[or|L],!,
	remove_or_all(L,Lp),
	Y=..[or|Lp].

flatten_or(F,Fp) :-
	F=..[X|L],
%	X\==or,
	flatten_or_list(L,Lp),
	Fp=..[X|Lp].

%flatten_or(X,Y) :- writef("FAILED with arguments (%q,%q)\n",[X,Y]),!,fail.

	
flatten_or_list([],[]).
flatten_or_list([X|L],[Xp|Lp]) :-
	flatten_or(X,Xp),
	flatten_or_list(L,Lp).

remove_or_all([X|Rest],FRest) :-
	X=..[or|L],!,
	remove_or_all(L,Lp),
	remove_or_all(Rest,Restp),
	append(Lp,Restp,FRest).


remove_or_all([X|Rest],[Xp|Restp]) :-
	X=..[Z|L],
%	Z\==or,
	flatten_or_list(L,Lp),
	remove_or_all(Rest,Restp),
	Xp=..[Z|Lp].

remove_or_all([],[]).

clean_domain :-
	retractall(goal(_)),
	retractall(new_fluent(_)),
	retractall(new_goal(_)),
	retractall(fluent(_)),
	retractall(static_fluent(_)),
	retractall(new_fluent(_,_)),
	retractall(constant(_)),
	retractall(action(_)),
	retractall(initially_true(_)),
	retractall(new_initially_true(_)),
	retractall(poss(_,_)),
	retractall(new_poss(_,_)),
	retractall(causes_true(_,_,_)),
	retractall(virtual_causes_true(_,_,_)),
	retractall(causes_false(_,_,_)),
	retractall(derived(_,_)),
	retractall(of_type(_,_)),
	retractall(implicit_of_type(_,_)),
	retractall(is_subtype(_,_)),
	retractall(implicit_is_subtype(_,_)),
	retractall(fluent_args(_,_)),
	retractall(action_args(_,_)),
	retractall(implicit_action_args(_,_)),
	retractall(landmark(_,_,_)).

to_and([],true).
to_and([X],X) :- !.
to_and([X|L],and(X,R)) :-
	to_and(L,R).

