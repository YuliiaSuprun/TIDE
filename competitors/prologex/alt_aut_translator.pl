%Translates a Planning domain and problem with temporal goal in Prolog format to another domain and problem with propositional goal

:- dynamic action_mode/1, is_branch/1.

%Mode 1 does not force synchronization in topological order. Good for simpler formulae with few number of subformulae
%Mode 2 forces synchronization in topological order. Good for more complexr formulae with high number of subformulae
%Mode 3 is Mode 1 with another goal
%Mode 4 is Mode 2 with another goal


effax2alt(DomainFile,ProblemFile,OutputDomain,OutputProblem,OutputTrans,Mode) :-
	assertz(action_mode(Mode)),
	consult(DomainFile),
	consult(ProblemFile),
	goal(G1),
	nnf_goal(G1,G2),
	simple_goal(G2,G),
	translate_domain(G,OutputDomain),
	tell(OutputTrans),
	write_trans_subf(G),
	told,
	translate_problem(G,OutputProblem),
	statistics(cputime,H),
	statistics(inferences,Infe),
	nl, writef("Translation CPU time: %q, Number of Inferences: %q\n",[H,Infe]),nl.


%Translates domain

translate_domain(G,OutputDomain):- !,
	action_list(A), assertz(list_action_worlds(A)),
	add_special_fluents,
	get_alt_states(G),
	add_state_fluents,
	(
	(action_mode(3);action_mode(4))
	->
	add_branch_states_to_fluents(G)
	;
	true
	),
	add_actions,
	tell(OutputDomain),
	listing(is_subtype),
	listing(fluent),
	listing(fluent_args),
	listing(action),
	listing(action_args),
	listing(poss),
	listing(causes_true),
	listing(causes_false),
	told.


add_branch_states_to_fluents(F) :- !,
	get_branch_fluents(F,L1),
	sort(L1,L),
	forall(member(X,L),
	(
	assertz(fluent(X)),
	assertz(fluent_args(X,[])),
	assertz(is_branch(X))
	)	
	).


get_branch_fluents(F,L) :-
	F =.. [Z,F1,F2], member(Z,[and,or]),
	get_branch_fluents(F1,L1), 
	get_branch_fluents(F2,L2), 
	append(L1,L2,L).

get_branch_fluents(F,L) :-
	F =.. [Z,F1], member(Z,[next,always,eventually]),
	get_branch_fluents(F1,L).

get_branch_fluents(F,L) :-
	F =.. [Z,F1,F2], member(Z,[until,release]),
	get_branch_fluents(F1,L1),
	trans_sub_state(F1,Q),
	trans_state_branch(Q,QB),
	get_branch_fluents(F2,L2),
	append([QB|L1],L2,L).

get_branch_fluents(_,[]) :- !.


translate_problem(G,OutputProblem):- !,
	trans_sub_state(G,S),
	assertz(initially_true(S)),
	assertz(initially_true(f_copy)),
	assertz(initially_true(f_ok)),
	retract(goal(_)),
        (
	(action_mode(1);action_mode(2))
	->
	assertz(goal(f_goal))
	;
	write_done_goal(G,X),
%	findall(D,(is_state(Q),trans_state_done(Q,D),trans_sub_state(S1,Q),S1\=q_f,S1\=q_r),B),get_done_state_conj(B,X),
	trans_sub_state(q_r,QR),
%	write_branch(Br),
	assertz(goal(and(not(QR),X)))
%	assertz(goal(and(not(QR),and(X,Br))))	
	),
	tell(OutputProblem),
	listing(initially_true),
	listing(constant), 
	listing(of_type),
	listing(goal),
	listing(preference),
	listing(hard_constraint),
	listing(metric),
	told.

write_branch(G) :-
	findall(B,is_branch(B),Bag), !,
	write_goal_branch(Bag,G).

write_goal_branch([B|L],and(or(not(B),G),G2)) :- 
	trans_state_branch(Q,B),
	trans_sub_state(F,Q),
	write_done_goal(F,G),
	write_goal_branch(L,G2).

write_goal_branch([B],or(not(B),G)) :- !,
	trans_state_branch(Q,B),
	trans_sub_state(F,Q),
	write_done_goal(F,G).

write_done_goal(and(F1,F2),and(QD,and(G1,G2))) :- 
	trans_sub_state(and(F1,F2),Q),
	trans_state_done(Q,QD),
	write_done_goal(F1,G1),
	write_done_goal(F2,G2).	

write_done_goal(F,and(QD,or(G1,G2))) :- 
	F =.. [Z,F1,F2], member(Z,[or]),
	trans_sub_state(F,Q),
	trans_state_done(Q,QD),
	write_done_goal(F1,G1),
	write_done_goal(F2,G2).	

write_done_goal(F,and(QD,G1)) :- 
	F =.. [Z,F1], member(Z,[next,always,eventually]),
	trans_sub_state(F,Q),
	trans_state_done(Q,QD),
	write_done_goal(F1,G1).	

write_done_goal(F,and(QD,G2)) :- 
	F =.. [Z,_,F2], member(Z,[until,release]),
	trans_sub_state(F,Q),
	trans_state_done(Q,QD),
	%write_done_goal(F1,G1),
	write_done_goal(F2,G2).	

%write_done_goal(F,and(QD,and(G2,or(not(QB1),G1)))) :- 
%	F =.. [Z,F1,F2], member(Z,[until,release]),
%	trans_sub_state(F,Q),
%	trans_state_done(Q,QD),
%	trans_sub_state(F1,Q1),
%	trans_state_branch(Q1,QB1),
%	write_done_goal(F1,G1),
%	write_done_goal(F2,G2).	

write_done_goal(F,QD) :- !,
	trans_sub_state(F,Q),
	trans_state_done(Q,QD).


%Adds actions to O prime
add_actions:- !,
	add_action_world,
	add_action_copy,
	(
	(action_mode(1);action_mode(2))
	->
	add_action_goal
	;
	true
	),
	add_action_sync.

add_action_goal :- !,
	assertz(action(o_goal)),
	assertz(action_args(o_goal,[])),
	assertz(causes_true(f_goal,o_goal,true)),
	list_states(Q),
	reverse(Q,R),
	R=[_|L],
	reverse(L,LR),
	get_neg_state_conj(LR,X),
	assertz(poss(o_goal,and(and(f_world,f_ok),X))).


get_neg_state_conj([X],not(X)):- !.
get_neg_state_conj([Q|L],X):- !,
	trans_sub_state(S,Q), !,
	get_neg_state_conj(L,Y),
	(
	S\==q_f
	->
	X=and(not(Q),Y)	
	;
	X=Y
	).	

get_done_state_conj([],true):- !.	
get_done_state_conj([X],X):- !.
get_done_state_conj([Q|L],and(Q,X)):- !,
	get_done_state_conj(L,X).


%Formula X transform to goal with done fluents		
%get_goal_done()		



	
add_action_sync :- !,
	(
	(action_mode(2);action_mode(4))
	->
	true
	;
	add_action_sync_end
	),
	add_action_sync_trans.

add_action_sync_end :- !,
	assertz(action(o_world)),
	assertz(action_args(o_world,[])),
	list_states(Q),
	get_neg_sync_conj(Q,N),
	assertz(poss(o_world,and(and(f_sync,f_ok),N))),
	assertz(causes_true(f_world,o_world,true)),
	assertz(causes_false(f_sync,o_world,true)).


get_neg_sync_conj([X],not(XS)):- !,
	trans_state_sync(X,XS).


get_neg_sync_conj([Q|L],X):- !,
	trans_state_sync(Q,QS), !,
	get_neg_sync_conj(L,Y),
	X = and(not(QS),Y).

add_action_sync_trans:- !,
	list_states(Q),
	add_action_trans_state(Q).


add_action_trans_state([]) :- !.
add_action_trans_state([Q|L]) :- !,
	trans_sub_state(S,Q),
	trans_state_sync(Q,QS),
	trans_state_turn(Q,QT),
	string_concat(o_sync_,QS,F),
	string_to_atom(F,Str),
        (
	S == q_r
	->
	assertz(action(Str)),
	assertz(action_args(Str,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		assertz(causes_false(QS,Str,true))
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		assertz(causes_false(QS,Str,QS)),
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))			
		)
	;
	S == true
	->
	assertz(action(Str)),
	assertz(action_args(Str,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		assertz(causes_false(QS,Str,true))
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		assertz(causes_false(QS,Str,QS)),
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))					
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str,LSuper))
		;
		true
		)
	;
	S == q_f
	->
	assertz(action(Str)),
	assertz(action_args(Str,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		assertz(causes_false(QS,Str,true)),
		assertz(causes_false(f_ok,Str,true))	
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
%		assertz(causes_false(QS,Str,QS)),
		assertz(causes_false(f_ok,Str,QS)),
		assertz(causes_false(QT,Str,true)),
		assertz(causes_true(f_world,Str,true)),	
		assertz(causes_false(f_sync,Str,true)),
		forall(is_state(State),
			(
			trans_state_sync(State,SyncState),
			assertz(causes_true(State,Str,SyncState)),
			assertz(causes_false(SyncState,Str,true))			
			))				
		)
	;
	S == false
	->
	assertz(action(Str)),
	assertz(action_args(Str,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		assertz(causes_false(QS,Str,true)),
		assertz(causes_false(f_ok,Str,true))	
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		assertz(causes_false(QS,Str,QS)),
		assertz(causes_false(f_ok,Str,QS)),
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))						
		)
	;
	S == final
	->
	assertz(action(Str)),
	assertz(action_args(Str,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		trans_sub_state(q_f,QF),
		assertz(causes_true(QF,Str,true)),
		assertz(causes_false(QS,Str,true))
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		trans_sub_state(q_f,QF),
		assertz(causes_true(QF,Str,QS)),
		assertz(causes_false(QS,Str,QS)),
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str,LSuper))
		;
		true
		)
	;
	S == rem
	->
	assertz(action(Str)),
	assertz(action_args(Str,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str,true)),
		assertz(causes_false(QS,Str,true))
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str,QS)),
		assertz(causes_false(QS,Str,QS)),
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str,LSuper))
		;
		true
		)
	;
	S = and(S1,S2)
	->
	assertz(action(Str)),
	assertz(action_args(Str,[])),
	trans_sub_state(S1,Q1),
	trans_sub_state(S2,Q2),
	trans_state_sync(Q1,QS1),
	trans_state_sync(Q2,QS2),	
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS1,Str,true)),
		assertz(causes_true(QS2,Str,true)),
		assertz(causes_false(QS,Str,true))
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS1,Str,QS)),
		assertz(causes_true(QS2,Str,QS)),
		assertz(causes_false(QS,Str,QS)),
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str,LSuper))
		;
		true
		)
	;
	S = or(S1,S2)
	->
	string_concat(Str,'_1',F1),
	string_to_atom(F1,Str1),
	string_concat(Str,'_2',F2),
	string_to_atom(F2,Str2),

	trans_sub_state(S1,Q1),
	trans_sub_state(S2,Q2),
	trans_state_sync(Q1,QS1),
	trans_state_sync(Q2,QS2),	

	assertz(action(Str1)),
	assertz(action_args(Str1,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str1,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS1,Str1,true)),
		assertz(causes_false(QS,Str1,true))
		;
		assertz(poss(Str1,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS1,Str1,QS)),
		assertz(causes_false(QS,Str1,QS)),
		assertz(causes_false(QT,Str1,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str1,true))						
		),
	assertz(action(Str2)),
	assertz(action_args(Str2,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str2,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS2,Str2,true)),
		assertz(causes_false(QS,Str2,true))
		;
		assertz(poss(Str2,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS2,Str2,QS)),
		assertz(causes_false(QS,Str2,QS)),
		assertz(causes_false(QT,Str2,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str2,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str1,LSuper)),
		assertz(causes_true(Done,Str2,LSuper))
		;
		true
		)
	;
	S = next(S1)
	->
	trans_sub_state(S1,Q1),
	trans_state_sync(Q1,_),

	assertz(action(Str)),
	assertz(action_args(Str,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(and(f_sync,f_ok),QS))),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str,true)),
		assertz(causes_true(Q1,Str,true)),
		assertz(causes_false(QS,Str,true))	
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str,QS)),
		assertz(causes_true(Q1,Str,QS)),
		assertz(causes_false(QS,Str,QS)),	
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str,LSuper))
		;
		true
		)
	;
	S = eventually(S1)
	->

	string_concat(Str,'_1',F1),
	string_to_atom(F1,Str1),
	string_concat(Str,'_2',F2),
	string_to_atom(F2,Str2),

	trans_sub_state(S1,Q1),
	trans_state_sync(Q1,QS1),

	assertz(action(Str1)),
	assertz(action_args(Str1,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str1,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS1,Str1,true)),
		assertz(causes_false(QS,Str1,true))
		;
		assertz(poss(Str1,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS1,Str1,QS)),
		assertz(causes_false(QS,Str1,QS)),
		assertz(causes_false(QT,Str1,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str1,true))						
		),
	assertz(action(Str2)),
	assertz(action_args(Str2,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str2,and(and(f_sync,f_ok),QS))),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str2,true)),
		assertz(causes_true(Q,Str2,true)),
		assertz(causes_false(QS,Str2,true))
		;
		assertz(poss(Str2,and(and(f_sync,f_ok),QT))),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str2,QS)),
		assertz(causes_true(Q,Str2,QS)),
		assertz(causes_false(QS,Str2,QS)),
		assertz(causes_false(QT,Str2,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str2,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str1,LSuper))
		;
		true
		)
	;
	S = always(S1)
	->

	string_concat(Str,'_1',F1),
	string_to_atom(F1,Str1),
	string_concat(Str,'_2',F2),
	string_to_atom(F2,Str2),

	trans_sub_state(S1,Q1),
	trans_state_sync(Q1,QS1),

	assertz(action(Str1)),
	assertz(action_args(Str1,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str1,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS1,Str1,true)),
		trans_sub_state(q_f,QF),
		assertz(causes_true(QF,Str1,true)),
		assertz(causes_false(QS,Str1,true))
		;
		assertz(poss(Str1,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS1,Str1,QS)),
		trans_sub_state(q_f,QF),
		assertz(causes_true(QF,Str1,QS)),
		assertz(causes_false(QS,Str1,QS)),
		assertz(causes_false(QT,Str1,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str1,true))						
		),
	assertz(action(Str2)),
	assertz(action_args(Str2,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str2,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS1,Str2,true)),
		assertz(causes_true(Q,Str2,true)),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str2,true)),
		assertz(causes_false(QS,Str2,true))
		;
		assertz(poss(Str2,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS1,Str2,QS)),
		assertz(causes_true(Q,Str2,QS)),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str2,QS)),
		assertz(causes_false(QS,Str2,QS)),
		assertz(causes_false(QT,Str2,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str2,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str1,LSuper))
		;
		true
		)
	;
	S = until(S1,S2)
	->
	string_concat(Str,'_1',F1),
	string_to_atom(F1,Str1),
	string_concat(Str,'_2',F2),
	string_to_atom(F2,Str2),

	trans_sub_state(S1,Q1),
	trans_sub_state(S2,Q2),
	trans_state_sync(Q1,QS1),
	trans_state_sync(Q2,QS2),	

	assertz(action(Str1)),
	assertz(action_args(Str1,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str1,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS2,Str1,true)),
		assertz(causes_false(QS,Str1,true))
		;
		assertz(poss(Str1,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS2,Str1,QS)),
		assertz(causes_false(QS,Str1,QS)),
		assertz(causes_false(QT,Str1,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str1,true))						
		),
	assertz(action(Str2)),
	assertz(action_args(Str2,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str2,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS1,Str2,true)),
		assertz(causes_true(Q,Str2,true)),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str2,true)),
		assertz(causes_false(QS,Str2,true))
		;
		assertz(poss(Str2,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS1,Str2,QS)),
		assertz(causes_true(Q,Str2,QS)),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str2,QS)),
		assertz(causes_false(QS,Str2,QS)),
		assertz(causes_false(QT,Str2,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str2,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str1,LSuper)),
		trans_state_branch(Q1,QB1),
		assertz(causes_true(QB1,Str2,true))
		;
		true
		)
	;
	S = release(S1,S2)
	->
	string_concat(Str,'_1',F1),
	string_to_atom(F1,Str1),
	string_concat(Str,'_2',F2),
	string_to_atom(F2,Str2),
	string_concat(Str,'_3',F3),
	string_to_atom(F3,Str3),

	trans_sub_state(S1,Q1),
	trans_sub_state(S2,Q2),
	trans_state_sync(Q1,QS1),
	trans_state_sync(Q2,QS2),	

	assertz(action(Str1)),
	assertz(action_args(Str1,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str1,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS2,Str1,true)),
		trans_sub_state(q_f,QF),
		assertz(causes_true(QF,Str1,true)),
		assertz(causes_false(QS,Str1,true))
		;
		assertz(poss(Str1,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS2,Str1,QS)),
		trans_sub_state(q_f,QF),
		assertz(causes_true(QF,Str1,QS)),
		assertz(causes_false(QS,Str1,QS)),
		assertz(causes_false(QT,Str1,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str1,true))						
		),
	assertz(action(Str2)),
	assertz(action_args(Str2,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str2,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS2,Str2,true)),
		assertz(causes_true(QS1,Str2,true)),
		assertz(causes_false(QS,Str2,true))
		;
		assertz(poss(Str2,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS2,Str2,QS)),
		assertz(causes_true(QS1,Str2,QS)),
		assertz(causes_false(QS,Str2,QS)),
		assertz(causes_false(QT,Str2,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str2,true))						
		),
	assertz(action(Str3)),
	assertz(action_args(Str3,[])),
		(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str3,and(and(f_sync,f_ok),QS))),
		assertz(causes_true(QS2,Str3,true)),
		assertz(causes_true(Q,Str3,true)),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str3,true)),
		assertz(causes_false(QS,Str3,true))
		;
		assertz(poss(Str3,and(and(f_sync,f_ok),QT))),
		assertz(causes_true(QS2,Str3,QS)),
		assertz(causes_true(Q,Str3,QS)),
		trans_sub_state(q_r,QR),
		assertz(causes_true(QR,Str3,QS)),
		assertz(causes_false(QS,Str3,QS)),
		assertz(causes_false(QT,Str3,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str3,true))						
		),
		(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
		assertz(causes_true(Done,Str1,LSuper)),
		assertz(causes_true(Done,Str2,LSuper)),
		trans_state_branch(Q1,QB1),
		assertz(causes_true(QB1,Str2,true))
		;
		true
		)
	;(

	assertz(action(Str)),
	assertz(action_args(Str,[])),
	(
		(action_mode(1);action_mode(3))
		->
		assertz(poss(Str,and(S,and(and(f_sync,f_ok),QS)))),
		assertz(causes_false(QS,Str,true))	
		;
		assertz(poss(Str,and(and(f_sync,f_ok),QT))),
		assertz(causes_false(QS,Str,QS)),
		(
		S = not(S1)
		->
		assertz(causes_false(f_ok,Str,and(QS,S1)))
		;
		assertz(causes_false(f_ok,Str,and(QS,not(S))))		
		),
		assertz(causes_false(QT,Str,true)),
		next_qt(QT,QTN),
		assertz(causes_true(QTN,Str,true))						
		)
	),
	(		
		(action_mode(3);action_mode(4))
		->
		get_super_f(Q,Super),
		get_done_state_conj(Super,LSuper),
		trans_state_done(Q,Done),
			(
			LSuper == true
			->
			assertz(causes_true(Done,Str, and(QS,S) ))		
			;
			assertz(causes_true(Done,Str, and(QS,and(S,LSuper)) ))
			)
		;
		true
	)),
	add_action_trans_state(L).





%Adds actions Oc to O prime
add_action_copy:- !,
	assertz(action(o_copy)),
	assertz(action_args(o_copy,[])),
	assertz(poss(o_copy,and(f_ok,f_copy))),
	assertz(causes_true(f_sync,o_copy,true)),
	(
	(action_mode(2);action_mode(4))
	->
	assertz(causes_true(q_1t,o_copy,true))	
	;
	true	
	),
	assertz(causes_false(f_copy,o_copy,true)),
	list_states(Q),	
	add_cond_copy(Q).

add_cond_copy([]):- !.
add_cond_copy([Q|L]):- !,
	trans_state_sync(Q,QS),
	assertz(causes_true(QS,o_copy,Q)),
	assertz(causes_false(Q,o_copy,true)),
	add_cond_copy(L).


add_action_world:- !,
	list_action_worlds(A), !,
	add_action_world_list(A).	

add_action_world_list([]) :- !.
add_action_world_list([A|L]) :- !,
	get_action_terms(A,T), !,
	X=..[A|T], !,
	poss(X,Z), !,
	retract(poss(X,Z)), !,
	assertz(poss(X,and(Z,and(f_ok,f_world)))),!,	
	assertz(causes_true(f_copy,X,true)),!,
	assertz(causes_false(f_world,X,true)),!,
	add_action_world_list(L).


get_action_terms(A,T):- !,
	action_args(A,X),
	numel(X,N),
	get_var_list(N,T).

get_var_list(0,[]) :- !.
get_var_list(N,[_|T]) :- !,
	M is N-1,
	get_var_list(M,T).



%Adds Q and Qs to F prime
add_state_fluents:- !,
	list_states(Q),			
	add_states_to_fluents(Q).

add_states_to_fluents([]) :- !.
add_states_to_fluents([S|Q]) :- !,
	assertz(fluent(S)),
	assertz(fluent_args(S,[])),
	trans_state_sync(S,Sync),
	assertz(fluent(Sync)),
	assertz(fluent_args(Sync,[])),	
	(
	(action_mode(2);action_mode(4))
	->
	trans_state_turn(S,Turn),
	assertz(fluent(Turn)),
	assertz(fluent_args(Turn,[]))
	;
	true		
	),
	(
	((action_mode(3);action_mode(4)), S\=q_f, S\=q_r)
	->
	trans_state_done(S,Done),
	assertz(fluent(Done)),
	assertz(fluent_args(Done,[]))
	;
	true		
	),

	add_states_to_fluents(Q).


%Writes translation of subformulae and states
write_trans_subf(G):- !,
	list_states(L),
	writef('% States and Subformulae:'),nl,
	write_tr_sub(L),
	writef('% '),nl,
	writef('% Goal:'),write(G).	

write_tr_sub([]) :- !.
write_tr_sub([X|L]) :- !,
	trans_sub_state(S,X),
	writef('% '),writef(X),writef(' = '), write(S),nl,
	write_tr_sub(L).


:- dynamic action_args_copy/2, list_states/1, list_subf/1, list_action_worlds/1.

%Translates from subformula to ID
trans_sub_state(S,Q):- !,
	list_subf(Sub),
	list_states(St),
	nth1(ID,Sub,S),
	nth1(ID,St,Q).	

%Translates state to sync state
trans_state_sync(Q,QS):- !,
	(nonvar(Q)
	->
	string_to_atom(X,Q),
	string_concat(X,s,S),
	string_to_atom(S,QS)
	;
	string_to_atom(S,QS),
	string_concat(X,s,S),
	string_to_atom(X,Q)
	).

%Translates state to turn state used in Mode 2
trans_state_turn(Q,QT):- !,
	(nonvar(Q)
	->
	string_to_atom(X,Q),
	string_concat(X,t,T),
	string_to_atom(T,QT)
	;
	string_to_atom(T,QT),
	string_concat(X,t,T),
	string_to_atom(X,Q)
	).

%Translates state to done state used in Modes 3 and 4
trans_state_done(Q,QD):- !,
	(nonvar(Q)
	->
	string_to_atom(X,Q),
	string_concat(X,d,D),
	string_to_atom(D,QD)
	;
	string_to_atom(D,QD),
	string_concat(X,d,D),
	string_to_atom(X,Q)
	).

%Translates state to branch state used in Modes 3 and 4
trans_state_branch(Q,QB):- !,
	(nonvar(Q)
	->
	string_to_atom(X,Q),
	string_concat(X,b,B),
	string_to_atom(B,QB)
	;
	string_to_atom(B,QB),
	string_concat(X,b,B),
	string_to_atom(X,Q)
	).
	

%Assigns ID to each state of alternating automata
get_alt_states(G):-
	subf(G,Sub),
	append(Sub,[q_r,q_f],S),
	numel(S,Length),
	numlist(1,Length,N),
	enum_states(N,Q),
	assertz(list_subf(S)),
	assertz(list_states(Q)).

%Verifies if a state belongs to the automata

is_state(Q) :- list_states(L),member(Q,L).

enum_states([],[]) :- !.
enum_states([X|L1],[Y|L2]):- !,
	string_concat(q_,X,Z),	
	string_to_atom(Z,Y),
	enum_states(L1,L2). 


%Adds F_S to F prime
add_special_fluents:-
	assertz(fluent(f_copy)),
	assertz(fluent(f_sync)),
	assertz(fluent(f_world)),
	assertz(fluent(f_ok)),
	(
	(action_mode(1);action_mode(2))
	->
	assertz(fluent(f_goal)),
	assertz(fluent_args(f_goal,[]))
	;
	true
	),
	assertz(fluent_args(f_copy,[])),
	assertz(fluent_args(f_sync,[])),
	assertz(fluent_args(f_world,[])),
	assertz(fluent_args(f_ok,[])).




%get action list


action_list(L1):-
	(action_args(X,_)
	->
%	writef(X),nl,
	retract(action_args(X,L)),
	assertz(action_args_copy(X,L)),
%	write_list(L),nl,
	L1=[X|L2],	
	action_list(L2)
	;
	L1 =[],
	restore_action_args
	).

restore_action_args:-
	(action_args_copy(X,_)
	->
	retract(action_args_copy(X,L)),
	assertz(action_args(X,L)),
	restore_action_args
	;
	true
	).


write_list([]).
write_list([X|L]):-
	writef(X),writef(','),
	write_list(L).


%Goal converted to nnf
nnf_goal(always(F),always(X)) :- !,
	nnf_goal(F,X).
%	nnf_goal(release(false,F),X).

nnf_goal(sometime(F),X) :- !,
	nnf_goal(eventually(F),X).

nnf_goal(not(sometime(F)),X) :- !,
	nnf_goal(not(eventually(F)),X).

nnf_goal(eventually(F),eventually(X)) :- !,
	nnf_goal(F,X).
%	nnf_goal(until(true,F),X).

nnf_goal(not(eventually(F)),always(X)) :- !,
	nnf_goal(not(F),X).

nnf_goal(not(always(F)),eventually(X)) :- !,
	nnf_goal(not(F),X).

nnf_goal(not(next(F)),X) :- !,
	nnf_goal(or(final,next(not(F))),X).

nnf_goal(next(F),next(Fp)) :- !,
	nnf_goal(F,Fp).

nnf_goal(not(and(A1,A2)),or(A1p,A2p)) :- !,
	nnf_goal(not(A1),A1p),
	nnf_goal(not(A2),A2p).

nnf_goal(not(or(A1,A2)),and(A1p,A2p)) :- !,
	nnf_goal(not(A1),A1p),
	nnf_goal(not(A2),A2p).

nnf_goal(not(until(F1,F2)),release(F1p,F2p)) :- !,
	nnf_goal(not(F1),F1p),
	nnf_goal(not(F2),F2p).

nnf_goal(not(release(F1,F2)),until(F1p,F2p)) :- !,
	nnf_goal(not(F1),F1p),
	nnf_goal(not(F2),F2p).

nnf_goal(or(F1,F2), or(F1p,F2p)) :- !,
	nnf_goal(F1,F1p),
	nnf_goal(F2,F2p).

nnf_goal(and(F1,F2), and(F1p,F2p)) :- !,
	nnf_goal(F1,F1p),
	nnf_goal(F2,F2p).

nnf_goal(until(F1,F2), until(F1p,F2p)) :- !,
	nnf_goal(F1,F1p),
	nnf_goal(F2,F2p).

nnf_goal(release(F1,F2), release(F1p,F2p)) :- !,
	nnf_goal(F1,F1p),
	nnf_goal(F2,F2p).

nnf_goal(not(not(X)), Xp) :- !,
	nnf_goal(X,Xp).

nnf_goal(imp(X,Y),Z) :- !,
	nnf_goal(or(not(X),Y),Z).

nnf_goal(not(imp(X,Y)),Z) :- !,
	nnf_goal(not(or(not(X),Y)),Z).

nnf_goal(not(final),rem) :- !.
nnf_goal(not(rem),final) :- !.

nnf_goal(not(true),false) :- !.
nnf_goal(not(false),true) :- !.

nnf_goal(X,X) :- !, % its a proposition
	assertz(is_varG(X)).

%simplify formula


simple_goal(X,Y) :-
	simplify_goal(X,Z),
	(X \== Z -> simple_goal(Z,Y); Z=Y).

simplify_goal(or(_,true),true) :- !.
simplify_goal(or(X,false),X) :- !.
simplify_goal(or(X,not(X)),true) :- !.
simplify_goal(or(rem,final),true) :- !.
simplify_goal(or(true,_),true) :- !.
simplify_goal(or(false,X),X) :- !.
simplify_goal(or(not(X),X),true) :- !.
simplify_goal(or(final,rem),true) :- !.

simplify_goal(and(X,true),X) :- !.
simplify_goal(and(_,false),false) :- !.
simplify_goal(and(X,not(X)),false) :- !.
simplify_goal(and(rem,final),false) :- !.
simplify_goal(and(true,X),X) :- !.
simplify_goal(and(false,_),false) :- !.
simplify_goal(and(not(X),X),false) :- !.
simplify_goal(and(final,rem),false) :- !.

simplify_goal(or(X,X),X) :- !.
simplify_goal(and(X,X),X) :- !.
simplify_goal(until(X,X),X) :- !.
simplify_goal(release(X,X),X) :- !.

simplify_goal(until(true,X),eventually(X)) :- !.
simplify_goal(release(false,X),always(X)) :- !.
simplify_goal(until(_,true),true) :- !.
simplify_goal(release(_,false),false) :- !.
simplify_goal(until(false,X),X) :- !.
simplify_goal(release(true,X),X) :- !.
simplify_goal(until(_,false),false) :- !.
simplify_goal(release(_,true),true) :- !.


simplify_goal(next(F1),next(F1p)) :-
	simplify_goal(F1,F1p).

simplify_goal(always(always(X)),always(X)) :- !.

simplify_goal(eventually(eventually(X)),eventually(X)) :- !.

simplify_goal(always(F1),always(F1p)) :-
	simplify_goal(F1,F1p).

simplify_goal(eventually(F1),eventually(F1p)) :-
	simplify_goal(F1,F1p).
	
simplify_goal(until(F1,F2),until(F1p,F2p)) :- !,
	simplify_goal(F1,F1p),
	simplify_goal(F2,F2p).

simplify_goal(release(F1,F2),release(F1p,F2p)) :- !,
	simplify_goal(F1,F1p),
	simplify_goal(F2,F2p).

simplify_goal(and(F1,F2),and(F1p,F2p)) :- !,
	(F1 @=<F2 
	->
 	simplify_goal(F1,F1p),
	simplify_goal(F2,F2p)
	;
 	simplify_goal(F2,F1p),
	simplify_goal(F1,F2p)
	).

simplify_goal(or(F1,F2),or(F1p,F2p)) :- !,
	(F1 @=<F2 
	->
 	simplify_goal(F1,F1p),
	simplify_goal(F2,F2p)
	;
 	simplify_goal(F2,F1p),
	simplify_goal(F1,F2p)
	).


simplify_goal(X,X).

%subformulae

subf(X,L) :- get_subf(X,L1), sort(L1,L2),
	((action_mode(2);action_mode(4))
	->
	predsort(topo_order,L2,L3),
	reverse(L3,L)
	;
	L2=L
	).


%topo_order: order formulae topologically

topo_order(=,X,Y) :- X==Y.
topo_order(<,X,Y) :-
	 (is_subf(X,Y)
	 ->
	 true;
	 f_length(X,F1),
	 f_length(Y,F2),
	 F1=<F2	 
 	 ). 
topo_order(>,X,Y) :- topo_order(<,Y,X).

get_subf(and(X,Y),[and(X,Y)|L]) :- !,
	get_subf(X,L1),
	get_subf(Y,L2),
	append(L1,L2,L).

get_subf(or(X,Y),[or(X,Y)|L]) :- !,
	get_subf(X,L1),
	get_subf(Y,L2),
	append(L1,L2,L).

get_subf(until(X,Y),[until(X,Y)|L]) :- !,
	get_subf(X,L1),
	get_subf(Y,L2),
	append(L1,L2,L).

get_subf(release(X,Y),[release(X,Y)|L]) :- !,
	get_subf(X,L1),
	get_subf(Y,L2),
	append(L1,L2,L).

get_subf(next(X),[next(X)|L]) :- !,
	get_subf(X,L).
	
get_subf(always(X),[always(X)|L]) :- !,
	get_subf(X,L).

get_subf(eventually(X),[eventually(X)|L]) :- !,
	get_subf(X,L).

%get_subf(not(X),[not(X)|L]) :- !,
%	get_subf(X,L).

get_subf(X,[X]).

%is_subf: verify if X is subformulae of Y

is_subf(X,X) :- !.

is_subf(X,Y) :- Y =..[Z,A], member(Z,[next,always,eventually]), is_subf(X,A) , !.

is_subf(X,Y) :- !, Y =..[Z,A1,A2], member(Z,[and,or,until,release]), (is_subf(X,A1) , ! ;is_subf(X,A2),!).


%get_super_f: Given a state X, get a list of done states Y whose formula contains the subformulae represented by X.

get_super_f(X,Y) :- !, trans_sub_state(S1,X),
		 findall(D,(
			is_state(Q),
			trans_sub_state(S2,Q),
			S1\=S2,
			is_subf(S1,S2),
			trans_sub_state(S2,F),
			trans_state_done(F,D)			
			),Y).

 

%f_length: calculates length of formula

f_length(X,Y) :- X =..[Z,A], member(Z,[next,always,eventually,not]), f_length(A,Y1) , Y is Y1+1 ,!.
f_length(X,Y) :- X =..[Z,A1,A2], member(Z,[and,or,until,release]), f_length(A1,Y1), f_length(A2,Y2), Y is Y1+Y2+1, !.
f_length(_,1) :- !.

%numel: number of elements in a list

numel([],0).
numel([_|L],S) :- numel(L,S1), S is S1+1.


%assign id to subformulae

subf_id(X,L,ID) :- nth0(ID,L,X).
next_qt(QT1,QT2) :-
	trans_state_turn(Q,QT1),
	list_states(L),
	nth0(ID,L,Q),
	ID1 is ID+1,
	nth0(ID1,L,Q1),
	trans_state_turn(Q1,QT2). 

%macro formulae (or,and operators use lists of terms instead of binary)

macro_f(not(X),not(Y)) :- !,
	macro_f(X,Y).
macro_f(next(X),next(Y)) :- !,
	macro_f(X,Y).
macro_f(always(X),always(Y)) :- !,
	macro_f(X,Y).
macro_f(eventually(X),eventually(Y)) :- !,
	macro_f(X,Y).

macro_f(until(X1,Y1),until(X2,Y2)) :- !,
	macro_f(X1,X2),
	macro_f(Y1,Y2).

macro_f(release(X1,Y1),release(X2,Y2)) :- !,
	macro_f(X1,X2),
	macro_f(Y1,Y2).

macro_f(and(X1,Y1),and([X2,Y2])) :- !,
	macro_f(X1,X2),
	macro_f(Y1,Y2).

macro_f(or(X1,Y1),or([X2,Y2])) :- !,
	macro_f(X1,X2),
	macro_f(Y1,Y2).

macro_f(X,X).


