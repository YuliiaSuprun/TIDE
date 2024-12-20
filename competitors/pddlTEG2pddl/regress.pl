:- consult(verbosity).
:- dynamic autfluent_additional_name/1.


%% Domain wipe-out

clean_domain :-
    	retractall(problem_name(_)),
	retractall(domain_name(_)),
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

%% Regression Functions

causes_true_real(Fluent,Action,Condition) :-
	causes_true(Fluent,Action,Condition),!.
causes_true_real(_,_,false).

causes_false_real(Fluent,Action,Condition) :-
	causes_false(Fluent,Action,Condition),!.
causes_false_real(_,_,false).


assign_and_simplify2(C,[],FC) :-
	simplify2(C,FC).

assign_and_simplify2(Condition,[A|Ass],FinalCond) :-
	(A=not(F) ->
	    sub(F,false,Condition,NewCond);
	    sub(A,true,Condition,NewCond)
        ),
        assign_and_simplify2(NewCond,Ass,FinalCond).

assign_and_simplify(C,[],FC) :-
	simplify(C,FC).

assign_and_simplify(Condition,[A|Ass],FinalCond) :-
	(A=not(F) ->
	    sub(F,false,Condition,NewCond);
	    sub(A,true,Condition,NewCond)
        ),
        assign_and_simplify(NewCond,Ass,FinalCond).

regress_under_assumption(Formula,Action,TrueCond,FalseCond,Ass) :-
	regress(Formula,Action,TC,FC),
	(Ass \= [] ->
	    assign_and_simplify(TC,Ass,TC1),
	    assign_and_simplify(FC,Ass,FC1);
	    TC=TC1,
	    FC=FC1
	),
	type_simplification(Action,TC1,TrueCond),
	type_simplification(Action,FC1,FalseCond).

type_simplification(Action,C,SC) :-
	Action=..[ActionName|Args],
	(implicit_action_args(ActionName,Types) ->  % prefer implicit_action_args for untyped domains
	    type_simplify_args(Args,Types,C,SC);
	    (action_args(ActionName,Types) ->
		type_simplify_args(Args,Types,C,SC);
		C=SC % no type definition for this action, leave unsimplified
            )
	).

type_simplify_args([],[],C,NC) :-
	simplify(C,NC).
type_simplify_args([Arg|As],[Type|Ts],C,SC) :-
	( (nonvar_subterm(T,C),T=..[equal,Var,Constant],Arg==Var,\+type(Constant,Type)) ->
	    sub(equal(Arg,Constant),false,C,NC),
	    type_simplify_args(As,Ts,NC,SC);
	    type_simplify_args(As,Ts,C,SC)
	).
		
type_simplify_args_fix(Action,C,NC) :-
	type_simplify_args(Action,C,Cp),
	(C=Cp ->
	    Cp=NC;
	    type_simplify_args_fix(Action,Cp,NC)
	).

type_any(Constant,[T|Ts]) :-
	type(Constant,T);type_any(Constant,Ts).

type(Constant,R) :- R=..[either|TypeList],!,
	type_any(Constant,TypeList).

type(Constant,Type) :- of_type(Constant,Type); implicit_of_type(Constant,Type).
type(Constant,Type) :- (of_type(Constant,T); implicit_of_type(Constant,T)),subtype(T,Type).

subtype(Sub,Super) :- is_subtype(Sub,Super);implicit_is_subtype(Sub,Super).
subtype(Sub,Super) :- (is_subtype(Sub,T);implicit_is_subtype(Sub,T)),subtype(T,Super).


nonvar_subterm(X,X) :- \+var(X).
nonvar_subterm(Z,X) :- \+var(X), X=..[_|ArgList],member(T,ArgList),nonvar_subterm(Z,T).
	

regress(true,_,true,false) :- !.

regress(not(F),A,TrueCond,FalseCond) :- !,
	regress(F,A,TC,FC),
	simplify(FC,TrueCond),
	simplify(TC,FalseCond).

regress(and(F,G),A,TrueCond,FalseCond) :- !,
	regress(F,A,Ftrue,Ffalse),
	regress(G,A,Gtrue,Gfalse),
	TC = or(and(Ftrue,Gtrue),
		or(and(F,and(not(Ffalse),Gtrue)),
		   and(G,and(not(Gfalse),Ftrue)))),
	FC = or(Ffalse,Gfalse),
	simplify(FC,FalseCond),
	simplify(TC,TrueCond).

regress(or(F,G),A,TrueCond,FalseCond) :- !,
	regress(not(and(not(F),not(G))),A,TrueCond,FalseCond).

regress(F,A,TrueCond,FalseCond) :-
	copy_term(A,Act),
	copy_term(A,Actp),
	causes_true_real(F,Act,TC),
	causes_false_real(F,Actp,FC),
	get_bindings(A,Act,TBind),
	get_bindings(A,Actp,FBind),
	to_and(TBind,TAnt),
	to_and(FBind,FAnt),
	TrueCondNS = and(TAnt,TC),
	FalseCondNS = and(FAnt,FC),
	simplify(TrueCondNS,TrueCond),
	simplify(FalseCondNS,FalseCond).

get_bindings(X,Y,Bin) :-
	X=..[Func|VArgs],
	Y=..[Func|IArgs],
	get_bindings_aux(VArgs,IArgs,Bin).

get_bindings_aux([],[],[]).
get_bindings_aux([V|Vs],[I|Is],[equal(V,I)|Bs]) :-
	nonvar(I),!,
	get_bindings_aux(Vs,Is,Bs).

get_bindings_aux([X|Vs],[X|Is],Bs) :-
	get_bindings_aux(Vs,Is,Bs).



simp(all(X,F),all(X,Fp)) :- simp(F,Fp).
simp(exists(X,F),exists(X,Fp)) :- simp(F,Fp).
simp(not(false),true) :- !.
simp(not(true),false) :- !.
simp(not(not(X)),Xp) :- !, simp(X,Xp).
simp(not(Z),not(Zp)) :- !, simp(Z,Zp).
simp(and(false,_),false) :- !.
simp(and(_,false),false) :- !.
%simp(and(equal(X,B),equal(Y,C)),false) :- X==Y, B\==C,!.

simp(and(T1,T2),false) :- conjunct(equal(X,B),T1), conjunct(equal(Y,A),T2),
	X==Y,\+ A==B,!.

simp(and(T1,T2),false) :- conjunct(equal(X,B),T1), conjunct(equal(Y,A),T2),
	X==Y,\+ A==B,!.

simp(and(T1,T2),and(T1,T2p)) :- 
	conjunct(A,T1),A\=true,A\=false,
	assign_and_simplify2(T2,[A],T2p),
	T2\=T2p,!. % just a trick to make it fail if no changes are made so following rules can be used.
 
simp(and(T1,T2),and(T1p,T2)) :- 
	conjunct(A,T2),A\=true,A\=false,
	assign_and_simplify2(T1,[A],T1p),
	T1\=T1p,!. % just a trick to make it fail if no changes are made so following rules can be used.


simp(and(T1,T2),and(T1,T2p)) :- 
	conjunct(A,T1),
	A=..[equal,Var,Constant],
	nonvar_subterm(Term,T2),Term=..[equal,Var2,Constant2],
        Var==Var2,Constant2\=Constant,
	Ass=[not(equal(Var2,Constant2))],		
	assign_and_simplify2(T2,Ass,T2p),
	T2\=T2p,!. % just a trick to make it fail if no changes are made so following rules can be used.

simp(and(T1,T2),and(T1p,T2)) :- 
	conjunct(A,T2),
	A=..[equal,Var,Constant],
	nonvar_subterm(Term,T1),Term=..[equal,Var2,Constant2],
        Var==Var2,Constant2\=Constant,
	Ass=[not(equal(Var2,Constant2))],
%	writef("Ass=%q\n",[Ass]),
	assign_and_simplify2(T1,Ass,T1p),
	T1\=T1p,!. % just a trick to make it fail if no changes are made so following rules can be used.

simp(or(X,Y),New) :- 
	conjunct(A,X),conjunct(B,Y), A==B,
	assign_and_simplify2(X,[A],Xp),assign_and_simplify2(Y,[A],Yp), (X\==Xp;Y\==Yp),
	simp(and(A,or(Xp,Yp)),New),!.


simp(equal(A,B),true) :- A==B,!.
simp(equal(A,B),false) :- nonvar(A),nonvar(B),A\==B,!.
simp(and(X,X),X) :- !.
simp(and(true,X),Xp) :- !,simp(X,Xp).
simp(and(X,true),Xp) :- !,simp(X,Xp).
simp(and(X,not(Y)),false) :- X==Y,!.
simp(and(not(X),Y),false) :- X==Y,!.
simp(and(X,Y),and(Xp,Yp)) :- !,simp(X,Xp),simp(Y,Yp).

simp(or(true,_),true):-!.
simp(or(_,true),true):-!.
simp(or(X,X),X) :- !.
simp(or(false,X),Xp) :- !,simp(X,Xp).
simp(or(X,false),Xp) :- !,simp(X,Xp).
simp(or(X,Y),or(Xp,Yp)) :- !,simp(X,Xp),simp(Y,Yp).

simp(X,X).




resolution_simp(X,Xp) :- complex_conjunct(C1,X),complex_conjunct(C2,X),C1=..[or|_],C2=..[or|_],C1\==C2,
	disjunct(D1,C1),disjunct(D2,C2),( (D1==not(D2),Simplest=D2); (not(D1)==D2,Simplest=D1)),
	assign_and_simplify2(X,[Simplest],X1),
	assign_and_simplify2(X,[not(Simplest)],X2),
	simplify2(and(or(X1,X2),X),Xp),
	!.

resolution_simp(and(X,Y),and(Xp,Yp)) :-
	resolution_simp(X,Xp),
	resolution_simp(Y,Yp),!.

resolution_simp(or(X,Y),or(Xp,Yp)) :-
	resolution_simp(X,Xp),
	resolution_simp(Y,Yp),!.

resolution_simp(not(X),not(Xp)) :-
	resolution_simp(X,Xp),!.

resolution_simp(X,X).


simplify(X,Xp) :-
	to_nnf(X,X1),
	resolution_simp(X1,X2),
	simplify2(X2,Xp).

simplify2(X,Xp) :-
	simp(X,Xs),
	(X = Xs ->
	    Xp=Xs;
	    simplify2(Xs,Xp)
	).

super_simplify(false,false):-!.
super_simplify(true,true):-!.
super_simplify(F,FS) :-
	writef("I've been called with %q\n",[F]),
	dnfequiv(F,DF),
	fla2list(DF,DFl),
	simp_dnf(DFl,DFlS),
	list2fla(DFlS,FS).

super_simplify(F,_) :-
	writef("I am failing for %q!!\n",[F]),
	fail.

%%%%%%%%%
% get_subformulae(Formula,UnInstFormula,SubForumlaList,VariableList)
%
% unifies SubFormulaList with the list of the biggest
% temporal subformulas in Formula
% In turn, UnInstGoal stores Formula but with those subformulae
% replaced by (new)variables. Finally those (new) variables are stored
% in VariableList

get_subformulae(and(X,Y),and(Xp,Yp),SL,VL) :- !,
	get_subformulae(X,Xp,SL1,VL1),
	get_subformulae(Y,Yp,SL2,VL2),
	append(SL1,SL2,SL),
	append(VL1,VL2,VL).

get_subformulae(or(X,Y),or(Xp,Yp),SL,VL) :- !,
	get_subformulae(X,Xp,SL1,VL1),
	get_subformulae(Y,Yp,SL2,VL2),
	append(SL1,SL2,SL),
	append(VL1,VL2,VL).

get_subformulae(not(X),not(Xp),SL,VL) :- !,
	get_subformulae(X,Xp,SL,VL).


get_subformulae(X,Y,[X],[Y]). % X is a temporal formula



% genaut_list(ListFla,ListAut)
%
% Unifies ListAut with a list of automata, one for each formula in ListFla

genaut_list([],[],[],[],X,X).

genaut_list([F|Fs],[_|Vs],[_|Qs],[no_automaton(Goal)|As],NS,NStates) :-
	F=final(Goal),   % goal is of the form final(_).. then don't produce an automaton
	genaut_list(Fs,Vs,Qs,As,NS,NStates).

genaut_list([F|Fs],[V|Vs],[Q|Qs],[A|As],NS,NStates) :-
	F\=final(_),
	quantifier_prefix(F,Q,V,FnoQ),
	genaut(FnoQ,A),
	length(A,N),
	NSp is NS+N,
	genaut_list(Fs,Vs,Qs,As,NSp,NStates).


%%
%%compute_new_domain_preferences(Preferences) %% like compute_new_domain but does not generate a new goal

compute_new_domain_preferences([],_).
compute_new_domain_preferences([[Name,PrefFormula]|Prefs],Type) :-
	retractall(autfluent_additional_name(_)),
	assert(autfluent_additional_name(Name)),
	compute_new_domain_preference(PrefFormula,Type),
	compute_new_domain_preferences(Prefs,Type).


%% compute_new_domain_preference(Pref,Type) an ugly almost-copy-paste of compute_new_domain

compute_new_domain_preference(Goal,Type) :-
	extract_types_from_untyped,
	to_ltl(Goal,LTLGoal),
	writef("LTLGoal=%q\n",[LTLGoal]),
	to_nnf(LTLGoal,NGoal),
	simplify_nnf(NGoal,NGoalS),
	breakup(NGoalS,NGoal1),
%	nl,write('NGoal1='), write(NGoal1),nl,nl,
	%NGoal1 = NGoalS, % omitting breakup!
	get_subformulae(NGoal1,UnInstGoal,SubGoalList,VarList),
	genaut_list(SubGoalList,QuantifierVars,QuantifierPrefix,AutList,0,TotalStates),
	writef('Total No. of states = %q\n',[TotalStates]),
%	findall(Fact,initially_true(Fact),InitState), % we add original initial facts
%	add_new_initial(InitState),                   % add new initial facts
				% leave preconditions intact
%	get_neg_sink_predicates(AutList,1,SinkPreds),
%	(SinkPreds\=[]-> 
%	    to_and(SinkPreds,ExtraPrecond),
%	    forall(poss(Action, Cond), myassertz(new_poss(Action,and(ExtraPrecond,Cond))));
 %	    forall(poss(Action, Cond), myassertz(new_poss(Action,Cond)))
%	),
%	writef("calling compute_new_domain(%q,%q,%q,%q).\n",[QuantifierVars,AutList,Type,1]),
	compute_new_domain(QuantifierVars,AutList,Type,1),
%	writef("\n\n CALLING FINAL GOAL WITH:\n %w",[[QuantifierVars,QuantifierPrefix,AutList,UnInstGoal,VarList,1,Type]]),
	add_final_goal(QuantifierVars,QuantifierPrefix,AutList,UnInstGoal,VarList,1,Type,preference). 



%% compute_new_domain(Goal)
%
% given a temporal goal formula, computes a new domain

compute_new_domain(Goal,Type) :-
	extract_types_from_untyped,
	to_ltl(Goal,LTLGoal),
	writef("LTLGoal=%q\n",[LTLGoal]),
	to_nnf(LTLGoal,NGoal),
	simplify_nnf(NGoal,NGoalS),
	breakup(NGoalS,NGoal1),
%	nl,write('NGoal1='), write(NGoal1),nl,nl,
	%NGoal1 = NGoalS, % omitting breakup!
	get_subformulae(NGoal1,UnInstGoal,SubGoalList,VarList),
	genaut_list(SubGoalList,QuantifierVars,QuantifierPrefix,AutList,0,TotalStates),
	writef('Total No. of states = %q\n',[TotalStates]),
	findall(Fact,initially_true(Fact),InitState), % we add original initial facts
	add_new_initial(InitState),                   % add new initial facts
				% leave preconditions intact
	get_neg_sink_predicates(AutList,1,SinkPreds),
	(SinkPreds\=[]-> 
	    to_and(SinkPreds,ExtraPrecond),
	    forall(poss(Action, Cond), myassertz(new_poss(Action,and(ExtraPrecond,Cond))));
 	    forall(poss(Action, Cond), myassertz(new_poss(Action,Cond)))
	),
%	writef("calling compute_new_domain(%q,%q,%q,%q).\n",[QuantifierVars,AutList,Type,1]),
	compute_new_domain(QuantifierVars,AutList,Type,1),
%	writef("\n\n CALLING FINAL GOAL WITH:\n %w",[[QuantifierVars,QuantifierPrefix,AutList,UnInstGoal,VarList,1,Type]]),
	add_final_goal(QuantifierVars,QuantifierPrefix,AutList,UnInstGoal,VarList,1,Type,goal). 

compute_new_domain([],[],_,_).
compute_new_domain([_|Quants],[no_automaton(_)|List],Type,AutNumber) :-
	compute_new_domain(Quants,List,Type,AutNumber).
compute_new_domain([Quant|Quants],[Aut|List],Type,AutNumber) :-
%	writef('Automaton %q',[AutNumber]),
	Aut\=no_automaton(_),
%	(is_verbose ->
%	    showaut(Aut);
%	    true				%
%	),  
	writef('Generating new fluents...\n'),
	aut2newfluents(Quant,Aut,AutNumber,Type),
	writef('New Initial State...\n'),
	aut2initial(Quant,Aut,AutNumber,Type), % New ground facts initially true
	writef('New Effect Axioms...\n'),
	aut2eff(Quant,Aut,AutNumber,Type),    % Generation of new effect axioms
%	writef('New Preconditions...\n'),
%	aut2prec(Aut,AutNumber),    % Generation of new preconditions
	AutNumberp is AutNumber+1,
	compute_new_domain(Quants,List,Type,AutNumberp).

get_neg_sink_predicates([],_,[]).
get_neg_sink_predicates([Aut|AutList],AutNumber,SinkStates) :-
	(member([sink|_],Aut) ->
	    id2fluent(sink,AutNumber,SinkPredicate),
	    SinkStates=[not(SinkPredicate)|NextSink];
	    SinkStates=NextSink
	),
	AutNumberp is AutNumber+1,
	get_neg_sink_predicates(AutList,AutNumberp,NextSink).

aut2newfluents(Quant,Aut,AutNumber,Type) :-
	make_variable_list(Quant,VList),
	forall((member([Id,_,_,_|_],Aut),id2fluentvar(Id,AutNumber,VList,Fluent)),myassertz(new_fluent(Fluent))),
	(Type=dp -> %aditional prev_autstate predicates are declared
	    forall((member([Id|_],Aut),
		    id2prevfluentvar(Id,AutNumber,VList,Fluent)),
		   myassertz(new_fluent(Fluent)));
	    true
	).

add_final_goal([],[],[],Goal,[],_,_,Mode) :- 
	recursive_variable_subst(Goal,Goalp),
	(Mode=goal ->
	    myassertz(new_goal(Goalp));
	    autfluent_additional_name(Name),    % but here we should alter the metric function somehow
	    myassertz(new_preference(Name,Goalp))
	).

add_final_goal([QVar|QVList],[Quant|QList],[Aut|AList],UnInstGoal,[Var|VList],N,Type,Mode) :-
	aut2goal(QVar,Quant,Aut,N,Var,Type),
	(Aut\=no_automaton(_) ->
	    N1 is N+1;
	    N1 is N
	),
	add_final_goal(QVList,QList,AList,UnInstGoal,VList,N1,Type,Mode).

aut2goal(_,_,no_automaton(GoalFla),_,GoalFla,_).

aut2goal(VList,Quant,Aut,AutNumber,GoalFla,dp) :-
	Aut\=no_automaton(_),
	findall(Fluent,(member([Id,1,_,_|_],Aut),
			id2fluentvar(Id,AutNumber,VList,Fluent)),GFs),
	to_or(GFs,GFs2),
	(autfluent_additional_name(Name) ->
	    concat_atom([aut_in_final_,Name,'_',AutNumber],AF1);
	    concat_atom([aut_in_final_,AutNumber],AF1)
	),
	AF2 =.. [AF1|VList],
	make_variable_list(VList,RealVars),
	variable_subst(AF2,VList,RealVars,AutFinal),
	variable_subst(GFs2,VList,RealVars,GFs3),
	myassertz(derived(AutFinal,GFs3)),myassertz(new_fluent(AutFinal)),    %% this line adds a derived predicate! replace by AF2=GFs2 leave as before
	add_quantifier_prefix(AF2,Quant,GoalFla).



aut2goal(VList,Quant,Aut,AutNumber,GoalFla,cr) :-
	Aut\=no_automaton(_),
	findall(Fluent,(member([Id,1,_,_|_],Aut),
			id2fluentvar(Id,AutNumber,VList,Fluent)),GFs),
	to_or(GFs,GFs2),
	(autfluent_additional_name(Name) ->
	    concat_atom([aut_in_final_,Name,'_',AutNumber],_AF1);
	    concat_atom([aut_in_final_,AutNumber],_AF1)
	),
%	AF2 =.. [AF1|VList],
	make_variable_list(VList,RealVars),
%	variable_subst(AF2,VList,RealVars,AutFinal),
	variable_subst(GFs2,VList,RealVars,GFs3),
%	myassertz(derived(AutFinal,GFs3)),myassertz(new_fluent(AutFinal)),    %% this line adds a derived predicate! replace by AF2=GFs2 leave as before
	add_quantifier_prefix(GFs3,Quant,GoalFla).



aut2eff(Quant,Aut,AutNumber,Type) :- 
	findall([Id,PredList],
		(
		  member([Id|_],Aut),
		  findall([State,Label,Assumption],
			  (
			    member([State,_,_,AdjList|Tail],Aut),
			    (Tail=[ZZ|_] ->
				Assumption=ZZ;
				Assumption=[]
			    ),
			    member([Id,Label],AdjList)
			  ),
			  PredList)
		),
	       StatePred),
	dwritef("\n\nCalling new_effects (%q)\n\n",[StatePred]),
	new_effects(Quant,StatePred,AutNumber,Type).


aut2prec(Aut,AutNumber) :-
	forall(action(Action),
	       (
		 findall(Cond,(member([Id,_,_,_|_],Aut),
			       id2fluent(Id,AutNumber,Fluent),
			       causes_false(Fluent,Action,CondOut),
			       Cond=or(not(Fluent),CondOut)
			      ),Conditions),
		 to_and(Conditions,ExtraCond),
%		 writef("WAS HERE EXTRA COND=%q",[ExtraCond]),
		 (poss(Action, Cond) ->	% assuming action is always possible if no precondition is declared
		     true;
		     Cond=true
		 ),
		 simplify(and(Cond,ExtraCond),_SimpCond),
%		 myassertz(new_poss(Action,SimpCond))
		 myassertz(new_poss(Action,Cond))	       
	       )).


	
aut2initial(_,Aut,AutNumber,cr) :- %Quant parameter not implemented here
	findall(Fluent,(member([_,_,1,AdjList|_],Aut),
			member([Node,Label],AdjList),
			all_true(Label),
			id2fluent(Node,AutNumber,Fluent)),TrueInit),
	list_to_set(TrueInit,TrueInitSet),
	add_new_initial(TrueInitSet).


aut2initial(Quant,Aut,AutNumber,dp) :-   %% prevautstate fluents are added to the initial state
	length(Quant,N),
	findall(Fluent,(
			member([Node,_,1,_|_],Aut),
			id2prevfluent(Node,AutNumber,F),
			constant_vector(N,V),
			Fluent=..[F|V]
		       ),TrueInit),
	add_new_initial(TrueInit).


constant_vector(0,[]).
constant_vector(N,[C|Cp]) :- N>0,
	constant(C),
	Np is N-1,
	constant_vector(Np,Cp).


all_true([]).

all_true([not(F)|R]) :-
	\+ initially_true(F),
	all_true(R).

all_true([F|R]) :-
	initially_true(F),
	all_true(R).


add_new_initial([]).
add_new_initial([Fact|R]) :-
	myassertz(new_initially_true(Fact)),
	add_new_initial(R).
	
	




	       

myassertz(X) :-
	dwritef("to assert: %q\n",[X]),
	assertz(X).

clear_aut_eff :-
	string_to_atom(Prefix,autstate_),
	findall(_,
		(
		  causes_true(F,_,_),
		  F=..[Predname|_],
		  string_to_atom(Str,Predname),
		  string_concat(Prefix,_,Str),
		  retractall(causes_true(F,_,_))
		),_),
	findall(_,
		(
		  causes_false(F,_,_),
		  F=..[Predname|_],
		  string_to_atom(Str,Predname),
		  string_concat(Prefix,_,Str),
		  retract(causes_false(F,_,_))
		),_).
	

add_positive_eff(Fluent,Action,Cond) :-
	(Cond\=false ->
	    simplify(Cond,SCond),
%	    Cond=SCond,
	    myassertz(causes_true(Fluent,Action,SCond))
	;
	    true).

add_virtual_positive_eff(Fluent,Action,Cond) :-
	    simplify(Cond,SCond),
	    myassertz(virtual_causes_true(Fluent,Action,SCond)).

add_negative_eff(Fluent,Action,Cond) :-
	(Cond\=false ->
	    simplify(Cond,SCond),
%	    SCond=Cond,
	    myassertz(causes_false(Fluent,Action,SCond))
	;
	    true).


new_effects(_,[],_,_).
new_effects(_,[[Id,PredList]|Rest],AutNumber,cr) :- % not implemented for Quant

	% for the causal rules version we add causal rules
	% for the autstate predicates
	
	id2fluent(Id,AutNumber,ThisFluent),
	
	                    
				% we add positive effects
	
	findall([Action,TrueCond],
		(
		  action(Action),
		  my_find(Action,[TrueC,TrueCAssed],
			  (
			    member([PredId,Label,Ass],PredList),
			    PredId\=Id,
			    to_and(Label,C),
%			    writef("Action(1)=%q",[Action]),
			    regress_under_assumption(C,Action,TC,TF,Ass),
%			    writef("Action(2)=%q",[Action]),
			    id2fluent(PredId,AutNumber,IdFluent),
			    assign_and_simplify(C,Ass,SimpC),
%			    writef("Action(3) %q:\n\t",[Action]),writef(" Simplifying "),write(C),write(' over '),write(Ass),writef("="),write(SimpC),
			    simplify(and(IdFluent,or(TC,and(SimpC,not(TF))
)),TrueC),
                            to_and(Ass,AndedAss),
	                    simplify(and(and(IdFluent,AndedAss),or(TC,and(SimpC,not(TF))
)),TrueCAssed)
%			    writef("\n\tTC=%q TF=%q TC=%q ",[TC,TF,TC]),write(TC),nl
			  ),
			  DoubleTrueCondList),
		  to_or_1(DoubleTrueCondList,TrueCondBS),
		  simplify(TrueCondBS,TrueCond),
		  add_positive_eff(ThisFluent,Action,TrueCond),

		  to_or_2(DoubleTrueCondList,TrueCondAssed),
		  add_virtual_positive_eff(ThisFluent,Action,TrueCondAssed)

		), _),
				% now negative effects

		(member([Id,_,AssUninst],PredList) ->

				% there is a self transition

	    findall(SL,
		    (
		      member([Id,SLab,_],PredList),
		      to_and(SLab,SL)
		    ),SelfLabels),
			       
            instantiate_assumption(AutNumber,AssUninst,Ass),           
	    to_or(SelfLabels,FCondNS),
	    simplify(FCondNS,FCond),
	    dwritef("I'm here for state %q\nFCond=%q",[Id,FCond]),
	    findall(Action,
		    (
		      action(Action),
%		      writef("Action=%q\n\t",[Action]),
		      regress_under_assumption(FCond,Action,TC,TF,Ass),
				% Conditions under which self-transition is falsified
%		      writef("Regress %q under %q yields TC=%q TF=%q\n",[FCond,Ass,TC,TF]),
		      dwritef("TC=%q\n",[TC]),
		      causes_true_real(ThisFluent,Action,BT1),
				% Conditions under which it may become true
				% warning: previous line assumes the positive effect has been asserted!

		      virtual_causes_true(ThisFluent,Action,BecomeTrueAss),

%		      writef("calling assign_and_simplify(%q,%q,%q)\n",[BecomeTrueAss,Ass,BT2]),
		      assign_and_simplify(BecomeTrueAss,Ass,BT2),

		      
		      size_of_term(BT1,N1),
		      size_of_term(BT2,N2),
		      
		      (N1<N2 ->
			  BT3=BT1
			  ;
			  BT3=BT2
		      ),

%		      writef("BT1=%q\nBT2=%q\n",[BT1,BT2]),
%		      writef("BecomeTrue=%q\n",[BT3]),
		      
%		      writef("calling assign_and_simplify(%q,%q,%q)\n",[TC,Ass,NewTC]),
		      assign_and_simplify(TC,Ass,NewTC),
%		      writef("calling assign_and_simplify(%q,%q,%q)\n",[FCond,Ass,NewFCond]),
		      assign_and_simplify(FCond,Ass,NewFCond),
		      
%		      writef("about to simplify %q\n", %
%		  [and(and(not(BT3),and(not(NewTC),or(not(NewFCond),TF))),ThisFluent)]),
		      simplify(and(and(not(BT3),
				   and(not(NewTC),
				       or(not(NewFCond),TF))),ThisFluent),ActualCond),
%		      writef("ActualCond=%q\n",[ActualCond]),
  
		      add_negative_eff(ThisFluent,Action,ActualCond)
		    ), _)

	    ;
				% there is no self-transition
	    findall(Action,
		    (
		      action(Action),
		      causes_true_real(ThisFluent,Action,BT1),
				% Conditions under which it may become true
				% warning: previous line assumes the positive effect has been asserted!

		      virtual_causes_true(ThisFluent,Action,BecomeTrueAss),

		      Ass=[],
		      assign_and_simplify(BecomeTrueAss,Ass,BT2),

		      
		      size_of_term(BT1,N1),
		      size_of_term(BT2,N2),
		      
		      (N1<N2 ->
			  BT3=BT1
			  ;
			  BT3=BT2
		      ),


		      simplify(not(BT3),ActualCond),
%		      writef("ActualCond=%q\n",[ActualCond]),

		      add_negative_eff(ThisFluent,Action,ActualCond)
		    ), _)
	),
%	writef("Calling new_ffects(%q,%q,%q,%q)\n",[_,Rest,AutNumber,cr]),
	new_effects(_,Rest,AutNumber,cr).




new_effects(Quant,[[Id,PredList]|Rest],AutNumber,dp) :-
	make_variable_list(Quant,VList),
	findall(and(Fluent,Condition),
		(
		  member([PredId,PredLabel,_],PredList),
		  id2prevfluentvar(PredId,AutNumber,Quant,Fluent),
		  to_and(PredLabel,Condition)
		),DefList),
	to_or(DefList,Def),
	simplify(Def,DefS),
	recursive_variable_subst(DefS,DefSS),
	variable_subst(DefSS,Quant,VList,DefSSS),
	id2prevfluentvar(Id,AutNumber,VList,PrevFluent),
	id2fluentvar(Id,AutNumber,VList,F),
	(DefSSS \== false ->
	    myassertz(derived(F,DefSSS))	%%derived definition
	;
	    true
	),
	forall(action(A),
	       (
		 myassertz(causes_true(PrevFluent,A,F)),  %% causal rule for prev_autstate
		 myassertz(causes_false(PrevFluent,A,not(F)))
	       )),
	new_effects(Quant,Rest,AutNumber,dp).



instantiate_assumption(_,[],[]).
instantiate_assumption(AutNumber,[A|Ass],[Ap|Assp]) :-
	(A=not_in_state__(N) ->
	    id2fluent(N,AutNumber,Pred),
	    Ap=not(Pred)
	;
	    Ap=A
	),
	instantiate_assumption(AutNumber,Ass,Assp).

size_of_term(Term,N) :-
	findall(X,nonvar_subterm(X,Term),L),
	length(L,N).




to_and([],true).
to_and([X],X) :- !.
to_and([X|L],and(X,R)) :-
	to_and(L,R).

to_or([],false).
to_or([X],X) :- !.
to_or([X|L],or(X,R)) :-
	to_or(L,R).

to_or_1([],false).
to_or_1([[X,_]],X) :- !.
to_or_1([[X,_]|L],or(X,R)) :-
	to_or_1(L,R).


to_or_2([],false).
to_or_2([[_,X]],X) :- !.
to_or_2([[_,X]|L],or(X,R)) :-
	to_or_2(L,R).

id2fluentvar(Id,AutNumber,Var,Term) :-
	id2fluent(Id,AutNumber,T),
	Term=..[T|Var].

id2fluent(Id,AutNumber,Term) :-
	(autfluent_additional_name(AddName)->
	    concat_atom([autstate,AddName,AutNumber,Id],'_',Term);
	    concat_atom([autstate,AutNumber,Id],'_',Term)
	).


id2prevfluentvar(Id,AutNumber,Var,Term) :-
	id2prevfluent(Id,AutNumber,T),
	Term=..[T|Var].

id2prevfluent(Id,AutNumber,Term) :-
	(autfluent_additional_name(AddName)->
	    concat_atom([prev_autstate,AddName,AutNumber,Id],'_',Term);
	    concat_atom([prev_autstate,AutNumber,Id],'_',Term)
	).
%	concat_atom([prev_autstate_,AutNumber,'_',Id],Term).


:- dynamic my_find_list/1.

my_find(Functor,X,C,L) :-
	retractall(my_find_list(_)),
	assert(my_find_list([[],Functor])),
	\+ my_find_aux(Functor,X,C),
	!,
	my_find_list([L,Functor]),
	retractall(my_find_list(_)).

my_find_aux(Functor,X,C) :-
	call(C),
	my_find_list([L,Functor]),
	retractall(my_find_list(_)),
	asserta(my_find_list([[X|L],Functor])),
	fail.






%% simp_dnf(Fla,Fla2) true iff Fla2 is obtained by simplifying Fla

simp_dnf(Fla,SFla) :-
	simp_dnf1(Fla,Flap),
	simp_dnf2(Flap,Flap,SFla).

simp_dnf1([],[]).
simp_dnf1([Term|Terms],Fla2) :-
	false_term(Term),!,
	simp_dnf1(Terms,Fla2).

simp_dnf1([T|Ts],L) :-
	simp_nots(T,T1),
	etoset(T1,T2),
	eremove(true,T2,T3),
	simp_term_eq(T3,U),
	(U\=[] ->
	    L=[U|Us]
	;
	    L=Us
	),
	simp_dnf1(Ts,Us).

simp_dnf2([],_,[]).
simp_dnf2([T|Ts],Fla,Us) :-
	member(Term,Fla),
	Term \== T,
	esubset(Term,T),!,
	simp_dnf2(Ts,Fla,Us).

simp_dnf2([T|Ts],Fla,[T|Us]) :-
	simp_dnf2(Ts,Fla,Us).


doublenot(not(not(X)),Y):-!,
	doublenot(X,Y).
doublenot(X,X).

simp_nots([],[]).

simp_nots([X|Xs],[Y|Ys]) :-
	doublenot(X,Xp),
	(Xp=not(true) ->
	    Y = false
	;
	    (Xp = not(false) ->
		Y = true
	    ;
		Xp = Y
	    )
	),
	simp_nots(Xs,Ys).

%% false_term(Term) true if Term is trivially false

false_term(Term) :-
	member(false,Term).

false_term(Term) :-
	member(Lit1,Term),
	emember(not(Lit1),Term).

false_term(Term) :-
	member(equal(X,Y),Term),
	nonvar(X),nonvar(Y),X\==Y.

false_term(Term) :-
	member(equal(X,Y),Term),
	member(equal(W,Z),Term),
	var(X),var(W),X==W,
	Y\==Z.

false_term(Term) :-
	member(equal(X,Y),Term),
	nonvar(X),nonvar(Y),X\==Y.

%% sim_term_eq(T1,T2) true if T2 is a simplified version of T1
%% the simplification is based on equality identities

simp_term_eq([],[]).

simp_term_eq([equal(X,Y)|L],Lp) :-
	nonvar(X),nonvar(Y),X==Y,!,
	simp_term_eq(L,Lp).

simp_term_eq([equal(X,Y)|L],[equal(X,Y)|Lp]) :-
	var(X),nonvar(Y),
	member(not(equal(W,Z)),L),
	var(W),W==X,
	nonvar(Z), Y\==Z,
	eremove(not(equal(W,Z)),L,Ls),!,
	simp_term_eq(Ls,Lp).

simp_term_eq([not(equal(X,Y))|L],Lp) :-
	var(X),nonvar(Y),
	member(equal(W,Z),L),
	var(W),W==X,
	nonvar(Z), Y\==Z,!,
	simp_term_eq(L,Lp).

simp_term_eq([X|L],[X|Lp]) :-
	simp_term_eq(L,Lp).

eremove(_,[],[]).
eremove(X,[Y|Z],Zp) :-
	X==Y,!,eremove(X,Z,Zp).

eremove(X,[Y|Z],[Y|Zp]):- eremove(X,Z,Zp).


%% etoset(T1,T2) T2 is T1 with duplicates removed

etoset([],[]).

etoset([X|Xs],Ys) :-
	emember(X,Xs),!,
	etoset(Xs,Ys).

etoset([X|Xs],[X|Ys]) :-
	etoset(Xs,Ys).

%% esubset(S1,S2) true iff S1 is a subset of S2

esubset([],_).
esubset([X|Xs],S2) :-
	emember(X,S2),
	esubset(Xs,S2).


%% "Exact"/literal member of a list
emember(X,[Y|L]) :- X==Y; emember(X,L).
	

%%% fla2list transform a formula in dnf to list representation

fla2list(or(X,Y),List) :- !,
	fla2list(X,L1),
	fla2list(Y,L2),
	append(L1,L2,List).

fla2list(X,[L]) :- fla2list2(X,L).

fla2list2(and(X,Y),List) :- !,
	fla2list2(X,L1),
	fla2list2(Y,L2),
	append(L1,L2,List).
fla2list2(X,[X]).
	


list2fla(L,F) :-
	list2fla_aux(L,Lp),
	to_or(Lp,F).

list2fla_aux([],[]).
list2fla_aux([T|Ts],[U|Us]) :-
	to_and(T,U),
	list2fla_aux(Ts,Us).

	
% to disjunctive normal form

dnfequiv(X,Y) :-
	transform(X,Z),!,
	(X \= Z ->
	    dnfequiv(Z,Y)
	;
	    Y=Z
	).

dnfequiv(X,X).


% transform is satisfied if its second argument is derived from its
 % first by applying one of the standard transformations. Given a query
 % in which the first argument is a boolean formula and the second is a
 % variable, it will instantiate the variable to a logically equivalent
 % formula to the first argument, which is nearer to being in conjunctive
 % normal form. If the first argument is already in conjunctive normal form
 % then the goal cannot be satisfied.

transform(not(not(X)),X).  % eliminate double negation

transform(not(and(X,Y)),or(not(X),not(Y))).  % De Morgan
transform(not(or(X,Y)),and(not(X),not(Y))).  %

transform(and(X,or(Y,Z)),or(and(X,Y),and(X,Z))).   % distribution
transform(and(or(X,Y),Z),or(and(X,Z),and(Y,Z))).   %

transform(or(X1,Y),or(X2,Y)) :- transform(X1,X2).  %
transform(or(X,Y1),or(X,Y2)) :- transform(Y1,Y2).  %
                                                 % transform subterms
transform(and(X1,Y),and(X2,Y)) :- transform(X1,X2).  %
transform(and(X,Y1),and(X,Y2)) :- transform(Y1,Y2).  %
                                                 %
transform(not(X1),not(X2)) :- transform(X1,X2).      %



% variables in the quantifier prefix

quantifier_prefix(all(X,F),[all(X)|Qs],[X|Vs],FnoQ) :- !,
	quantifier_prefix(F,Qs,Vs,FnoQ).

quantifier_prefix(exists(X,F),[exists(X)|Qs],[X|Vs],FnoQ) :- !,
	quantifier_prefix(F,Qs,Vs,FnoQ).

quantifier_prefix(F,[],[],F). % it's not a quantified formula

% make_variable_list(L,V)
% constructs a list of varibles of the same length as L
make_variable_list([],[]).
make_variable_list([_|Xs],[_|Ys]) :-
	make_variable_list(Xs,Ys).


add_quantifier_prefix(Fla,[],Fla).
add_quantifier_prefix(Fla,[X|Rest],Term) :-
	add_quantifier_prefix(Fla,Rest,Termp),
	X=..List,
	append(List,[Termp],TermList),
	Term=..TermList.


% variable_subst(Term,Ground,Vars,SubstTerm)
% substitute in Term all ground terms in Ground with the
% respective variables in Vars

variable_subst(Term,Grounds,Vars,SubstTerm) :-
	compound(Term),
	Term=..TermList,
	variable_subst_list(TermList,Grounds,Vars,SubstList),
	SubstTerm=..SubstList.

variable_subst(Term,Grounds,Vars,SubstTerm) :-
	\+ compound(Term),
	( (ground(Term),nth0(N,Grounds,Term)) ->
	    nth0(N,Vars,SubstTerm) % here's where the substitution is done
	;
	    SubstTerm=Term
	).
	
variable_subst_list([T|Ts],Grounds,Vars,[S|Ss]) :-
	variable_subst(T,Grounds,Vars,S),
	variable_subst_list(Ts,Grounds,Vars,Ss).

variable_subst_list([],_,_,[]).


recursive_variable_subst(equal(X,Y),equal(X,Y)) :- !.
recursive_variable_subst(and(X,Y),and(Xp,Yp)) :- !,
	recursive_variable_subst(X,Xp),
	recursive_variable_subst(Y,Yp).

recursive_variable_subst(or(X,Y),or(Xp,Yp)) :- !,
	recursive_variable_subst(X,Xp),
	recursive_variable_subst(Y,Yp).

recursive_variable_subst(not(X),not(Xp)) :- !,
	recursive_variable_subst(X,Xp).

recursive_variable_subst(F,Fp) :-
	F=..[Quant,X,Fpp],
	(Quant=all;Quant=exists),!,
	(nonvar(X) ->
	    variable_subst(Fpp,[X],[Var],Fpp2),
	    recursive_variable_subst(Fpp2,Fpp3),
	    Fp=..[Quant,Var,Fpp3]	    
	;
	    recursive_variable_subst(Fpp,Fpp3),
	    Fp=..[Quant,X,Fpp3]  
	).

	
recursive_variable_subst(X,X). % must be a predicate



%%%%% sub(SubTerm,Var,Term,NewTerm)
%%
%% NewTerm is like Term but with occurrences of SubTerm replaced by Var 

sub(_,_,T,Tr) :- var(T), Tr = T.
sub(X,Y,T,Tr) :- \+ var(T), T == X, Tr = Y.
sub(X,Y,T,Tr) :- \+ var(T), \+ T == X, T =..[F|Ts], sub_list(X,Y,Ts,Trs), Tr =..[F|Trs].
%sub(X,Y,T,Tr) :- writef("failed with args: %q",[[X,Y,T,Tr]]),fail.
sub_list(_,_,[],[]).
sub_list(X,Y,[T|Ts],[Tr|Trs]) :- sub(X,Y,T,Tr), sub_list(X,Y,Ts,Trs).


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




extract_types_from_untyped :-
	untyped_action(_),
	compute_static_fluents,
	add_implicit_action_types,
	add_implicit_object_types,
	compute_implicit_subtypes.

extract_types_from_untyped.

compute_static_fluents :-
	forall((fluent(F),\+causes_true(F,_,_),\+causes_false(F,_,_)),assertz(static_fluent(F))).

fluent_conjunct(F,F) :- F=..[FluentName|_],
	FluentName\=and, FluentName\=not,FluentName\=or, % extra check for efficiency
	fluent(F),F=..[FluentName|_].

fluent_conjunct(F,and(X,Y)) :- fluent_conjunct(F,X);fluent_conjunct(F,Y).

untyped_action(A):- 
	action(A), 
	A=..[ActionName|_],
	\+ (action_args(ActionName,Types),member(X,Types),X\='NO_TYPE').

add_implicit_object_types :-
	forall((constant(Obj),
                static_fluent(P),
                P=..[PName,Obj],initially_true(P)),assertz(implicit_of_type(Obj,PName))).

add_implicit_action_types :-
	findall([A|Types], (untyped_action(A), A=..[_|Args], get_implicit_types(A,Args,Types)),ActionTypeList),
	forall((member([A|Args],ActionTypeList),A=..[ActionName|_]),assertz(implicit_action_args(ActionName,Args))).


get_implicit_types(_,[],[]).
get_implicit_types(A,[Arg|Args],[T|Types]) :-
	poss(A,Precondition),
	
	( (fluent_conjunct(F,Precondition),
	   static_fluent(F),F=..[T,Term],Term==Arg) ->
	    get_implicit_types(A,Args,Types);
	    T='NO_TYPE',
	    get_implicit_types(A,Args,Types)).
	


compute_implicit_subtypes :-
	findall([SubCandidate,SuperCandidate], 
	(constant(Obj),initially_true(InitialFact1),InitialFact1=..[FluentName1,Obj], Stat1=..[FluentName1,_], static_fluent(Stat1),
	initially_true(InitialFact2),InitialFact2=..[FluentName2,Obj], FluentName2\=FluentName1,Stat2=..[FluentName2,_], static_fluent(Stat2),
	FluentName1=SubCandidate,FluentName2=SuperCandidate),CandidatePairs),
	list_to_set(CandidatePairs,CandidateSet),
	verify_and_add(CandidateSet).

verify_and_add([]).
verify_and_add([[Sub,Super]|Cs]) :-
	FSub=..[Sub,Obj],FSuper=..[Super,Obj],
	( (\+ (initially_true(FSub), \+ initially_true(FSuper))) ->
	    assertz(implicit_is_subtype(Sub,Super)); true),
	verify_and_add(Cs).

conjunct(F,F) :- F=..[FluentName|_],
	FluentName\=and, FluentName\=or.

conjunct(F,and(X,Y)) :- conjunct(F,X);conjunct(F,Y).


complex_conjunct(F,F) :- F=..[FluentName|_],
	FluentName\=and.

complex_conjunct(F,and(X,Y)) :- complex_conjunct(F,X);complex_conjunct(F,Y).

disjunct(F,F) :- F=..[FluentName|_],
	FluentName\=and, FluentName\=or.

disjunct(F,or(X,Y)) :- disjunct(F,X);disjunct(F,Y).
