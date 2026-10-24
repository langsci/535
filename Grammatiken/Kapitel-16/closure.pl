% -*- coding: utf-8; mode: trale-prolog -*-

% This code was written by Codex GPT 6.1-sol with prompts by Stefan Müller
%
% Grammar-owned closure; no Prolog hooks or external index-selection code.
% =@ is TRALE's nonbinding identity test. Run only on a completed analysis.
:- multifile fun/1,if/2,'*>'/2,'--->'/2,':='/2.
:- discontiguous fun/1,if/2,'*>'/2.

% Personal pronouns and possessors are contextually given, not existentially closed.
% For possessives IND is the possessor; SPEC carries the possessed noun index.
word *> (((pers_pronoun;possessive),synsem:loc:cont:ind:I,ec_protected:[I]);
          (@not(pers_pronoun),@not(possessive),ec_protected:[])).
trace *> ec_protected:[].
empty *> ec_protected:[].
phrase *> (dtrs:Dtrs,ec_protected:ec_collect_protected(Dtrs)).

fun ec_collect_protected(+,-).
ec_collect_protected(Dtrs,Protected) if
 when(Dtrs=(e_list;ne_list),ec_collect_protected_list(Dtrs,Protected)).
ec_collect_protected_list([],[]) if true.
ec_collect_protected_list([ec_protected:Own|Rest],append(Own,More)) if
 ec_collect_protected(Rest,More).

% Signal readiness only after the entire list spine is known.
fun ec_closed_list(+,-).
ec_closed_list(List,Ready) if
 when(List=(e_list;ne_list),ec_closed_list_known(List,Ready)).
ec_closed_list_known([],plus) if true.
ec_closed_list_known([_|Rest],Ready) if ec_closed_list(Rest,Ready).

% Extract only actually appropriate roles, without inventing arguments.
fun ec_arg0(+,-).
ec_arg0(Rel,Args) if
 when(Rel=relation,ec_arg0_known(Rel,Args)).
ec_arg0_known(arg0:I,[I]) if true.
ec_arg0_known(@not(arg0_relation),[]) if true.
fun ec_arg1(+,-).
ec_arg1(Rel,Args) if
 when(Rel=relation,ec_arg1_known(Rel,Args)).
ec_arg1_known(arg1:I,[I]) if true.
ec_arg1_known(@not(arg1_relation),[]) if true.
fun ec_arg2(+,-).
ec_arg2(Rel,Args) if
 when(Rel=relation,ec_arg2_known(Rel,Args)).
ec_arg2_known(arg2:I,[I]) if true.
ec_arg2_known(@not(arg2_relation),[]) if true.
fun ec_arg3(+,-).
ec_arg3(Rel,Args) if
 when(Rel=relation,ec_arg3_known(Rel,Args)).
ec_arg3_known(arg3:I,[I]) if true.
ec_arg3_known(@not(arg3_relation),[]) if true.

fun ec_scan(+,-).
ec_scan(Rels,Summary) if
 when(Rels=(e_list;ne_list),ec_scan_list(Rels,Summary)).
ec_scan_list([],(ec_args:[],ec_bound:[])) if true.
ec_scan_list([Rel|Rest],
 (ec_args:append(A1,append(A2,append(A3,MoreArgs))),
  ec_bound:append(OwnBound,MoreBound))) if
 ec_arg0(Rel,OwnBound),ec_arg1(Rel,A1),ec_arg2(Rel,A2),ec_arg3(Rel,A3),
 ec_scan(Rest,(ec_args:MoreArgs,ec_bound:MoreBound)).

% Unlike ordinary membership this cannot unify two merely compatible indices.
ec_identical_member(I,List) if
 when(List=(e_list;ne_list),ec_identical_member_list(I,List)).
ec_identical_member_list(_,[]) if fail.
ec_identical_member_list(I,[J|Rest]) if
 (I =@ J -> true ; ec_identical_member(I,Rest)).

fun existential_closure(+,+,-).
existential_closure(Rels,Protected,Content) if
 ec_scan(Rels,(ec_args:Args,ec_bound:Introduced)),
 ec_closed_list(Args,ArgsReady),ec_closed_list(Introduced,BoundReady),
 ec_closed_list(Protected,ProtectedReady),
 when((ArgsReady=plus,BoundReady=plus,ProtectedReady=plus),
      ec_close_candidates(Args,append(Introduced,Protected),Content)).

fun ec_close_candidates(+,+,-).
ec_close_candidates(Args,Seen,Content) if
 when(Args=(e_list;ne_list),ec_close_candidates_list(Args,Seen,Content)).
ec_close_candidates_list([],_,(ec_indices:[],rels:[],hcons:[])) if true.
ec_close_candidates_list([I|Rest],Seen,Content) if
 (ec_identical_member(I,Seen)
  -> ec_close_candidates(Rest,Seen,Content)
  ; (\+ \+ (I=ref))
  -> Content=(ec_indices:[I|MoreIndices],
              rels:[(exists_q,arg0:I,rstr:Restr),
                    (ec_trial_entity_rel,lbl:Label,arg0:I)|MoreRels],
              hcons:[(qeq,harg:Restr,larg:Label)|MoreHcons]),
     ec_close_candidates(Rest,[I|Seen],
       (ec_indices:MoreIndices,rels:MoreRels,hcons:MoreHcons))
  ; ec_close_candidates(Rest,Seen,Content)).

% Root status belongs to signs, independently of their schema type.
syntactic_sign *>
 (utterance:U,rels:Rels,ec_protected:Protected,root_cont:Contribution)
 goal when(U=(plus;minus),ec_root_contribution(U,Rels,Protected,Contribution)).

% villeicht dtrs:list *> dtrs:ec_internal_daughters.
phrase *> dtrs:ec_internal_daughters.
verb_movement_rule *> dtrs:ec_internal_daughters.

% lexical rules
dtr:syntactic_sign *> dtr:utterance:minus.

fun ec_internal_daughters(-).
ec_internal_daughters(Dtrs) if
 when(Dtrs=(e_list;ne_list),ec_internal_daughters_list(Dtrs)).
ec_internal_daughters_list([]) if true.
ec_internal_daughters_list([utterance:minus|Rest]) if ec_internal_daughters(Rest).

% called for all syntactic signs. For minus, the values are just empty lists.
% for plus, the existential closure is computed.
ec_root_contribution(minus,_,_,(ec_indices:[],rels:[],hcons:[])) if true.
ec_root_contribution(plus,Rels,Protected,Content) if existential_closure(Rels,Protected,Content).

% Trial realization vocabulary, unchanged from the earlier experiment.
ec_pronoun(Case,Gender,Relation,Sort) :=
 (ec_trial_pronoun,
  synsem:(lex:minus,nonloc:rel:[],
   loc:(cat:(head:case:morph_case:Case,
             spr:[],
             comps:[],
             arg_st:[]),
        cont:(ind:(Ind,
                   per:third,
                   num:sg,
                   gen:Gender,
                   sort:Sort),
              ltop:Label))),
  rels:[(exists_q,arg0:Ind,rstr:Restr),
        (Relation,lbl:Label,arg0:Ind)],
  hcons:[(qeq,harg:Restr,larg:Label)]).

% Jemand hat die Milch getrunken. = Mensch oder Katze
jemand   ---> @ec_pronoun(nom,fem_or_mas,ec_trial_entity_rel,agentive).
jemanden ---> @ec_pronoun(acc,fem_or_mas,ec_trial_entity_rel,agentive).
etwas    ---> @ec_pronoun(nom_or_acc,neu,ec_trial_entity_rel,non_agentive).
