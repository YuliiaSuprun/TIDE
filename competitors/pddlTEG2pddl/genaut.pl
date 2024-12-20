:- consult(verbosity).


size_fla(F,N) :- F=..[_,X,Y],!, % binary operators
	size_fla(X,N1),
	size_fla(Y,N2),
	N is N1+N2+1.
size_fla(F,N) :- F=..[_,X],!, % unary operators
	size_fla(X,N1),
	N is N1+1.

size_fla(_,0). % assuming it's a proposition


compound_ltl(until(_,_)).
compound_ltl(release(_,_)).
compound_ltl(and(_,_)).
compound_ltl(or(_,_)).
compound_ltl(next(_)).
compound_ltl(not(X)) :- compound_ltl(X).

%% to_ltl(F,Fp)
%% transform a formula to ltl

%quantifiers

to_ltl(all(X,F),all(X,Fp)) :- !,
	to_ltl(F,Fp).

to_ltl(exists(X,F),exists(X,Fp)) :- !,
	to_ltl(F,Fp).


% standard temporal connectives
to_ltl(always(F),always(Fp)) :- !,
	to_ltl(F,Fp).

to_ltl(until(X,Y),until(Xp,Yp)) :-
	to_ltl(X,Xp),
	to_ltl(Y,Yp).

to_ltl(eventually(F),eventually(Fp)) :- !,
	to_ltl(F,Fp).

to_ltl(sometime(F),eventually(Fp)) :- !,
	to_ltl(F,Fp).


to_ltl(next(F),next(Fp)) :- !,
	to_ltl(F,Fp).

% extended boolean connectives

to_ltl(at_end(F),eventually(always(Fp))) :-
	to_ltl(F,Fp).

to_ltl(within(T,X),F) :-
	translate_within(within(T,X),Fp),
	to_ltl(Fp,F).

%to_ltl(at_most_once(F),always(or(not(Fp),or(final,next(always(not(Fp)))))))   :-
%	to_ltl(F,Fp).

to_ltl('at-most-once'(F),X) :-
	to_ltl(at_most_once(F),X).

to_ltl('sometime-before'(F,P),X) :-
	to_ltl(sometime_before(F,P),X).

to_ltl(at(end,F),X) :- !,
	to_ltl(at_end(F),X).


to_ltl(at_most_once(F),always(or(not(Fp),until(Fp,or(final,always(not(Fp)))))))  :-
	to_ltl(F,Fp).

to_ltl(sometime_before(F,P),
       or(always(not(Fp)),
	  until(and(not(Fp),not(Pp)),
		and(Pp,and(not(Fp),next(eventually(Fp))))))) :-
	to_ltl(F,Fp),
	to_ltl(P,Pp).

to_ltl(sometime_after(F1,F2),Fp) :-
	to_ltl(always(implies(F1,eventually(F2))),Fp).


to_ltl(hold_after(T,F),Fpp) :-
	to_ltl(F,Fp),
	next_to_the(T,eventually(Fp),Fpp).

to_ltl(hold_during(T1,T2,X),Fp) :- !,
	translate_hold_during(hold_during(T1,T2,X),Fpp),
	to_ltl(Fpp,Fp).
	

% standard boolean connectives

to_ltl(not(F),not(Fp)) :- !,
	to_ltl(F,Fp).

to_ltl(and(X,Y),and(Xp,Yp)) :- !,
	to_ltl(X,Xp),
	to_ltl(Y,Yp).

to_ltl(or(X,Y),or(Xp,Yp)) :- !,
	to_ltl(X,Xp),
	to_ltl(Y,Yp).

% extended boolean connectives

to_ltl(implies(X,Y),or(not(Xp),Yp)) :- !,
	to_ltl(X,Xp),
	to_ltl(Y,Yp).



to_ltl(X,X).  % we assume it's an atom


to_nnf(not(exists(X,Fla)),all(X,Flap)) :- !,
        to_nnf(not(Fla),Flap).

to_nnf(exists(X,Fla),exists(X,Flap)) :- !,
        to_nnf(Fla,Flap).

to_nnf(not(all(X,Fla)),exists(X,Flap)) :- !,
        to_nnf(not(Fla),Flap).

to_nnf(all(X,Fla),all(X,Flap)) :- !,
        to_nnf(Fla,Flap).

to_nnf(always(F),X) :- !,
	to_nnf(release(false,F),X).

to_nnf(eventually(F),X) :- !,
	to_nnf(until(true,F),X).

to_nnf(not(eventually(F)),X) :- !,
	to_nnf(not(until(true,F)),X).

to_nnf(not(always(F)),X) :- !,
	to_nnf(not(release(false,F)),X).

to_nnf(not(next(F)),X) :- !,
	to_nnf(or(final,next(not(F))),X).

to_nnf(next(F),next(Fp)) :- !,
	to_nnf(F,Fp).

to_nnf(eventually(F),X) :- !,
	to_nnf(until(true,F),X).

to_nnf(not(and(A1,A2)),or(A1p,A2p)) :- !,
	to_nnf(not(A1),A1p),
	to_nnf(not(A2),A2p).

to_nnf(not(or(A1,A2)),and(A1p,A2p)) :- !,
	to_nnf(not(A1),A1p),
	to_nnf(not(A2),A2p).

to_nnf(not(until(F1,F2)),release(F1p,F2p)) :- !,
	to_nnf(not(F1),F1p),
	to_nnf(not(F2),F2p).

to_nnf(not(release(F1,F2)),until(F1p,F2p)) :- !,
	to_nnf(not(F1),F1p),
	to_nnf(not(F2),F2p).

to_nnf(or(F1,F2), or(F1p,F2p)) :- !,
	to_nnf(F1,F1p),
	to_nnf(F2,F2p).

to_nnf(and(F1,F2), and(F1p,F2p)) :- !,
	to_nnf(F1,F1p),
	to_nnf(F2,F2p).

to_nnf(until(F1,F2), until(F1p,F2p)) :- !,
	to_nnf(F1,F1p),
	to_nnf(F2,F2p).

to_nnf(release(F1,F2), release(F1p,F2p)) :- !,
	to_nnf(F1,F1p),
	to_nnf(F2,F2p).

to_nnf(not(not(X)), Xp) :-
	to_nnf(X,Xp).

to_nnf(imp(X,Y),or(not(Xp),Yp)) :-
	to_nnf(X,Xp),
	to_nnf(Y,Yp).

to_nnf(X,X). % it's a proposition


% breakup(F1,F2)
% fix-point version of breakup_nnf

breakup(F1,F2) :-
	breakup_nnf(F1,Fp),
	(F1 = Fp ->
	    Fp = F2
	;
	    breakup(Fp,F2)
	).


% breakup_nnf(F1,F2)
% uses LTL equivalencies to break-up LTL formulae
% for example, always(and(f,g)) is converted
% into and(always(f),always(g))

breakup_nnf(and(X,Y),and(Xp,Yp)) :-
	breakup_nnf(X,Xp),
	breakup_nnf(Y,Yp).

breakup_nnf(or(X,Y),or(Xp,Yp)) :-
	breakup_nnf(X,Xp),
	breakup_nnf(Y,Yp).
	
breakup_nnf(not(X),not(Xp)) :-
	breakup_nnf(X,Xp).

breakup_nnf(next(and(X,Y)),and(next(Xp),next(Yp))) :- !,
	breakup_nnf(X,Xp),
	breakup_nnf(Y,Yp).

breakup_nnf(next(X),next(Xp)) :- !,
	breakup_nnf(X,Xp).

breakup_nnf(until(and(X,Y),Z),and(U,V)) :- !,
	breakup_nnf(until(X,Z),U),
	breakup_nnf(until(Y,Z),V).

breakup_nnf(until(X,or(Y,Z)),or(U,V)) :- !,
	breakup_nnf(until(X,Y),U),
	breakup_nnf(until(X,Z),V).

breakup_nnf(until(X,Y),until(Xp,Yp)) :- !,
	breakup_nnf(X,Xp),
	breakup_nnf(Y,Yp).
	   
breakup_nnf(release(or(X,Y),Z),or(U,V)) :- !,
	breakup_nnf(release(X,Z),U),
	breakup_nnf(release(Y,Z),V).

breakup_nnf(release(X,and(Y,Z)),and(U,V)) :- !,
	breakup_nnf(release(X,Y),U),
	breakup_nnf(release(X,Z),V).

breakup_nnf(release(X,Y),release(Xp,Yp)) :- !,
	breakup_nnf(X,Xp),
	breakup_nnf(Y,Yp).

breakup_nnf(X,X). % X is a literal


simplify_nnf(not(true),false):-!.
simplify_nnf(not(false),true):-!.
simplify_nnf(not(not(F)),Fp) :- !,
	simplify_nnf(F,Fp).

simplify_nnf(next(F1),next(F1p)) :-
	simplify_nnf(F1,F1p).
	
simplify_nnf(until(F1,F2),until(F1p,F2p)) :- !,
	simplify_nnf(F1,F1p),
	simplify_nnf(F2,F2p).

simplify_nnf(release(F1,F2),release(F1p,F2p)) :- !,
	simplify_nnf(F1,F1p),
	simplify_nnf(F2,F2p).

simplify_nnf(and(F1,F2),and(F1p,F2p)) :- !,
	simplify_nnf(F1,F1p),
	simplify_nnf(F2,F2p).

simplify_nnf(or(F1,F2),or(F1p,F2p)) :- !,
	simplify_nnf(F1,F1p),
	simplify_nnf(F2,F2p).

simplify_nnf(X,X). %it's a proposition



find_equal(Old,Next,[X|_],X) :-
	X=[_,_,EOld,_,ENext],
	subset(Old,EOld),
	subset(EOld,Old),
	subset(ENext,Next),
	subset(Next,ENext),!.

find_equal(Old,Next,[_|Rest],T) :-
	find_equal(Old,Next,Rest,T).



% expand predicate implements the Gerth et al. 95 algorithm
% it includes optimizations for the finite case

expand([Id,Incoming,Old,New,Next],NewId,CurNodeSet,FinalNodeSet,FinalId) :-
	(is_verbose -> 
	    write([Id,Incoming,Old,New,Next]),write('--'),write(CurNodeSet),nl;
	    true
	),
	New = [],
	(find_equal(Old,Next,CurNodeSet,[EId,EIncoming,EOld,ENew,ENext]) ->
	    subtract(CurNodeSet,[[EId|_]],NS),
	    union(Incoming,EIncoming,NewIncoming),
	    union(NS,[[EId,NewIncoming,EOld,ENew,ENext]],FinalNodeSet),
	    NewId = FinalId
	;

	    NNewId is NewId+1,
	    union(CurNodeSet,[[Id,Incoming,Old,New,Next]],NewCur),
	    (\+ member(final,Old) ->
		expand([NewId,[Id],[],Next,[]],NNewId,NewCur,FinalNodeSet,FinalId)
	    ;
				% if a node contains final, no need to compute successors
		(Next=[] ->
		    FinalNodeSet=NewCur % we add the node only if Next is empty!
		                        % if Next is not empty it would be a dead-end non final node
		;
		    FinalNodeSet=CurNodeSet
		),
		FinalId=NewId
	    )
	).

expand([_,_,_,New,_],NewId,CurNodeSet,CurNodeSet,NewId) :-
	member(false,New). % node is discarded

expand([Id,Incoming,Old,New,Next],NewId,CurNodeSet,FinalNodeSet,FinalId) :-
	New \= [],
	\+ member(false,New),
	subtract(New,[Fla],NNew),
	(Fla = true ->
	    expand([Id,Incoming,Old,NNew,Next],NewId,CurNodeSet,FinalNodeSet,FinalId)
	;
	    complement_fla(Fla,FlaComplement),
	    (member(FlaComplement,New) -> % a contradiction has occurred
		FinalNodeSet = CurNodeSet, NewId=FinalId
	    ;
		
		union(Old,[Fla],NewOld),
		(Fla = and(Psi1,Psi2) ->
		    union(NNew,[Psi1,Psi2],NNew1),
		    subtract(NNew1,Old,NNew2),
		    expand([Id,Incoming,NewOld,NNew2,Next],NewId,CurNodeSet,FinalNodeSet,FinalId)
		;
		    ((Fla=until(_,_); Fla=release(_,_); Fla=or(_,_)) ->
			exp_new1(Fla,ENew1),union(NNew,ENew1,New1p),subtract(New1p,Old,New1),
			exp_next(Fla,ENext1),union(Next,ENext1,Next1),
			exp_new2(Fla,ENew2),union(NNew,ENew2,New2p),subtract(New2p,Old,New2),
			expand([Id,Incoming,NewOld,New1,Next1],NewId,CurNodeSet,FinalNode1,FinalId1),
			FId is FinalId1+1,
			expand([FinalId1,Incoming,NewOld,New2,Next],FId,FinalNode1,FinalNodeSet,FinalId)
		    ;
			(Fla = next(F) ->
			    union(Next,[F],NNext),
			    expand([Id,Incoming,NewOld,NNew,NNext],NewId,CurNodeSet,FinalNodeSet,FinalId)
			;
				% now we know Fla is a proposition
			    (((Fla = not(Prop),member(Prop,Old)); (Fla=Prop, member(not(Prop),Old)) ; Fla=false) ->
				% There is a contradiction
				CurNodeSet = FinalNodeSet,
				NewId = FinalId
			    ;
				union(Old,[Fla],NewOld),
				expand([Id,Incoming,NewOld,NNew,Next],NewId,CurNodeSet,FinalNodeSet,FinalId)
			    )
			)
		    )
		)
	    )
	).


complement_fla(not(F),F) :- !.
complement_fla(F,not(F)).

%%%%%
%%%%  Special cases for landmark orderings
%%%

genaut(natural_ordering(A,B),	[[2, 0, 1, [[2, [not(A),not(B)]],[3, [A, not(B)]]],[not(A),not(B)]], 	[1, 1, 0, [[1, []]],[not_in_state__(3)]], 	[3, 0, 0, [[3, [not(B)]], [1, [B]]],[not(B),not_in_state__(2)]]]).

%genaut(natural_ordering(A,B),	[[2, 0, 1, [[2, [not(A),not(B)]],[3, [A, not(B)]],[sink,[B]]],[not(A),not(B)]], 	[1, 1, 0, [[1, []]],[not_in_state__(3)]], 	[3, 0, 0, [[3, [not(B)]], [1, [B]]],[not(B),not_in_state__(2)]],        [sink,0,0,[[sink,[]]],[]]]).

genaut(greedy_necessary_ordering(A,B),[[2, 0, 1, [[2, [not(A),not(B)]], [3, [A, not(B)]]],[not(A),not(B)]], [1, 1, 0, [[1, []]],[not_in_state__(3)]], [3, 0, 0, [[1, [B]]],[A,not(B),not_in_state__(2)]]]).
%genaut(necessary_ordering(A,B),[[3, 0, 1, [[2, []], [3, [A]], [5, [B]], [1, [B]]]], [2, 0, 0, [[2, [not(B)]], [3, [not(B), A]]]], [5, 0, 0, [[5, [B]], [4, []], [5, [A]], [1, []]]], [4, 0, 0, [[4, [not(B)]], [5, [not(B), A]], [1, [not(B)]]]], [1, 1, 0, []]]).

genaut(necessary_ordering(A,B),[[2,0,1,[[2,[not(A),not(B)]],[3,[A,not(B)]]],[not(A),not(B),not_in_state__(1),not_in_state__(3)]],[3,0,0,[[2,[not(A),not(B)]],[1,[B]],[3,[A,not(B)]]],[A,not(B),not_in_state__(1),not_in_state__(2)]],[1,1,0,[[1,[B]],[2,[not(A),not(B)]],[3,[not(B),A]]] ,[B,not_in_state__(2),not_in_state__(3)]]]).
%% genaut(necessary_ordering(A,B),
%% 	[[2,0,1,[[2,[not(A),not(B)]],
%% 	         [3,[A,not(B)]]],
%%                 [not(A),not(B),not_in_state__(1),not_in_state__(3)]],
%%          [3,0,0,[[2,[not(A),not(B)]],[1,[B]],
%%                  [3,[A,not(B)]]],
%%                 [A,not(B),not_in_state__(1),not_in_state__(2)]],
%%          [1,1,0,[[1,[B]],
%%                  [2,[not(A),not(B)]],
%%                  [3,[not(B),A]]] ,
%%                 [B,not_in_state__(2),not_in_state__(3)]],
%%          [sink,0,0,[[sink,[]]],[]]]).


%genaut(reasonable_ordering(A,B),[[2, 0, 1, [[3, [not(A)]], [4, [B]], [6, [not(B)]], [7, [A]], [1, [A, B]]]], [3, 0, 0, [[3, [not(A)]], [4, [B]]]], [5, 0, 0, [[5, []], [7, [A]], [1, [A, B]]]], [7, 0, 0, [[7, []], [1, [B]]]], [1, 1, 0, [[1, []]]], [4, 0, 0, [[4, []], [5, [not(B)]], [7, [not(B), A]]]], [6, 0, 0, [[6, [not(B)]], [7, [A]], [1, [A, B]]]]]).
genaut(reasonable_ordering(A,B),[
        [2,0,1,TRANS2,ASS2],
	[3,0,0,TRANS3,ASS3],
	[1,1,0,TRANS1,ASS1],
	[4,0,0,TRANS4,ASS4],
	[5,0,0,TRANS5,ASS5]]) :-
	TRANS1=[[1,[]]],
	TRANS2=[[2,[not(A),not(B)]],[3,[A,not(B)]],[4,[B,not(A)]],[1,[A,B]]],
	TRANS3=[[3,[not(B)]],[1,[B]]],
	TRANS4=[[4,[B,not(A)]],[3,[A,not(B)]],[5,[A,B]],[2,[not(A),not(B)]]],
	TRANS5=[[3,[not(B)]],[5,[B]]],
	ASS1=[],
	ASS2=[not(A),not(B),not_in_state__(1),not_in_state__(3),not_in_state__(4),not_in_state__(5)],
	ASS3=[not(B),not_in_state__(1),not_in_state__(2),not_in_state__(4),not_in_state__(5)],
	ASS4=[B,not(A),not_in_state__(1),not_in_state__(2),not_in_state__(3),not_in_state__(5)],
	ASS5=[B,not_in_state__(1),not_in_state__(2),not_in_state__(3),not_in_state__(4)].
	

	
genaut(Fla,Aut) :-
	expand([1,[0],[],[Fla],[]],2,[],A0,_),
	tolabel(A0,A1),
	simplify_aut(A1,A2),
	reduction(A2,A3),
	simplify_aut(A3,Aut).


% simplify_aut(Fla,Aut)

simplify_aut(Aut,SSAut) :-
	findall(Final,member([Final,1,_,_],Aut),Finals),
	bfs_fixpoint_back(Aut,Finals,ReachableBack),
	dwritef("Reachable Back: %q",[ReachableBack]),
	prune_aut(Aut,ReachableBack,SAut),
	findall(Initial,member([Initial,_,1,_],Aut),Initials),
	bfs_fixpoint_forward(Aut,Initials,ReachableForward),
	prune_aut(SAut,ReachableForward,SSAut),
	dwritef("Reachable Forward: %q",[ReachableBack]).

	

bfs_fixpoint_back(Aut,Initials,Finals) :-
	findall(Node,(member(Reachable,Initials),
		      member([Node,_,_,AdjList],Aut),
		      member([Reachable,_],AdjList)),OneStepList),
	list_to_set(OneStepList,OneStep),  % OneStep contains nodes that are reachable 
	union(Initials,OneStep,NInitials),
	length(Initials,N1),
	length(NInitials,N2),
	(N1=N2 ->
	    Finals = Initials;
	    bfs_fixpoint_back(Aut,NInitials,Finals)
	).

bfs_fixpoint_forward(Aut,Initials,Finals) :-
	findall(Node,(member(Reachable,Initials),
		      member([Reachable,_,_,AdjList],Aut),
		      member([Node,_],AdjList)),OneStepList),
	list_to_set(OneStepList,OneStep),  % OneStep contains nodes that are reachable 
	union(Initials,OneStep,NInitials),
	length(Initials,N1),
	length(NInitials,N2),
	(N1=N2 ->
	    Finals = Initials;
	    bfs_fixpoint_forward(Aut,NInitials,Finals)
	).




prune_aut(Aut,Finals,SAut) :-
	findall([Id,IsFinal,IsInitial,AdjList],
		(
		  member([Id,IsFinal,IsInitial,AdjL],Aut),
		  member(Id,Finals),
		  findall([Node,Label],(member([Node,Label],AdjL),member(Node,Finals)),AdjList)
		),
		SAut),
	(member([_,_,1,_],SAut) ->
	    true;
	    writef("Warning: Resulting automaton has no initial states !")
	).

	    
	       






% tolabel(Saut,Laut)
% given a state-labeled automaton, Saut, unifies Laut
% with a transition-labeled automaton

tolabel(SAut,LAut) :-
	SAutp=[[0,[],[],[],[]]|SAut],
	findall(Id,member([Id,_,_,_,_],SAutp),Ids),
	adjlist(Ids,SAutp,LAut).

adjlist([Id|Ids],SAut,[[Id,IsFinal,IsInitial,AdjList]|Rest]) :-
	findall([TId,Atoms],
		(member([TId,TInc,TOld,_,_],SAut),
		    member(Id,TInc),
		    findall(Atom,(member(Atom,TOld),\+compound_ltl(Atom),Atom\=final,Atom\=not(final)),Atoms)),AdjList),
	(Id = 0 ->
	    IsInitial=1
	;
	    IsInitial=0
	),
	( (member([Id,_,Old,_,[]],SAut),Id\=0,\+member(not(final),Old)) ->
	    IsFinal = 1
	;
	    IsFinal = 0
	),
	adjlist(Ids,SAut,Rest).
adjlist([],_,[]).


showaut(Aut) :-
	tell(pipe('dot -Tps -o /tmp/automaton.ps')),
	writef("digraph automaton_for_ltl { \nrankdir=LR;\nsize=\"6,3\" \nnode [shape = doublecircle];"),
	findall(X,(member([Id,1,_,_|_],Aut),concat_atom(['s_',Id],X)),Final),
	print_list(Final),writef(";\nnode [shape = circle];\n"),
	findall([Source,Target,Label],(member([S,_,_,AdjList|_],Aut),member([T,Label],AdjList),concat_atom(['s_',S],Source),concat_atom(['s_',T],Target)),STL),
	print_stl(STL),
	writef("}\n"),
	told,
	shell('gv /tmp/automaton.ps').


print_stl([]).
print_stl([STL|Rest]) :-
	 writef("%q -> %q [ label = \"%q\" ];\n",STL),
	 print_stl(Rest).

print_list([]).

print_list([T|Ts]) :-
	write(T),write(' '),
        print_list(Ts).


red_automaton(_,[],_,_,[]).
red_automaton(Aut,[Color|RestColor],FColor,NList,[[Color,IsFinal,IsInitial,AdjList]|RestAut]) :-
	( (member([IdInitial,_,1,_],Aut), qcolor(IdInitial,FColor,Color)) ->
	    IsInitial = 1
	;
	    IsInitial = 0
	),
	( (qcolor(IdInitial,FColor,Color), member([IdInitial,1,_,_],Aut)) ->
	    IsFinal = 1
	;
	    IsFinal = 0
	),
	findall([ColorA,Tau], (
				qcolor(Q1,FColor,Color),
				member([Q1,N1],NList),
				member([ColorA,Tau],N1)),Adj),
	list_to_set(Adj,AdjList),
	red_automaton(Aut,RestColor,FColor,NList,RestAut).
	
reduction(Aut,Aut2) :-
	init_colors(Aut,ColorList),
	dwritef("InitColor=%q\n",[ColorList]),
	PoLess = [[2,1,1],[1,1,1],[2,2,1],[1,2,0]],
	fair_sim_red(Aut,ColorList,PoLess,FColor,FPoLess),
	computeN(Aut,FPoLess,FColor,NList),
	dwritef("FinalNList=%q\n",[NList]),
	findall(Color,member([_,Color],FColor),CS),
	list_to_set(CS,ColorSet),
	dwritef("FinalColorSet=%q\n",[ColorSet]),
	red_automaton(Aut,ColorSet,FColor,NList,Aut2).


fair_sim_red(Aut,ColorList,PoLess,FColorList,FPoLess) :-
	computeN(Aut,PoLess,ColorList,NList),
%	writef("NList=%q\n",[NList]),
	new_color_list(ColorList,NList,NewColorList),
%	writef("NewColorList=%q\n",[NewColorList]),
	findall([C,N],member([_,[C,N]],NewColorList),CS), % CS is the 'set' of colors
%	writef("CS=%q\n",[CS]),
	tocolorset(CS,CSp),
	predsort(color_pair_compare,CSp,CS2), % Now CS2 is the real ordered set
	addnumbers(1,CS2,ColorSet),
	dwritef("ColorSet=%q\n",[ColorSet]),
	findall([Number2,Number1,X], (
			     member([Number1,[C1,N1]],ColorSet),
			     member([Number2,[C2,N2]],ColorSet),
			     ((member([C2,C1,1],PoLess),i_dominates_nlist(N1,N2,PoLess)) ->
				 X=1
			     ;
				 X=0
			     )
			   ),NewPoLess),
	final_color_list(NewColorList,ColorSet,NextColorList),
	length(NextColorList,L1),
	length(ColorList,L2),
	length(PoLess,Lp1),
	length(NewPoLess,Lp2),
	dwritef("NextColorList=%q\nNewPoLess=%q\n",[NextColorList,NewPoLess]),
	( (L1 = L2, Lp1 = Lp2) ->
	    NextColorList = FColorList,
	    FPoLess = NewPoLess
	;
	    fair_sim_red(Aut,NextColorList,NewPoLess,FColorList,FPoLess)
	).

addnumbers(_,[],[]).
addnumbers(N,[X|Xs],[[N,X]|Ys]) :-
	NN is N+1,
	addnumbers(NN,Xs,Ys).

final_color_list([],_,[]).
final_color_list([[Node,OldColor]|R1],ColorSet,[[Node,NewColor]|R2]) :-
	find_color_number(OldColor,ColorSet,NewColor),
	final_color_list(R1,ColorSet,R2).

find_color_number(OldColor,[[Number,NewColor]|_],Number) :-
	color_pair_compare(=,OldColor,NewColor),!.

find_color_number(OldColor,[[_,_]|Rest],Number) :-
	find_color_number(OldColor,Rest,Number).

% color_pair_compare compairs two color pairs (color,Nlist)

color_pair_compare(<,[C1,_],[C2,_]) :-
	C1 < C2,!.
color_pair_compare(>,[C1,_],[C2,_]) :-
	C1 > C2,!.
color_pair_compare(=,[C1,N1],[C1,N2]) :-
	equal(N1,N2),!.
color_pair_compare(<,[C1,_],[C1,_]). 


tocolorset([],[]).

tocolorset([[C,N1]|Xs],Ys) :-
	member([C,N2],Xs),
	equal(N1,N2),!,
	tocolorset(Xs,Ys).

tocolorset([X|Xs],[X|Ys]) :-
	tocolorset(Xs,Ys).


				 
new_color_list([],_,[]).
new_color_list([[Id,Color]|RestC],NList,[[Id,[Color,N]]|RestCp]) :-
	member([Id,N],NList),
	new_color_list(RestC,NList,RestCp).
	

computeN([],_,_,[]).
computeN([[Id,_,_,AdjList]|RestAut],Poless,ColorList,[[Id,N]|Ns]) :-
	findall([Color,Tau],(member([Q,Tau],AdjList),qcolor(Q,ColorList,Color)),
		AdjColorPairs),
%	writef("AdjColorPairs=%q\n",[AdjColorPairs]),
	findall([MColor,MTau], (
				 member([MColor,MTau],AdjColorPairs),
				 \+ (
				      member([Color,Tau],AdjColorPairs),
				      \+ (Color=MColor,MTau=Tau),
				      i_dominates([Color,Tau],[MColor,MTau],Poless))
			       ), N),
	computeN(RestAut,Poless,ColorList,Ns).


% i_dominates_nlist(NListp,NList)
% true if all members of NList are dominated by some element
% of NListp
i_dominates_nlist(NListp,NList,Poless) :-  
	
	\+ (
	     member([C,T],NList),
	     \+ (
		  member([Cp,S],NListp),
		  i_dominates([Cp,S],[C,T],Poless)
		)
	   ).
	

i_dominates([Color1,Sigma],[Color2,Tau],Poless) :-
	member([Color2,Color1,1],Poless), % Color2<=Color1
	subset(Sigma,Tau).

qcolor(Q,ColorList,Color) :-
	member([Q,Color],ColorList).

init_colors(Aut,ColorList) :-
	findall([Id,Color],
		(member([Id,IsFinal,_,_],Aut),
		    (IsFinal=1 -> Color=1;Color=2)),ColorList).


exp_new1(or(Psi1,_),[Psi1]).
exp_new1(until(Psi1,_),[Psi1]).
exp_new1(release(_,Psi2),[Psi2]).

exp_new2(or(_,Psi2),[Psi2]).
exp_new2(until(_,Psi2),[Psi2]).
exp_new2(release(Psi1,Psi2),[or(Psi1,final),Psi2]).

exp_next(or(_,_),[]).
exp_next(until(Psi1,Psi2),[until(Psi1,Psi2)]).
exp_next(release(Psi1,Psi2),[release(Psi1,Psi2)]).



% Predicates for comparing sets that may contain sets as elements

equal(A,B) :-
	is_list(A),
	is_list(B),!,
	equal_set(A,B).

equal(A,B) :- A=B.


equal_set(A,B) :-
	mysubset(A,B),
	mysubset(B,A).

mysubset([],_).
mysubset([A|As],B) :-
	member_set(A,B),
	mysubset(As,B).

member_set(A,[D|Ds]) :-
	equal(A,D);member_set(A,Ds).

