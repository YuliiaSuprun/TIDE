%%% Constants


% optional predicates declared as dynamic

:- dynamic preference/2, hard_constraint/1, metric/2.

constants_declaration(Constants) :-
	pddl_domain(PDDLDomain),
	(member([':constants'|PDDLConst],PDDLDomain) ->
	    true;
	    PDDLConst=[]
	),
	pddl_problem(PDDLProblem),
	(member([':objects'|PDDLObj],PDDLProblem) ->
	    true;
	    PDDLObj=[]
	),
	append(PDDLConst,PDDLObj,PDDLObjects),
	get_types(PDDLObjects,[],ObjType,of_type),
	setof(constant(X),T^member(of_type(X,T),ObjType),ObjNoType),
	append(ObjNoType,ObjType,Constants).

initial_state(InitState) :-
	pddl_problem(PDDLProblem),
	(member([':init'|PDDLInitial],PDDLProblem) ->
	    true;
	    PDDLInitial=[]
	),
	findall(initially_true(F),
	        (member(Fact,PDDLInitial),pddl_fla_to_prolog(Fact,F)),InitState).


	
%%% Type Extraction

%%get_types(TypeList,ListOfTypes).

get_types([],LT,LT,_).
get_types(['-',_|L],LT,LTp,Functor) :- !,get_types(L,LT,LTp,Functor).
get_types([Type|L],LT,LTp,Functor) :-
	get_next_typename(SuperType,L),
	NewTerm=..[Functor,Type,SuperType],
	append(LT,[NewTerm],LT2),
	get_types(L,LT2,LTp,Functor).


get_next_typename(Name,L) :-
	append(_,['-',N|_],L),!,
	(N=[either|TypeList] ->
	    Name=..[either|TypeList];
	    Name=N).

get_next_typename('NO_TYPE',_).
	

types(T) :-
	pddl_domain(Domain),
	(member([':types'|PDDLTypes],Domain) ->
	    get_types(PDDLTypes,[],T,is_subtype);
	    T=[]
	).


%% free_var_list(+List,-VarList)

%% Unifies VarList with a list of free vars with the same length as List

free_var_list([],[]).
free_var_list([_|Xs],[_|Ys]) :-
	free_var_list(Xs,Ys).

%%% Action Declaration


action_declarations(Actions) :-
	pddl_domain(PDDLDomain),
	findall(X,(member(X,PDDLDomain),X=[':action'|_]),PDDLActions),
	action_declaration(PDDLActions,[],ActionTypes),
	findall(action(T),(member(action(A),ActionTypes),
	           A=..[ActionName|Types],
		   free_var_list(Types,FreeVars),
		   T=..[ActionName|FreeVars]),ActionDecl),
	       
	findall(X,(member(action(A),ActionTypes),
	           A=..[ActionName|Types],
	           X=action_args(ActionName,Types)),ArgTypes),
        append(ActionDecl,ArgTypes,Actions).
 

%% action_declaration(PDDLActions, ActionAccumulator, Actions)
action_declaration([],Actions,Actions).
action_declaration([[':action'|ActInfo]|PDDLActions],ActionAcc,Actions) :-
	ActInfo=[ActionName|_],
	(append(_,[':parameters',ParamList|_],ActInfo) ->
	    get_param_types(ParamList,Types) ;
	    Types = [] % action has no parameters 
	),
	ActionTerm=..[ActionName|Types],
	append(ActionAcc,[action(ActionTerm)],ActionAcc2),
	action_declaration(PDDLActions,ActionAcc2,Actions).
	    
get_param_types(ParamList,Types) :-
	get_types(ParamList,[],TypeList,is_subtype),
	findall(T,member(is_subtype(_,T),TypeList),Types).
	
get_param_args(ParamList,Args) :-
	get_types(ParamList,[],ArgList,is_subtype),
	findall(T,member(is_subtype(T,_),ArgList),Args).


%%% Fluent Declaration


fluent_declarations(Fluents) :-
	pddl_domain(PDDLDomain),
	member([':predicates'|PDDLFluents],PDDLDomain),
	fluent_declaration(PDDLFluents,[],FluentTypes),
	findall(fluent(T),(member(fluent(A),FluentTypes),
	           A=..[FluentName|Types],
		   free_var_list(Types,FreeVars),
		   T=..[FluentName|FreeVars]),FluentDecl),
	       
	findall(X,(member(fluent(A),FluentTypes),
	           A=..[FluentName|Types],
	           X=fluent_args(FluentName,Types)),ArgTypes),
        append(FluentDecl,ArgTypes,Fluents).




%% fluent_declaration(PDDLFluents, FluentAccumulator, Fluents)
fluent_declaration([],Fluents,Fluents).
fluent_declaration([PredInfo|PDDLFluents],FluentAcc,Fluents) :-
	PredInfo=[FluentName|ParamList],
	get_param_types(ParamList,Types),
	FluentTerm=..[FluentName|Types],
	append(FluentAcc,[fluent(FluentTerm)],FluentAcc2),
	fluent_declaration(PDDLFluents,FluentAcc2,Fluents).


%% Precondition Declaration

precondition_declarations(Preconditions) :-
	pddl_domain(PDDLDomain),
	findall(X,(member(X,PDDLDomain),X=[':action'|_]),PDDLActions),
	precondition_declaration(PDDLActions,[],Preconditions).

%% precondition_declaration(PDDLActions, PrecAccumulator, Preconditions)
precondition_declaration([],Precond,Precond).
precondition_declaration([[':action'|ActInfo]|PDDLActions],PrecondAcc,Preconds) :-
	ActInfo=[ActionName|_],
	(append(_,[':parameters',ParamList|_],ActInfo) ->
	    get_param_args(ParamList,Args) ;
	    Args = [] % action has no parameters 
	),
	(append(_,[':precondition',PDDLPrecond|_],ActInfo) ->
	    true ;
	    PDDLPrecond = true % action has no parameters 
	),
	pddl_fla_to_prolog(PDDLPrecond,Precond),
	ActionTerm=..[ActionName|Args],
	LPossTerm=poss(ActionTerm,Precond),
	lisp_vars_to_prolog(LPossTerm,PPossTerm),
	append(PrecondAcc,[PPossTerm],PrecondAcc2),
	precondition_declaration(PDDLActions,PrecondAcc2,Preconds).




effect_declarations(Preconditions) :-
	pddl_domain(PDDLDomain),
	findall(X,(member(X,PDDLDomain),X=[':action'|_]),PDDLActions),
	effect_declaration(PDDLActions,[],Preconditions).


%% effect_declaration(PDDLActions, EffAccumulator, Effects)
effect_declaration([],Effects,Effects).
effect_declaration([[':action'|ActInfo]|PDDLActions],EffAcc,Effects) :-
	ActInfo=[ActionName|_],
	(append(_,[':parameters',ParamList|_],ActInfo) ->
	    get_param_args(ParamList,Args) ;
	    Args = [] % action has no parameters 
	),
	(append(_,[':effect',PDDLEffect|_],ActInfo) ->
	    true ;
	    PDDLEffect = [] % action has no parameters 
	),

	ActionTerm=..[ActionName|Args],

	get_positive_effects(PDDLEffect,true,Positive),
        get_negative_effects(PDDLEffect,true,Negative),
	findall(PEC,(member([Eff,Cond],Positive),LT=causes_true(Eff,ActionTerm,Cond),lisp_vars_to_prolog(LT,PEC)),PositiveEffects),	
	findall(NEC,(member([Eff,Cond],Negative),LT=causes_false(Eff,ActionTerm,Cond),lisp_vars_to_prolog(LT,NEC)),NegativeEffects),
	append(PositiveEffects,NegativeEffects,AllEffects),
	append(EffAcc,AllEffects,EffAcc2),
	effect_declaration(PDDLActions,EffAcc2,Effects).


goal_declaration(Goal) :-
	pddl_problem(PDDLProblem),
	member([':goal',PDDLGoal],PDDLProblem),
	pddl_fla_to_prolog(PDDLGoal,G),
	add_final(G,Gf),
	Goal=[goal(Gf)].
	
add_final(and(X,Y),and(Xp,Yp)) :- !,
	add_final(X,Xp),
	add_final(Y,Yp).

add_final(Term,Term) :- 
	is_temporal(Term),!.

add_final(Term,final(Term)).

is_temporal(or(X,Y)) :- is_temporal(X);is_temporal(Y).
is_temporal(imply(X,Y)) :- is_temporal(X);is_temporal(Y).
is_temporal(implies(X,Y)) :- is_temporal(X);is_temporal(Y).
is_temporal(all(_,X)) :- is_temporal(X).
is_temporal(exists(_,X)) :- is_temporal(X).
is_temporal(sometime(_)).
is_temporal(eventually(_)).
is_temporal(always(_)).
is_temporal(sometime_after(_,_)).
is_temporal(sometime_before(_,_)).
is_temporal(until(_,_)).
is_temporal(release(_,_)).


is_not_term([not|_]).
is_when_term([when|_]).

% get_positive_effects(PDDLEffect,Positive)

get_positive_effects(PDDLEffect,Condition,Positive) :-
	PDDLEffect=[X|_],
	X\=and,
	extract_positive_effects([PDDLEffect],Condition,Positive).

get_positive_effects(PDDLEffect,Condition,Positive) :-
	PDDLEffect=[and|EffectList],
	extract_positive_effects(EffectList,Condition,Positive).

extract_positive_effects([[when,Cond,Eff]|Es],Condition,PEffects) :-
	pddl_fla_to_prolog(Cond,PCond),
	get_positive_effects(Eff,PCond,CondEffs),
	extract_positive_effects(Es,Condition,OtherEffs),
	append(CondEffs,OtherEffs,PEffects).

extract_positive_effects([E|Es],Condition,PEffects) :-
	\+is_not_term(E),
	\+is_when_term(E),
	pddl_fla_to_prolog(E,PE),
	extract_positive_effects(Es,Condition,OtherEffs),
	PEffects=[[PE,Condition]|OtherEffs].

extract_positive_effects([E|Es],Condition,PEffects) :-
	is_not_term(E),
	extract_positive_effects(Es,Condition,PEffects).

extract_positive_effects([],_,[]).


% get_negative_effects(PDDLEffect,Negative)

get_negative_effects(PDDLEffect,Condition,Negative) :-
	PDDLEffect=[X|_],
	X\=and,
	extract_negative_effects([PDDLEffect],Condition,Negative).

get_negative_effects(PDDLEffect,Condition,Negative) :-
	PDDLEffect=[and|EffectList],
	extract_negative_effects(EffectList,Condition,Negative).

extract_negative_effects([[when,Cond,Eff]|Es],Condition,PEffects) :-
	pddl_fla_to_prolog(Cond,PCond),
	get_negative_effects(Eff,PCond,CondEffs),
	extract_negative_effects(Es,Condition,OtherEffs),
	append(CondEffs,OtherEffs,PEffects).

extract_negative_effects([E|Es],Condition,PEffects) :-
	is_not_term(E),
	\+is_when_term(E),
	pddl_fla_to_prolog(E,PE2),
	PE2=not(PE),
	extract_negative_effects(Es,Condition,OtherEffs),
	PEffects=[[PE,Condition]|OtherEffs].

extract_negative_effects([E|Es],Condition,PEffects) :-
	\+ is_not_term(E),
	extract_negative_effects(Es,Condition,PEffects).

extract_negative_effects([],_,[]).


%%% Constraints Declaration

constraints_declaration(Constraints) :-
	pddl_problem(PDDLProblem),
	member([':constraints',PDDLConstr],PDDLProblem),!,
	(PDDLConstr=[and|PDDLConstraints]; PDDLConstraints=[PDDLConstr]),
	constraints_declaration(PDDLConstraints,[],Constraints).

constraints_declaration(_) :-
	writef("No constraints have been declared.\n").

constraints_declaration([],X,X) :-
	writef("Constraints=%q\n",[X]).

constraints_declaration([PC|PCs],Cs,Constraints) :-
	extract_constraint(PC,C),
	constraints_declaration(PCs,[C|Cs],Constraints).

extract_constraint(PDDLCond,PrologCond) :-
	(PDDLCond=[preference,PrefName,PDDLFormula] ->
	    Predicate=[preference,PrefName,PCond];
	    (PDDLCond=[PDDLFormula] ->
		Predicate=[hard_constraint,PCond];     % we do not support quantified preferences yet
		Predicate=[hard_constraint,unsupported_constraint] % unsupported preference in source file
	    )
	),
	pddl_fla_to_prolog(PDDLFormula,PCond),
	PrologCond=..Predicate.


%% metric declaration

metric_declaration([Metric]) :-
	pddl_problem(PDDLProblem),
	member([':metric',Directive,PDDLMetric],PDDLProblem),!,
	Metric=metric(Directive,PrologMetric),
	pddl_fla_to_prolog(PDDLMetric,PrologMetric).

metric_declaration(_) :-
	writef("No metric declaration").
	


%%% Convert a PDDL formula into prolog format (no quantifiers yet)

pddl_binary_op(and).
pddl_binary_op(or).

pddl_fla_to_prolog(X,X) :- atom(X).

pddl_fla_to_prolog([forall,TypedArgList,PDDLFormula],forall(TypedArgList,Formula)) :- !,
	pddl_fla_to_prolog(PDDLFormula,Formula).

pddl_fla_to_prolog([Z|PDDLArgs],Term) :- 
	pddl_binary_op(Z),
	pddl_fla_to_prolog_list(PDDLArgs,Args),
	binarize(Z,Args,Term).

pddl_fla_to_prolog([Z|PDDLArgs],Term) :- 
	atom(Z),
	\+ pddl_binary_op(Z),
	pddl_fla_to_prolog_list(PDDLArgs,Args),
	Term=..[Z|Args].

pddl_fla_to_prolog_list([],[]).
pddl_fla_to_prolog_list([X|L],[Xp|Lp]) :-
	pddl_fla_to_prolog(X,Xp),
	pddl_fla_to_prolog_list(L,Lp).


%%% 

binarize(_,[],empty). % this is usually an error
binarize(_,[X],X) :- !.    % one argument, we assume just the term
binarize(Z,[X,Y],T) :- !,T=..[Z,X,Y].
binarize(Z,[X|L],T) :- !, binarize(Z,L,T2), T=..[Z,X,T2].




%%%%%% Routines for Lisp-style variable replacement

%% lisp_vars_to_prolog(+LispTerm,-PrologTerm)
%%
%% Replaces lisp variables in a prolog term by prolog variables

lisp_vars_to_prolog(LispVTerm,PrologVTerm) :-
	extract_lisp_vars(LispVTerm,LispVars),
	lisp_vars_to_prolog_aux(LispVTerm,LispVars,PrologVTerm),!.

lisp_vars_to_prolog_aux(LT,[],LT).
lisp_vars_to_prolog_aux(LT,[V|Vars],PT) :-
	sub(V,_,LT,LTp),
	lisp_vars_to_prolog_aux(LTp,Vars,PT).


is_lisp_var(Var) :- concat_atom(['?',_],Var).


%%%%%% extract_lisp_vars(+Term, -List)
%%
%% binds List with the list of lisp variables in Term
extract_lisp_vars(X,[X]) :-
	atom(X),
	is_lisp_var(X).

extract_lisp_vars(X,[]) :-
	atom(X),
	\+ is_lisp_var(X).

extract_lisp_vars(X,VarList) :-
	X=..TermList,
	extract_lisp_vars_list(TermList,VarList).

extract_lisp_vars_list([],[]).
extract_lisp_vars_list([X|L],VarList) :-
	extract_lisp_vars(X,VL1),
	extract_lisp_vars_list(L,VL2),
	union(VL1,VL2,VarList).


%%%%% sub(SubTerm,Var,Term,NewTerm)
%%
%% NewTerm is like Term but with occurrences of SubTerm replaced by Var 

sub(_,_,T,Tr) :- var(T), Tr = T.
sub(X,Y,T,Tr) :- \+ var(T), T = X, Tr = Y.
sub(X,Y,T,Tr) :- \+ T = X, T =..[F|Ts], sub_list(X,Y,Ts,Trs), Tr =..[F|Trs].
sub_list(_,_,[],[]).
sub_list(X,Y,[T|Ts],[Tr|Trs]) :- sub(X,Y,T,Tr), sub_list(X,Y,Ts,Trs).


:- dynamic 
       problem_name/1,domain_name/1,
   is_subtype/2,fluent/1,action/1,poss/2,causes_true/3,causes_false/3,
   constant/1,of_type/2,initially_true/1,action_args/2,fluent_args/2,goal/1.	

clean_up_dynamic :-
	retractall(is_subtype(_,_)),
	retractall(fluent(_)),
	retractall(action(_)),
	retractall(action_args(_,_)),
	retractall(fluent_args(_,_)),
	retractall(poss(_,_)),
	retractall(causes_true(_,_,_)),
	retractall(causes_false(_,_,_)),
	retractall(constant(_)),
	retractall(of_type(_,_)),
	retractall(initially_true(_)),
	retractall(goal(_)).
	

assert_domain_name :-
    pddl_domain(PDDL),
    member(['domain',N],PDDL),!,
    assert(domain_name(N)).
assert_domain_name :- 
    assert(domain_name(default_domain_name)).

assert_problem_name :-
    pddl_problem(PDDL),
    member(['problem',N],PDDL),!,
    assert(problem_name(N)).

assert_problem_name :- 
    assert(problem_name(default_problem_name)).


pddl2effax(DomainFile,ProblemFile,OutputDomain,OutputProblem) :-
	consult(DomainFile),
	consult(ProblemFile),
%	tell(OutputFile),

	% Strictly domain dependent
	types(Types),
	action_declarations(Actions),
	fluent_declarations(Fluents),
	precondition_declarations(Preconditions),
	effect_declarations(Effects),
	
	% Problem and possibly domain dependent
	constants_declaration(Constants),
	initial_state(Initial),
	goal_declaration(Goal),
	constraints_declaration(Constraints),
	metric_declaration(Metric),

	clean_up_dynamic,
	assert_domain_name,
	assert_problem_name,
	assert_list(Constants),
	assert_list(Types),
	assert_list(Actions),
	assert_list(Fluents),
	assert_list(Preconditions),
	assert_list(Effects),
	assert_list(Initial),
	assert_list(Goal),
	assert_list(Constraints),
	assert_list(Metric),

	%% Generating the Output
	tell(OutputDomain),
	listing(domain_name/1),
	listing(is_subtype/2),
	listing(fluent/1),
	listing(fluent_args),
	listing(action/1),
	listing(action_args/2),
	listing(poss/2),
	listing(causes_true/3),
	listing(causes_false/3),
	told,
	tell(OutputProblem),
	listing(problem_name/1),
	listing(initially_true/1),
	listing(constant/1), 
	listing(of_type/2),
	listing(goal/1),
	listing(preference/2),
	listing(hard_constraint/1),
	listing(metric/2),
	told.


%	fluent_declarations,
%	action_declarations,
%	action_parameter_types,
%	preconditions,
%	effects,
%	goal,
	
%% 	writeq(Types),nl,
%% 	writeq(Actions),nl,
%% 	writeq(Fluents),nl,
%% 	writeq(Preconditions),nl,
%% 	writeq(Effects).
%	told.


assert_list([]).
assert_list([Clause|L]) :-
	assertz(Clause),
	assert_list(L).

retract_list([]).
retract_list([Clause|L]) :-
	assertz(Clause),
	assert_list(L).
