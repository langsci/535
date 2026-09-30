% -*-trale-prolog-*-
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
                   subcat:hd:loc:cat:head:dsl:Loc),
          nonloc:Nonloc,
          trace:Trace,
          lex:Lex),
  zu:Zu,
  dtrs:[( word,
          synsem:(loc:(Loc,
                       cat:head:(verb,
                                 subj:Subj,
                                 initial:minus)),
                  nonloc:Nonloc,
                  trace:Trace,
                  lex:Lex),
          zu:Zu)]).


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
 synsem:loc:cat:subcat:[nonloc:slash:[]])      *> synsem:loc:cont:nucleus:imperative_or_interrogative.

% Hier spielt das Element in SLASH eine entscheidende Rolle.
% Ist es eine Interrogativphrase, muß ein entsprechender Operator angenommen
% werden. Da die vorliegende Grammatik keine Interrogativpronomina enthält,
% wird die Fallunterscheidung nicht gemacht.

% Er gibt ihm das Buch.
% Jetzt gib mir schon das Buch!
(verb_initial_lr,
 synsem:loc:cat:subcat:[nonloc:slash:ne_list]) *> synsem:loc:cont:nucleus:assertion_or_imperative.

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


fin_verb_infl_lr *>
( %complex_word,
  synsem:(loc:(cat:(Cat,
                    head:(verb,
                          initial:minus,
                          subj:[],
                          vform:fin)),
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
  zu:minus,
  dtr:( stem,
          synsem:(loc:(cat:Cat,
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flexionsregel für Infinitive
% Das Subjekt wird aus der SUBCAT-Liste genommen
% und unter SUBJ repräsentiert.

bse_or_inf_verb_infl_lr *> 
 (%complex_word,
  synsem:(loc:(cat:(head:(verb,
                          initial:(Initial,
                                   minus),
                          vform:VForm,
                          subj:Subj,
                          mod:Mod,
                          flip:Flip),
                    spr:Spr,
                    comps:block_subject(ArgSt,Subj),
                    arg_st:ArgSt),
               cont:Cont),
          nonloc:Nonloc,
          lex:Lex,
          trace:Trace),
  rels:Rels,
  hcons:HCons,
  dtr:(stem,
         synsem:(loc:(cat:(head:(verb,
                                 initial:Initial,
                                 vform:VForm,
                                 mod:Mod,
                                 flip:Flip),
                           spr:Spr,
                           comps:_Comps,
                           arg_st:ArgSt),
                      cont:Cont),
                 nonloc:Nonloc,
                 lex:Lex,
                 trace:Trace),
         rels:Rels,
         hcons:HCons) ).

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
  zu:minus).

% Infinitive sind fast identisch. Das Ergebniszeichen ist aber vom
% Type zu_word. Dieser kann in keiner Grammatikregel vorkommen, außer
% in einer Regel, die `zu' mit dem Wort kombiniert.
inf_verb_infl_lr *>
 (%bse_or_inf_verb_infl_lr
  synsem:loc:cat:head:vform:inf,
  zu:plus).



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






%fun get_irreg_v_stem(-,+,+).

get_irreg_v_stem((Affix,
                  phon:Phon),VStems,IrregStem) if
  when(Phon=(e_list;ne_list)
       ,undelayed_get_irreg_v_stem(Affix,VStems,IrregStem)).


%undelayed_get_irreg_v_stem(_Affix,VStems,_)  if prolog((write(VStems),nl)),fail.

undelayed_get_irreg_v_stem((temo:pres_ind_conj),                (pres2:(a_ none)),     (a_ none    ))  if !,true.

% ich fange, du fängst, er fängt
% ich habe, du hast, er hat
undelayed_get_irreg_v_stem((fk:(v_strong;mixed;v_weak),
                            temo:pres_ind, per:second_or_third,num:sg),(pres2:(a_ Pres2Stem)),(a_ Pres2Stem)) if !,true.


undelayed_get_irreg_v_stem((fk:(v_strong;mixed;v_weak),
                            temo:pres_imp),                     (imp_st:(a_ Pres2Stem)),(a_ Pres2Stem)) if !,true.

% Ich darf, du darfst, er darf, wir dürfen, ihr dürft, sie dürfen
% the irregular stem in sg:
undelayed_get_irreg_v_stem((fk:modal,
                            temo:pres_ind,
                            num:sg),                            (pres2:(a_ Pres2Stem)),(a_ Pres2Stem)) if !,true.


undelayed_get_irreg_v_stem((temo:pres_conj,per:second_or_third,num:sg),_,     (a_ none    ))  if !,true.

% ich fange, ich habe
undelayed_get_irreg_v_stem((fk:(v_strong;mixed),
                            temo:pres_ind_conj,per:first,num:sg),      _,                     (a_ none    ))  if !,true.


% versuchtest
undelayed_get_irreg_v_stem((temo:past_ind_conj),                (past:(a_ none),
                                                                 conj:(a_ none)),      (a_ none    ))  if !,true.

% ich fing, ..., ich durfte, ...
undelayed_get_irreg_v_stem((temo:past_ind),                     (past:(a_ PastStem)),  (a_ PastStem))  if !,true.

% If a conj stem is definied, take it, otherwise return the past stem.
% kommen, kam, käme
% fangen, fing, finge
undelayed_get_irreg_v_stem((temo:past_conj),                    (conj:(a_ ConjStem)),  (a_ ConjStem))  if !,prolog(ConjStem\=none).
undelayed_get_irreg_v_stem((temo:past_conj),                    (past:(a_ ConjStem)),  (a_ ConjStem))  if !,prolog(ConjStem=none).


undelayed_get_irreg_v_stem(_,          _,                     (a_ none    ))  if true.



