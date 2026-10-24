% -*- coding: utf-8; mode: trale-prolog -*-
% Generic correlated inflection tables and stem selection.
% Grammar data: suffix_table(Kind,Name,Fields,Description,Rows).
% Grammar callback: morphology_stem(Affix,Stems,Selected).
:- multifile (fun)/1, (if)/2, suffix_table/5, morphology_stem/3.

fun suffix_choices(-,+).
suffix_choices(Affix,Key) if prolog(suffix_choices_native(Affix,Key)).

:- dynamic suffix_join_cache/2.
:- retractall(suffix_join_cache(_,_)).

suffix_choices_native(Affix,Key) :-
  get_type(Key,a_ Name),suffix_table(_,Name,Fields,Description,Rows),
  add_to(Description,Affix),
  suffix_field_nodes(Fields,Affix,Nodes),suffix_watch(Nodes,Rows).
suffix_field_nodes([],_,[]).
suffix_field_nodes([F|Fs],Affix,[Node|Ns]) :-
  Desc=..[':',F,Node],add_to(Desc,Affix),suffix_field_nodes(Fs,Affix,Ns).
suffix_node_types([],[]).
suffix_node_types([N|Ns],[T|Ts]) :-
  get_type(N,T0),(T0==0->T=bot;T=T0),suffix_node_types(Ns,Ts).
suffix_watch(Nodes,Rows) :-
  suffix_node_types(Nodes,Before),suffix_possible_rows(Rows,Before,Possible),
  Possible=[_|_],
  (suffix_covered(Possible,Before) -> true
  ;suffix_refine(Nodes,Possible),suffix_node_types(Nodes,After),
   (Before\==After -> suffix_watch(Nodes,Possible)
   ;suffix_wait_nodes(Nodes,Conditions),Conditions=[_|_],
    suffix_wait_condition(Conditions,Condition),
    when(Condition,suffix_watch(Nodes,Possible)))).
suffix_possible_rows([],_,[]).
suffix_possible_rows([R|Rs],Types,Out) :-
  (suffix_compatible(R,Types)->Out=[R|Tail];Out=Tail),
  suffix_possible_rows(Rs,Types,Tail).
suffix_compatible([],[]).
suffix_compatible([R|Rs],[T|Ts]) :-
  unify_type(R,T,_),suffix_compatible(Rs,Ts).
suffix_covered([R|_],Types) :- suffix_row_covers(R,Types),!.
suffix_covered([_|Rs],Types) :- suffix_covered(Rs,Types).
suffix_row_covers([],[]).
suffix_row_covers([R|Rs],[T|Ts]) :- sub_type(R,T),suffix_row_covers(Rs,Ts).
suffix_refine([], _).
suffix_refine([N|Ns],Rows) :-
  suffix_column(Rows,Column,Rest),sort(Column,Types),suffix_join(Types,Join),
  add_to(Join,N),suffix_refine(Ns,Rest).
suffix_column([],[],[]).
suffix_column([[X|Xs]|Rows],[X|Column],[Xs|Rest]) :- suffix_column(Rows,Column,Rest).
suffix_join([T],T) :- !.
suffix_join(Types,Join) :- suffix_join_cache(Types,Join),!.
suffix_join(Types,Join) :-
  findall(S,(type(S),atomic(S),suffix_all_subtypes(Types,S)),Candidates),
  member(Join,Candidates),
  \+ (member(More,Candidates),More\==Join,sub_type(Join,More)),!,
  assertz(suffix_join_cache(Types,Join)).
suffix_all_subtypes([],_).
suffix_all_subtypes([T|Ts],S) :- sub_type(S,T),suffix_all_subtypes(Ts,S).
suffix_wait_nodes([],[]).
suffix_wait_nodes([N|Ns],Out) :-
  deref(N,TFS,_,_),functor(TFS,_,Arity),arg(Arity,TFS,Int),
  (var(Int)->Out=[nonvar(Int)|Tail];Out=Tail),suffix_wait_nodes(Ns,Tail).
suffix_wait_condition([C],C) :- !.
suffix_wait_condition([C|Cs],(C;Rest)) :- suffix_wait_condition(Cs,Rest).

% Test the old stem rules only on complete table rows. A common stem does not
% force an unnecessary choice of agreement or mood. Different stems stay apart.
suffix_stem_choice(Affix,VStems,Stem) :-
  findall(S-Fields-Row,
    (suffix_table(fin,_,Fields,Description,Rows),member(Row,Rows),
     copyFS(Affix-VStems,A-V),add_to(Description,A),
     suffix_field_nodes(Fields,A,Nodes),suffix_assign_row(Nodes,Row),
     morphology_stem(A,V,Chosen),get_type(Chosen,a_ S),ground(S)),
    Found),sort(Found,Choices),Choices=[_|_],
  findall(S,member(S-_-_,Choices),Stems0),sort(Stems0,Stems),
  member(Selected,Stems),
  % Even a unique stem may exclude rows for which no stem can be derived.
  suffix_choice_fields(Selected,Choices,Fields),
  findall(Row,member(Selected-Fields-Row,Choices),Rows),
  suffix_field_nodes(Fields,Affix,Nodes),suffix_watch(Nodes,Rows),
  add_to(a_ Selected,Stem).
suffix_assign_row([],[]).
suffix_assign_row([N|Ns],[T|Ts]) :- add_to(T,N),suffix_assign_row(Ns,Ts).
suffix_choice_fields(S,[S-F-_|_],F) :- !.
suffix_choice_fields(S,[_|Xs],F) :- suffix_choice_fields(S,Xs,F).
