% -*- coding: utf-8; mode: trale-prolog -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexrules.pl,v $
%%  $Revision: 1.19 $
%%      $Date: 2007/09/12 14:57:26 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile if/2.
:- discontiguous if/2.
:- multifile fun/1.
:- discontiguous fun/1.
:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile lex_rule/2.
:- discontiguous lex_rule/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.

:- lex_rule_depth(5).


/*

verb_movement_lr *>
( %complex_word
  %optionally_coherent_word
  synsem:(loc:cat:(head:(verb,
                         subj:Subj),
                   comps:hd:loc:cat:head:dsl:Loc),
          nonloc:Nonloc,
          trace:Trace,
          lex:Lex),
  inf_marking:Zu,
  dtrs:[( word,
          synsem:(loc:(Loc,
                       cat:head:(verb,
                                 subj:Subj,
                                 initial:minus)),
                  nonloc:Nonloc,
                  trace:Trace,
                  lex:Lex),
          inf_marking:Zu)]).


verb_initial_lr *>
( %verb_movement_lr
  %complementizer_like_word
  synsem:loc:cat:head:(vform:fin,
                       subj:[]),
  dtrs:[ synsem:loc:cat:head:vform:fin ]).


% Sätze mit Verb in Erststellung können Imperativsätze oder auch Interrogativsätze sein.
% Die beiden folgenden Sätze unterscheiden sich nur hinsichtlich ihrer Flexion:
%
%     Gib   Du mir das Buch!
%     Gibst Du mir das Buch?
%
% Die genaue Auflösung der Relation erfolgt erst in der Grammatik für Kapitel 16,
% da dort erst eine Morphologiekomponente eingeführt wird.

% Konditionalsätze werden ignoriert.


(verb_initial_lr,
 synsem:loc:cat:comps:[nonloc:slash:[]])      *> synsem:loc:cont:nucleus:imperative_or_interrogative.

% Hier spielt das Element in SLASH eine entscheidende Rolle.
% Ist es eine Interrogativphrase, muß ein entsprechender Operator angenommen
% werden. Da die vorliegende Grammatik keine Interrogativpronomina enthält,
% wird die Fallunterscheidung nicht gemacht.

% Er gibt ihm das Buch.
% Jetzt gib mir schon das Buch!
(verb_initial_lr,
 synsem:loc:cat:comps:[nonloc:slash:ne_list]) *> synsem:loc:cont:nucleus:assertion_or_imperative.

% pres_imp = imp in der kombinerten Tense-Modus-Hierarchie
(s_type,
 arg3:pres_imp) *> imperative.

(s_type,
 arg3:ind_conj) *> assertion_or_interrogative.


verb_initial_lr lex_rule
  Dtr
**>
( verb_initial_lr,
  dtrs:[Dtr])
morphs
  X becomes X.

*/

infl_lr *>
  (affix:fk:FK,
   dtr:infl:fk:FK).


% Nomina und Verben haben morphophonologische Merkmale,
% die mit dem Affix übereinstimmen müssen.
n_v_infl_lr *>
  (%infl_lr,
   affix:(Affix,
          morphophon:Morphophon),
   dtr:infl:(morphophon:Morphophon,
               affix_:Affix)).           % Das wird theoretisch nicht gebraucht.
                                          % Es ist nur hier, da die relationalen Beschränkungen an LRen
                                          % nur auf den Input der Regel zugreifen können.
                                          % Deshalb reicht es nicht, Information im Output zu haben.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flexionsregel für finite Verben

relational_lr *>
( %relational_lr & cannonical_complex_word.
  rels:tl:Rels,
  hcons:HCons,
  dtr:(rels:Rels,
       hcons:HCons)).


fin_verb_infl_lr *>
( %relational_lr & cannonical_complex_word.
  synsem:(loc:(cat:(head:(verb,
                          initial:minus,
                          dsl:DSL,
                          da:[], % schließt Kombination von von-Phrase mit finiten Verben aus.
                          subj:[],
                          vform:fin),
                    spr:Spr,
                    comps:Comps,
                    arg_st:ArgSt),
               cont:(ltop:TenseLTop,
                     ind:Event)),
          nonloc:Nonloc,
          trace:Trace,
          lex:Lex),
  v2:V2,
  rels:[(%temo,
         lbl:TenseLTop,
         arg0:Event,
         arg3:LTop)|Rels],
  hcons:HCons,
  inf_marking:minus,
  dtr:( stem,
          synsem:(loc:(cat:(head:(vform:fin,
                                  initial:minus,
                                  dsl:DSL),
                            spr:Spr,
                            comps:Comps,
                            arg_st:ArgSt),
                       cont:(ltop:LTop,
                             ind:Event)),
                  nonloc:Nonloc,
                  trace:Trace,
                  lex:Lex),
          v2:V2,
          rels:Rels,
          hcons:HCons)).

reg_fin_verb_infl_lr *>
( %fin_verb_infl_lr,
  %n_v_infl_lr,
  synsem:loc:cat:arg_st:subj_verb_agreement(Per,Num),
  rels:hd:TeMo,
  affix:(verb_i_suffix,
         per:Per,
         num:Num,
         temo:TeMo)).

% Untertypen sind die irreg_fin_verb_infl_lr und irreg_bse_or_inf_verb_infl_lr
irreg_infl_lr *>
 (phon:Phon,
  dtr:phon:Phon).


fin_verb_infl_lr lex_rule
( stem,
  infl:(v_stems:VStems,
        affix_:(Affix,
                fin_verb_i_suffix, % Das muß hier auch maximal spezifisch sein, da die Typinferenz, die
                                              % aus dem Vorhandensein von NUM und PER auf die Finitheit schließt,
                                              % erst angewendet wird, wenn die linke Regelseite angeguckt wird.
                phon:[(a_ AffixPhon)])),
  Dtr
) 
 **>
( reg_fin_verb_infl_lr,
%  phon:[a_ lacht],
  dtr:Dtr)
if get_irreg_v_stem(Affix,VStems,a_ IStem) 
morphs
  X becomes (X,AffixPhon) when IStem = none,
  X becomes (IStem,AffixPhon).

non_relational_lr *>
  (synsem:loc:cont:Cont,
   rels:Rels,
   hcons:HCons,
   dtr:(synsem:loc:cont:Cont,
        rels:Rels,
        hcons:HCons)).


% Der Ersatzinfinitiv hat eine VFORM (ppp), die vom Input (bse) abweicht.
non_fin_verb_infl_lr *> 
 (%non_relational_lr
  synsem:(loc:cat:(head:(verb,
                         da:DA,
                         initial:(Initial,
                                  minus),
     %                    vform:VForm,
                         auxf:AuxF,
                         mod:Mod,
                         dsl:none, % für die zyklische Verbspur
                         flip:Flip),
                   spr:Spr),
          nonloc:Nonloc,
          lex:Lex,
          trace:Trace),
  dtr:(stem,
       synsem:(loc:cat:(head:(verb,
                              da:DA,
                              initial:Initial,
%                              vform:VForm,
                              auxf:AuxF,
                              mod:Mod,
                              flip:Flip),
                        spr:Spr),
               nonloc:Nonloc,
               lex:Lex,
               trace:Trace)) ).

reg_non_fin_verb_infl_lr *> 
 (%non_relational_lr
  synsem:loc:cat:head:vform:VForm,
  dtr:synsem:loc:cat:head:vform:VForm).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flexionsregel für Infinitive und Partizipien.
% Das Subjekt wird unter SUBJ repräsentiert.
% COMPS ist mit de rverkürzten ARG-ST identisch.
% Infinitive blocken das Subjekt, Partizipien das DA.

% ARG-ST is copied over, the ARP applies.
% Könnte im ARP gemacht werden, wenn da richtig geguckt wird, was das Subjekt ist.
bse_or_inf_verb_infl_lr *> 
 (%cannonical_complex_word & non_fin_verb_infl_lr
  synsem:loc:cat:(head:subj:Subj,
                  comps:block_subject(NewArgSt,Subj),
                  arg_st:(NewArgSt,
                          append(add_optional_passive_pp(DA),ArgSt))),
  dtr:synsem:loc:cat:(head:da:DA,
                      arg_st:ArgSt)).


reg_bse_or_inf_verb_infl_lr *>
 (%bse_or_inf_verb_infl_lr,
  %n_v_infl_lr,
  affix:(verb_i_suffix,
         per:first,
         num:pl,
         temo:pres_ind)).

bse_verb_infl_lr *>
 (%bse_or_inf_verb_infl_lr
  synsem:loc:cat:head:vform:bse,
  inf_marking:minus).


% Infinitive sind fast identisch. Das Ergebniszeichen ist aber vom
% Type zu_word. Dieser kann in keiner Grammatikregel vorkommen, außer
% in einer Regel, die `zu' mit dem Wort kombiniert.
inf_verb_infl_lr *>
 (%bse_or_inf_verb_infl_lr
  synsem:loc:cat:head:vform:inf,
  inf_marking:plus).

ppp_verb_infl_lr *>
 (%non_fin_verb_infl_lr & noncannonical_complex_word.
  synsem:loc:cat:head:vform:ppp,
  inf_marking:minus).

bse_verb_infl_lr lex_rule
 (infl:affix_:(verb_i_suffix,             % Muß hier alles noch mal erwähnt werden, da nur der LR-Input berücksichtigt wird.
               phon:[(a_ AffixPhon)],
               per:first,
               num:pl,
               temo:pres_ind),
  Dtr)
 **>
( reg_bse_verb_infl_lr,
  dtr:Dtr
  )
morphs
  X becomes (X,AffixPhon).

inf_verb_infl_lr lex_rule
 (infl:affix_:(verb_i_suffix,
               phon:[(a_ AffixPhon)],
               per:first,
               num:pl,
               temo:pres_ind),
  Dtr)
 **>
( reg_inf_verb_infl_lr,
  dtr:Dtr)
morphs
  X becomes (X,AffixPhon).


ppp_verb_infl_lr *>
( % non_fin_verb_infl_lr & noncannonical_complex_word
  % ARP wird nicht angewendet. SUBJ ist nicht auf der ARG-ST-Liste.
  synsem:loc:cat:(head:(subj:DA,
                        da:DA),
                  comps:Comps,
                  arg_st:(Comps,
                          add_optional_passive_pp_after_verb(DA,block_da(DA,ArgSt)))),
  dtr:synsem:loc:cat:arg_st:ArgSt).

fun add_optional_passive_pp_after_verb(+,+,-).
add_optional_passive_pp_after_verb(DA,List,Result) if
  when(List=(e_list;ne_list),
       passive_pp_list(DA,List,Result)).

passive_pp_list(DA,[],Result) if
  add_optional_passive_pp(DA,Result).

passive_pp_list(DA,[H|T],Result) if
  when(H=arg:loc:cat:head:(verb;adj;adv;comp;noun;prep),
       passive_pp_head(DA,H,T,Result)).

% Die ARG-ST-Liste ist leer. Es wird PP angehängt, oder nicht.
undelayed_add_optional_passive_pp_after_verb(DA,[],Result) if
  add_optional_passive_pp(DA,Result).

% Wenn das letzte Argument ein Verb ist, füge die PP nach dem Verb ein.
passive_pp_head(DA,(VerbArg,
                    arg:loc:cat:head:verb),T,Result) if
  add_optional_passive_pp(DA,PPList),
  append([VerbArg|PPList],T,Result).

% Wenn es kein Verb ist, füge die PP vorne an, wenn es eine gibt.
passive_pp_head(DA,(NoVerbArg,
                    arg:loc:cat:head:(adj;adv;comp;noun;prep)),T,Result) if 
  add_optional_passive_pp(DA,PPList),
  append(PPList,[NoVerbArg|T],Result).


fun add_optional_passive_pp(+,-).
add_optional_passive_pp(DA,List) if
  when( (DA=(e_list;ne_list)),
         undelayed_add_optional_passive_pp(DA,List) ).

undelayed_add_optional_passive_pp([],[]) if true.
undelayed_add_optional_passive_pp([arg:loc:cont:ind:Ind],[@optional_passive_pp(Ind)]) if true.


ppp_verb_infl_lr lex_rule
  (infl:(v_stems:part:(a_ IStem),
         bet1:Bet),
   Dtr)
  **>
( reg_ppp_verb_infl_lr,
  affix:(ppp_verb_i_suffix,
         phon:[(a_ Suff)]),
  dtr:Dtr)
if
   (get_prefix(Bet,Ge),
    Ge=(a_ GeP))
morphs
  X becomes (GeP,X,Suff) when IStem = none,
  X becomes (GeP,IStem,Suff).


fun list_of_blocked_arguments(-).
list_of_blocked_arguments(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_blocked_arguments(L) ).

undelayed_list_of_blocked_arguments([]) if true.
undelayed_list_of_blocked_arguments([@blocked_np_ref|T]) if
   list_of_blocked_arguments(T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Pränominale Partizipien (`geliebte' und `zu lesende')
%
%
%
part_derivation_lr *>
 (%derived_stem & isect_modifier
  synsem:(loc:cat:head:(attr_participle,         % kann nicht prädikativ genutzt werden,
                                                 % dafür sollte es eine prinzipiellere Erklärung geben.
                        subj:[@pro_np_str]),     % ist str: * der gegraute Mann
          nonloc:Nonloc,
          lex:Lex,
          trace:Trace),
  inf_marking:Zu,
  dtr:(word,
       synsem:(loc:cat:head:(verb,
                             flip:minus % schließt Ersatzinfinitive aus * `wollene' statt `gewollte'
                            ),    
               nonloc:Nonloc,
               lex:Lex,
               trace:Trace),
       inf_marking:Zu)).

% der von allen zu lesende Aufsatz
% der von allen gelesene Aufsatz
inf_or_ppp_part_derivation_lr *>
 (%part_derivation_lr
  synsem:loc:cat:head:da:(raise(DA),
                          list_of_blocked_arguments),
  dtr:synsem:loc:cat:head:da:DA). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Partizip II
%
% geliebt (V) -> geliebt (A)
%
% DA ist verfügbar für von-PP
%
% der von allen geleiebte Affe
%
% Flexionsregel erzeugt dann: geliebt (A) -> geliebte
%
ppp_part_derivation_lr *>
 (%inf_or_ppp_part_derivation_lr & non_relational_lr
  inf_marking:Zu,
  dtr: (synsem:loc:cat:head:vform:ppp,
           inf_marking:Zu)).

ppp_part_derivation_lr *>
  (%part_derivation_lr & non_relational_lr
   synsem:loc:cat:arg_st:ArgSt,   % unveränderte ARG-ST muss nicht angehoben werden.
   dtr:synsem:loc:cat:arg_st:ArgSt).


ppp_part_derivation_lr lex_rule
  Dtr
 **>
( ppp_part_derivation_lr,
  dtr:Dtr
  )
morphs
  X becomes X.



% * der zu gelingende Aufsatz
% der zu lesende Aufsatz
inf_part_derivation_lr *>
 (%inf_or_ppp_part_derivation_lr & relational_lr
  rels:hd:(modal_rel,
           arg3:VLTop),
  dtr:synsem:loc:(cat:head:vform:inf,
                  cont:ltop:VLTop)).

% der zu lesende Aufsatz
inf_part_derivation_lr *>
  (%inf_or_ppp_part_derivation_lr & relational_lr
   synsem:loc:cat:arg_st:raise(ArgSt), % Die Elemente auf COMPS gehören ja zu einem (zu)
                                                % Infinitiv. Wenn wir die einfach übernehmen
                                                % würden, wären sie teil einer größeren ARG-ST und würden dort anderen Kasus bekommen.
   dtr:synsem:loc:cat:comps:ArgSt).

% der den Aufsatz lesende Affe
bse_part_derivation_lr *>
  (%part_derivation_lr & non_relational_lr
   synsem:loc:cat:(head:da:[],
                   arg_st:raise(ArgSt)), % Die Elemente auf COMPS gehören ja zu einem (zu)
                                                % Infinitiv. Wenn wir die einfach übernehmen
                                                % würden, wären sie teil einer größeren ARG-ST und würden dort anderen Kasus bekommen.
      
   % Die dtr:dtr-Sache war Codex' Idee. Das ist nicht lokal, also eigentlich nicht üblich.  Aber im
   % vorigen Ableitungsschritt wird die optionale PP ergänzt. Das wäre zwar nicht falsch, denn
   % doppelte Benutzung von Quantoren wird von Utool erkannt, aber es ist trotzdem syntaktisch
   % unsinnig für die aktiven Partizipiel eine von-PP auf der liste zu haben. Das betrifft wirklich
   % nur das Partizip mit -d ohne zu. ge-Partizip und zu-Form können mit von-PP vorkommen. St. Mü. 17.10.2026
   dtr:dtr:synsem:loc:cat:arg_st:ArgSt,
   dtr:synsem:loc:cat:arg_st:hd:raised:minus). % Residuum der von-PP check mit komplexbildenden Verben

inf_part_derivation_lr lex_rule
  Dtr
 **>
( inf_part_derivation_lr,
  dtr:Dtr
  )
morphs
  X becomes (X,d).


% der das Buch lesende Mann
bse_part_derivation_lr *>
 (%part_derivation_lr & non_relational_lr
  dtr:synsem:loc:cat:head:vform:bse).

bse_part_derivation_lr lex_rule
  Dtr
 **>
( bse_part_derivation_lr,
  dtr:Dtr
  )
morphs
  X becomes (X,d).

% for islands 
non_move_synsem :=
  (nonloc:(slash:[],
           rel:[])).

fun list_of_non_move_arguments(-).
list_of_non_move_arguments(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_move_arguments(L) ).

undelayed_list_of_non_move_arguments([]) if true.
undelayed_list_of_non_move_arguments([arg: @non_move_synsem|T]) if
   list_of_non_move_arguments(T).


% Es muss ein Subjekt geben und es muss referentiell sein. Ansonsten können die Adjektive nicht attributiv genutzt werden.
% weil offen ist
% weil es laut ist
% weil mir schlecht ist
attr_adj_infl_lr *>
(%infl_lr & non_relational_lr & spr_saturated_le & cannonical_complex_word
 synsem:(loc:cat:(head:(Head,
                        mod:(@nbar(Ind),
                             loc:cat:spr:[arg:loc:cat:head:(case:morph_case:Case,
                                                            gen:Genus,
                                                            num:Num,
                                                            dtype:DType)]),
                        subj:[@pro_np(Ind)]),
                  arg_st:(ArgSt,
                          list_of_non_raised_arguments,
                          list_of_non_move_arguments)), % aus dem pränominalen Bereich kann nichts extrahiert werden
                                                        % Relativpronomina sind hier ebenfalls nicht möglich.
         nonloc:Nonloc,
         lex:Lex,
         trace:Trace),
 inf_marking:Zu,
 affix:(attr_adj_i_suffix,
        dtype:DType,
        num:Num,
        gen:Genus,
        morph_case:Case),
 dtr:(synsem:(loc:cat:(head:Head,
                       arg_st:ArgSt),
              nonloc:Nonloc,
              lex:Lex,
              trace:Trace),
      inf_marking:Zu)).


attr_adj_infl_lr lex_rule
 Dtr
**>
(attr_adj_infl_lr,
 affix:phon:[(a_ Suffix)],
 dtr:Dtr)
morphs
  X becomes (X,Suffix).


/*

isect_attr_adj_infl_lr *>
  (synsem:loc:cont:nucleus:restr:hd:Cont,
   dtrs:[synsem:loc:cont:nucleus:(@not(psoa_rel),
                                  Cont)]).

scopal_attr_adj_infl_lr *>
  (synsem:loc:cont:nucleus:restr:[Cont],
   dtrs:[synsem:loc:cont:nucleus:(psoa_rel,
                                  Cont)]).

*/

/*

prd_adj_infl_lr *>
(%complex_word,
 synsem:(loc:(cat:(head:(Head,
                         mod:none,
                         prd:plus),
                   subcat:Subcat),
              cont:Cont),
         nonloc:Nonloc,
         lex:Lex,
         trace:Trace),
 inf_marking:Zu,
 dtrs:[(stem,
        synsem:(loc:(cat:(head:(Head,
                                adj),
                          subcat:Subcat),
                     cont:Cont),
                nonloc:Nonloc,
                lex:Lex,
                trace:Trace),
        inf_marking:Zu)]
 ).

prd_adj_infl_lr lex_rule
  Dtr
 **>
( prd_adj_infl_lr,
  dtrs:[Dtr])
morphs
  X becomes X.
*/



get_prefix(plus, (a_ [g,e])) if true.
get_prefix(minus,(a_ [])   ) if true.




%fun get_irreg_v_stem(-,+,+).

get_irreg_v_stem((Affix,
                  phon:Phon),VStems,IrregStem) if
  when(Phon=(e_list;ne_list)
       ,undelayed_get_irreg_v_stem(Affix,VStems,IrregStem)).


%netter_get_irreg_v_stem(_Affix,VStems,_)  if prolog((write(VStems),nl)),fail.

netter_get_irreg_v_stem((temo:pres_ind_conj),                (pres2:(a_ none)),     (a_ none    ))  if !,true.

% ich fange, du fängst, er fängt
% ich habe, du hast, er hat
netter_get_irreg_v_stem((fk:(v_strong;mixed;v_weak),
                            temo:pres_ind, per:second_or_third,num:sg),(pres2:(a_ Pres2Stem)),(a_ Pres2Stem)) if !,true.


netter_get_irreg_v_stem((fk:(v_strong;mixed;v_weak),
                            temo:pres_imp),                     (imp_st:(a_ Pres2Stem)),(a_ Pres2Stem)) if !,true.

% Ich darf, du darfst, er darf, wir dürfen, ihr dürft, sie dürfen
% the irregular stem in sg:
netter_get_irreg_v_stem((fk:modal,
                            temo:pres_ind,
                            num:sg),                            (pres2:(a_ Pres2Stem)),(a_ Pres2Stem)) if !,true.


netter_get_irreg_v_stem((temo:pres_conj,per:second_or_third,num:sg),_,     (a_ none    ))  if !,true.

% ich fange, ich habe
netter_get_irreg_v_stem((fk:(v_strong;mixed),
                            temo:pres_ind_conj,per:first,num:sg),      _,                     (a_ none    ))  if !,true.


% versuchtest
netter_get_irreg_v_stem((temo:past_ind_conj),                (past:(a_ none),
                                                                 conj:(a_ none)),      (a_ none    ))  if !,true.

% ich fing, ..., ich durfte, ...
netter_get_irreg_v_stem((temo:past_ind),                     (past:(a_ PastStem)),  (a_ PastStem))  if !,true.

% If a conj stem is definied, take it, otherwise return the past stem.
% kommen, kam, käme
% fangen, fing, finge
netter_get_irreg_v_stem((temo:past_conj),                    (conj:(a_ ConjStem)),  (a_ ConjStem))  if !,prolog(ConjStem\=none).
netter_get_irreg_v_stem((temo:past_conj),                    (past:(a_ ConjStem)),  (a_ ConjStem))  if !,prolog(ConjStem=none).


netter_get_irreg_v_stem(_,          _,                     (a_ none    ))  if true.




% Avoid selecting a person/number/mood when all compatible rows use one stem.
undelayed_get_irreg_v_stem(Affix,VStems,Stem) if
  prolog(suffix_stem_choice(Affix,VStems,Stem)).

% Grammar-specific ordered stem rules used by the generic morphology helper.
:- multifile morphology_stem/3.
morphology_stem(Affix,Stems,Selected) :-
  fs_netter_get_irreg_v_stem(Affix,Stems,Selected),
  % An unspecified alternative stem permits the regular stem (none).
  % This callback is evaluated on a private copy by morphology.pl.
  get_type(Selected,a_ Value),(var(Value) -> Value=none ; true).
