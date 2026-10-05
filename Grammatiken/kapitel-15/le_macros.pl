% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: le_macros.pl,v $
%%  $Revision: 1.4 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.
:- discontiguous ':='/2.

:- multifile '*>'/2.
:- discontiguous '*>'/2.

:- multifile if/2.
:- discontiguous if/2.

:- multifile fun/1.
:- discontiguous fun/1.

% stems and words
overt_le *>
 (%sign,
  synsem:(nonloc:slash:[],
          trace:minus)).

overt_le *>
 (%sign,
  phon:ne_list).


% normale Wörter selegieren nie DSL:local-Elemente.
% Nur über LR abgeleitete Wörter tun dies.
% Beschränkung wird gebraucht, um die Einbettung einer
% Verbspur unter ein Hilfs- oder Modalverb auszuschließen.
%
% * Der Frau den Aufsatz _v will er.

overt_le *>
  synsem:loc:cat:arg_st:list_of_non_dsl_synsems.

fun list_of_non_dsl_synsems(-).
list_of_non_dsl_synsems(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_dsl_synsems(L) ).

undelayed_list_of_non_dsl_synsems([]) if true.
undelayed_list_of_non_dsl_synsems([loc:cat:head:dsl:none|T]) if
   list_of_non_dsl_synsems(T).


% Nur Verben und adjektivische Partizipien können mit zu kombiniert
% werden. Unflektierte Wörter sind immer ZU-.
% ZU ist nur ein technisches Hilfsmerkmal.
% alle sichtbaren Lexikonelemente außer Lexikonregeln
overt_le *> inf_marking:minus.

non_overt_word *>
  (%empty_rel_word,
   phon:[],
   inf_marking:minus).

trace *>
  synsem:trace:extraction_or_vm.

e_trace *>
 (%trace,
  synsem:(loc:Loc,
          nonloc:slash:[Loc],
          trace:extraction)).

/*
% Die alte zyklische Verbspur. Im Prinzip bräuchte man nicht mal die Information darüber, dass es ein Verb und final ist.
empty
   (trace,
    loc:(Loc,
         cat:head:(verb,
                   initial:minus,
                   dsl:Loc)),
    nonloc:slash:[],
    trace:vm).
*/

v_trace *>
 (%trace,
  %non_slashed_le,
  %spr_saturated_le
  synsem:(loc:(cat:(head:(verb,
                          initial:minus,
                          subj:Subj,
                          dsl:(cat:(head:subj:Subj,
                                    spr:Spr,
                                    comps:Comps,
                                    arg_st:ArgSt),
                               cont:Cont)),
                    spr:Spr,
                    comps:Comps,
                    arg_st:ArgSt),
                 cont:Cont),
            trace:vm)).

empty_determiner *>
  synsem:trace:minus.

empty_rel_sign *>
 (%sign,
  synsem:nonloc:rel:[]).

empty_slash_le *>
 (%sign,
  synsem:nonloc:slash:[]).



rel_pronoun *>
 (%overt_word,
  synsem:(loc:cont:ind:Ind,
          nonloc:rel:[ind:Ind])).

% complementizer_like_sign erbt hiervon.
% V1-Regel und Komplementierer.
spr_saturated_le *>
  synsem:loc:cat:spr:[].

saturated_word *>
 synsem:loc:cat:arg_st:[].

% Für Artikelwörter und das Possessivpronomen.
% Die RELS- und HCONS-Liste ist offen, so dass
% entweder nur die Information über einen Quantor darin
% enthalten sein kann oder aber noch weitere Relationen und HANDLE-Constraints.
determiner_word *>
 (%saturated_word Diese Information steht in der signatur
  synsem:loc:cat:head:(det,
                       spec:loc:cont:(ind:Ind,
                                      ltop:NLTop)),
  rels:hd:(% eine Relation eines Quantors z.B. exists_q
           arg0:Ind,
           rstr:Restr),
  hcons:[(qeq,
          harg:Restr,
          larg:NLTop)]).

determiner(Numerus,DType) :=
 (synsem:loc:cat:head:(num:Numerus,
                       dtype:DType)).

determiner(Case,Numerus,Genus,DType) :=
(%determiner_word,
 @determiner(Numerus,DType),
 synsem:loc:cat:head:(case:morph_case:Case,
                      gen:Genus)).

% Genau ein Element in der RELS- und HCONS-Liste.
% Ließe sich mit rels:tl:e_liste effizienter aufschreiben. Aber weniger lesbar.
determiner *> 
 (%determiner_word
  rels:[_]).

% leerer Determinator und overte Determinatoren
det(Numerus,DType,Quant) :=
 (@determiner(Numerus,DType),
  rels:hd:Quant).

% Determinatoren mit Genus
det(Case,Numerus,Genus,DType,Quant) :=
(@determiner(Case,Numerus,Genus,DType),
 overt_determiner,
 @det(Numerus,DType,Quant)).

% Determinatoren ohne Genus
det(Case,Numerus,DType,Quant) :=
  @det(Case,Numerus,genus,DType,Quant).

% Sowohl für normale Possessiva als auch für possessive Relativpronomina.
possessive *>
 (%determiner_word
  synsem:loc:(cat:head:spec:loc:cont:ind:Ind2,
              cont:(ind:Ind,
                    ltop:LTop)),
  rels:[def_q,
        (poss_rel,
            lbl:LTop,
            arg0:event,
            arg1:Ind,
            arg2:Ind2)]).

% sein Affe: Der LTOP ist mit dem LTOP des Nomens identisch.  Bei possessiven Relativpronomina wie
% in Der Affe, dessen Kind schläft, lacht.  wird der LTOP-Wert nicht mit dem des Nomens
% identifiziert, sondern mit dem des Relativsatzes und dann mit dem des modifizierten Nomens. Siehe unten.
% Idee aus ERG 2025-04-04
simple_possessive *>
 (%possessive,
  synsem:loc:(cat:head:spec:loc:cont:ltop:NLTop,
              cont:ltop:NLTop)).
 

possessive(Case,Person,Numerus,Genus,NNumerus,NGenus,DType) :=
 (@determiner(Case,NNumerus,NGenus,DType),
  simple_possessive,
  synsem:loc:cont:ind:(per:Person,
                       num:Numerus,
                       gen:Genus)).


% Die folgenden XP-Makros werden als Abkürzung in Valenzrahmen
% verwendet.

xp :=
  (loc:cat:(spr:[],
            comps:[])).

% kennen, helfen, denken an
xp(Ind) :=
  (@xp,
   loc:cont:ind:Ind).

np :=
  (@xp,
   loc:cat:head:noun).

% Eine NP mit strukturellem Kasus
np_str :=
  (@np,
   loc:cat:head:case:case_type:str).

np_lex :=
  (@np,
   loc:cat:head:case:case_type:lex).


np_str(Ind) :=
  (@np_str,
   loc:cont:ind:Ind).

np_str(Per,Num) :=
  (@np_str,
   loc:cont:ind:(per:Per,
                 num:Num)).

lex(Case) :=
 (case_type:lex,
  morph_case:Case).

np(Ind) :=
  (@np,
   loc:cont:ind:Ind).

np(Case,Ind) :=
  (@np(Ind),
   loc:cat:head:case: @lex(Case)).


np_(Per,Num) :=
 (@np,
  loc:cont:ind:(per:Per,
                num:Num)).

no_noun :=
  (loc:cat:head: @not(noun)).

nbar :=
  (loc:cat:(head:noun,
            spr:[_],
            comps:[])).

nbar(Ind) :=
  (@nbar,
   loc:cont:ind:Ind).

pp :=
  (@xp,
   loc:cat:head:prep).

pp(Ind) :=
  (@pp,
   loc:(cat:head:prep,
        cont:ind:Ind)).

pp(PForm,Case) :=
  (@pp,
   loc:cat:head:(pform:PForm,
                 case:morph_case:Case)).

pp(PForm,Case,Ind) :=
  (@pp(PForm,Case),
   loc:cont:ind:Ind).

non_scopal_le *>
  hcons:[].

% expletives and markers
non_relational_le *>
  rels:[].

% complement prepositions and some complementizers.
transparent_head_le *>
 synsem:loc:(cat:arg_st:[loc:cont:(ind:Ind,
                                   ltop:LTop) ],
             cont:(ind:Ind,
                   ltop:LTop)).


arg0_le *>
  (synsem:loc:cont:ind:Ind,
   rels:hd:arg0:Ind).

ltop_lbl_le *>
  (synsem:loc:cont:ltop:Lbl,
   rels:hd:lbl:Lbl).

% alle Nomina
noun_word *>
 (%word
  synsem:loc:cat:head:(noun,
                       initial:plus)).

% Nomen mit Determinator
det_noun_word *>
(%noun_word,
  %non_scopal_le
  %relational_arg0_word,  % enthält auch lbl:LTop
  synsem:loc:(cat:(head:case:Case,
                   spr:[_],
                                % Das letzte Element der ARG-ST-Liste ist der Determinator.
                   arg_st:last(loc:cat:(head:(det,
                                              case:Case,
                                              num:Numerus,
                                              gen:Genus),
                                        spr:[],
                                        comps:[]))),
              cont:ind:(        % Der Typ index folgt aus der Anwesneheit der Merkmale per, num, gen
                                per:third,
                                num:Numerus,
                                gen:Genus) )).
 

% alle einfachen Nomina (ohne Argument)
simple_noun *>
 (%det_noun_word,
  synsem:loc:cat:arg_st:tl:e_list ).


% Bei Mädchen, Weib usw. sind SynGenus und SemGenus
% verschieden.
noun(Case,SynGenus,SemGenus,Numerus,Relation) :=
 (simple_noun,
  synsem:loc:(cat:(head:case:morph_case:Case,
                   spr:[loc:cat:head:gen:SynGenus]),
              cont:ind:(num:Numerus,
                        gen:SemGenus)),
  rels:[Relation]).

% Normalerweise sind die Genus-Werte aber gleich.
% Haus
noun(Case,Genus,Numerus,Relation) :=
 (@noun(Case,Genus,Genus,Numerus,Relation)).

% Beamter, Verwandter
adj_noun(Case,Genus,Numerus,DType,Relation) :=
 (@noun(Case,Genus,Genus,Numerus,Relation),
  synsem:loc:cat:spr:[loc:cat:head:dtype:DType]).


% keine Extraktion des Genitivs, aber Extraktion der PP
% Kasuszuweisung nur unter Adjazenz.
%   ein Bild des Affen
% * dessen ich ein Bild gemalt habe
%   ein Bild von dem Affen
% * von dem ich eine Bild gemalt habe
relational_noun *>
 (%det_noun_word
  synsem:loc:cat:arg_st:[((@np_str(Ind2),
                           loc:cat:head:case:morph_case:gen,
                           nonloc:slash:[])
                         ;@pp(von_pform,dat,Ind2)),_],
   rels:hd:arg2:Ind2).

% * Der Affe, ein Bild von dessen Kind er kennt lacht.
% * Der Affe, ein Bild dessen Kindes er kennt lacht.
relational_noun *>
 (%det_noun_word
  synsem:loc:cat:arg_st:hd:nonloc:rel:[]).


relational_noun(Case,Genus,Numerus,Relation) :=
 (relational_noun,
  synsem:loc:(cat:head:case:morph_case:Case,
              cont:ind:(num:Numerus,
                        gen:Genus)),
  rels:[Relation]).

pronoun(Case,Person,Numerus,Genus) :=
  (synsem:loc:(cat:head:case:morph_case:Case,
               cont:ind:(per:Person,
                         num:Numerus,
                         gen:Genus))).

% pers_pronoun *>
%  (%noun_word,
%   %saturated_word
%   loc:cont:ind:Ind,
%   rels:[(pronoun_q,
%          arg0:Ind,
%          rstr:Restr),(pronoun_rel,
%                       lbl:PronounRel,
%                       arg0:Ind)],
%   hcons:[(qeq,
%           harg:Restr,
%           larg:PronounRel)]).

/*
pers_pronoun *>
 (%noun_word,
  %saturated_word
  loc:cont:ind:ref).
*/

pers_pronoun(Case,Person,Numerus,Genus) :=
 (pers_pronoun,
  @pronoun(Case,Person,Numerus,Genus)).

% ich, du haben kein spezifiziertes Genus
pers_pronoun(Case,Person,Numerus) :=
  (@pers_pronoun(Case,Person,Numerus,genus)).


% der, die, das
rel_pronoun(Case,Person,Numerus,Genus) :=
 (nominal_rel_pronoun,
  @pronoun(Case,Person,Numerus,Genus)).

% LTOP wird hochgereicht und dann mit dem des modifizierten Nomens identfiziert.
% ERG 2025-04-04
possessive_rel_pronoun *>
 (%possessive
  synsem:(loc:cont:ltop:LTop,
          nonloc:rel:[ltop:LTop])).

% dessen Kind, dessen Blume, dessen Roman referiert auf Maskulinum/Neutrum
% deren Kind, deren Blume, deren Roman refereirt auf Femininum oder Plural
possessive_rel_pronoun(Genus,Numerus) :=
 (possessive_rel_pronoun,
  synsem:loc:cont:ind:(per:third,
                       num:Numerus,
                       gen:Genus)).


proper_noun *>
 (%noun_word,
  %saturated_word
  synsem:loc:cont:ind:(Ind,
                       per:third,
                       num:sg),
  rels:[(proper_q,
         arg0:Ind,
         rstr:Restr),(named_rel,
                      lbl:NamedRel,
                      arg0:Ind)],
  hcons:[(qeq,
          harg:Restr,
          larg:NamedRel)]).


proper_noun(Genus,Name) :=
 (proper_noun,
  synsem:loc:cont:ind:gen:Genus,
  rels:tl:hd:name:(a_ Name)).

verb_stem *>
 (%word,
  %arg0_ltop_lbl_le
  synsem:loc:(cat:(head:(verb,
                         initial:minus,
                         dsl:none),
                   spr:[]),
              cont:ind:event)).



% alle Verben außer Modalverben und `haben'
non_flip_verb_le *>
  synsem:loc:cat:head:flip:minus.

/*
intrans_verb *>
 (%verb_word,
  synsem:loc:cat:arg_st:hd: @np_str(Ind),
  rels:[arg1:Ind]).
*/

% Liste in anderer Reihenfolge. Subjekt ist das letzte Element von ARG_ST.
intrans_verb *>
 (%verb_word,
  synsem:loc:cat:arg_st:ArgSt,
  rels:[arg1:Ind])
       goal last(ArgSt,@np_str(Ind)).


strict_intrans_verb *>
 (%non_scopal_intrans_verb
  synsem:loc:cat:arg_st:[_]).


intrans_verb(Relation) :=
 (strict_intrans_verb,
  rels:hd:Relation).

np_pp_verb *> 
 (%non_scopal_intrans_verb,
  %bi_or_more_val_verb, 
  synsem:loc:cat:arg_st:[ @pp, _ ]).

np_pp_verb(PForm,Case,Relation) :=
 (np_pp_verb,
  synsem:loc:cat:arg_st:hd: @pp(PForm,Case),
  rels:hd:Relation).


% grauen
subjlos_verb *>
 (%non_scopal_verb_word,
  synsem:loc:cat:arg_st:[ @np(Ind) ],
  rels:[arg2:Ind]).

subjlos_verb(Case,Relation) :=
 (subjlos_verb,
  synsem:loc:cat:arg_st:[ @np(Case,_Ind) ],
  rels:hd:Relation).

% kennen, helfen verbs with at least two arguments and a nominative
bi_or_more_val_verb *>
 (%non_scopal_verb_word,
  synsem:loc:cat:arg_st:append(_,[ @xp(Ind2), @np_str(Ind1) ]),
  rels:[(arg1:Ind1,
         arg2:Ind2)]).

% kennen
strict_trans_verb *>
 (%trans_verb = bi_or_more_val_verb
  synsem:loc:cat:arg_st:[ @np_str, _ ]).

trans_verb(Relation) :=
 (strict_trans_verb,
  rels:hd:Relation).

np_np_dat_verb *>
 (%bi_or_more_val_verb
  synsem:loc:cat:arg_st:[ @np(dat,_), _ ]).

np_np_dat_verb(Relation) :=
 (np_np_dat_verb,
  rels:hd:Relation).

ditrans_verb *>
 (%trans_verb = bi_or_more_val_verb
  synsem:loc:cat:arg_st:[ @np_str(Ind3), @np(dat,_), _  ],
  rels:[arg3:Ind3]).

ditrans_verb(Relation) :=
 (ditrans_verb,
  rels:hd:Relation).


glauben_denken_verb *>
 (%intrans_verb,
  synsem:loc:cat:arg_st:[ (loc:(cat:(head:(comp,
                                           cform:dass),
                                     spr:[],
                                     comps:[]),
                                cont:ltop:Larg)), _ ],
  rels:[arg2:Harg],
  hcons:[(qeq,
          harg:Harg,
          larg:Larg)]).


glauben_denken_verb(Relation) :=
 (glauben_denken_verb,
  rels:hd:Relation).


% Das sind die Beschränkungen, die nötig sind, damit
% keine eingebetteten Köpfe von komplexbildenden Prädikate angezogen werden.
%
% * weil er das Buch lesen [können wird]
%
% Komplexbildende Prädikate müssen immer direkt mit ihrem
% eingebetteten Kopf verbunden werden:
%
% weil er das Buch [[lesen können] wird]


non_complex_forming_synsem :=
  (loc:cat:comps:[],
   lex:minus).

fun list_of_non_complex_forming_synsems(-).
list_of_non_complex_forming_synsems(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_complex_forming_synsems(L) ).

undelayed_list_of_non_complex_forming_synsems([]) if true.
undelayed_list_of_non_complex_forming_synsems([(@non_complex_forming_synsem)|T]) if
   list_of_non_complex_forming_synsems(T).

% Anhebungsverben aber auch die Verbbewegungsregel
% optional kohärente Verben zeihen alle Elemente von COMPS an.
% Es können weitere Argumente hinzukommen. Das Subjekt bei Hilfsverben und dann zusätzlich noch das Subjekt bei ACI-Verben.
optionally_coherent_le *>
  synsem:loc:cat:arg_st:[loc:cat:comps:Comps|(list_of_non_complex_forming_synsems,
                                              append_known_prefix(Comps,_))].

% alle Anhebungsverben, also auch die, die optional kohärent konstruieren,
% Phasenverben (beginnen), sehen, lassn und die, die obligatorisch kohärent konstruieren,
% Modalverben, Futur-Hilfsverb, Perfekt-Hilfsverb

% HCONS oder direkte Einbettung?
raising_verb *>
 (%optionally_coherent_verb,
  synsem:loc:cat:arg_st:hd:loc:(cat:head:dsl:none, % the embedded verb is a real verb not a verb trace. 
                                cont:ltop:VCont),
  rels:[arg3:VCont],
  hcons:[]).


% scheinen, not AcI
% Außerdem auch die beiden Verbbewegungsregeln
subj_raising_verb *> 
 (%raising_verb,
  synsem:loc:cat:arg_st:[loc:cat:(head:(verb,
                                        subj:Subj),
                                  comps:Comps)
                        |append_known_prefix(Comps,Subj)]).


coherent_le *>
  (%optionally_coherent_le
  synsem:loc:cat:arg_st:hd:lex:plus).


% normale Wörter selegieren nie DSL:local-Elemente.
% Nur über LR abgeleitete Wörter tun dies.
% Beschränkung wird gebraucht, um die Einbettung einer
% Verbspur unter ein Hilfs- oder Modalverb auszuschließen.
%
% * Der Frau den Aufsatz _v will er.

% Das war in den vorigen Auflagen des Buches enthalten:
% overt_word *>
%   synsem:loc:cat:comps:list_of_non_dsl_synsems.
% Aber eigentlich reicht es, das für die Anhebungsverben festzuhalten. 


/*
not used

subj_raising_verb(Relation) :=
 (subj_raising_verb,
  rels:hd:Relation).

subj_raising_verb(GovVForm,Relation) :=
 (@subj_raising_verb(Relation),
  synsem:loc:cat:arg_st:hd:loc:cat:head:vform:GovVForm).
*/

modal_verb *>
 (%argument_raising_verb
  synsem:loc:cat:arg_st:hd:loc:cat:head:(vform:bse,
                                         flip:minus)). % [ dürfen _Extraction ]     % nur für Geschwindigkeit


modal_verb(Relation) :=
 (modal_verb,
  rels:hd:Relation).


% dass er das Lied hat singen müssen
modal_flip_verb(Relation) :=
 (irreg_bse_or_inf_verb_infl_lr,                % Das stimmt nicht ganz. Aber die VFORM ist bei diesem Typ unterspezifiziert.
  synsem:loc:cat:head:(vform:ppp,
                       flip:plus),
  rels:hd:Relation,
  dtr:modal_verb).

futur_aux_verb *>
  rels:hd:futur_rel.

% gibt es nur finit und nicht past außer Konjunktiv
futur_aux_verb(Per,Num,Temo) :=
 (@irregular_verb(Per,Num,Temo),
  rels:hd:(pres_ind_conj;past_conj),
  dtr:futur_aux_verb).


% Futur, Passiv kommt im nächsten Kapitel
werden(Per,Num,Temo) :=
  @futur_aux_verb(Per,Num,Temo).


irregular_verb(VForm) :=
 (
  (bse_verb_infl_lr
  ;inf_verb_infl_lr
  %;ppp_verb_infl_lr  % kommt später
  ),
  dtr:synsem:loc:cat:head:vform:VForm).


irregular_verb(Per,Num,TeMo) :=
 (irreg_fin_verb_infl_lr,
  synsem:loc:cat:arg_st:subj_verb_agreement(Per,Num),
  rels:hd:TeMo).


perfect_aux_verb *>
  rels:hd:perfect_rel.

haben_perfect *>
  synsem:loc:cat:(head:flip:Flip,
                  arg_st:hd:loc:cat:head:flip:Flip).


zu_inf_verb_le *>
  (%non_flip_verb
   synsem:loc:cat:arg_st:hd:loc:cat:head:vform:inf).

% bse-Verben sind immer Anhebungsverben
bse_inf_verb_le *>
  (%raising_verb
   %coherent_le
   synsem:loc:cat:arg_st:hd:loc:cat:head:vform:bse).

ppp_inf_verb_le *>
  (%raising_verb
   %coherent_le
   synsem:loc:cat:arg_st:hd:loc:cat:head:vform:ppp).

% not really needed
pro :=
 loc:cont:ind:index.

% Kontrollverben betten den Infinitiv semantisch ein
% und haben ein Subjekt.
control_verb *>
  (synsem:loc:cat:arg_st:(ArgSt,
                          hd:loc:(cat:head:subj:hd: @pro,
                                  cont:ltop:VLTop)),
   rels:[(arg1:SubjInd,
          arg3:VLTop)])
  goal last(ArgSt,@np_str(SubjInd)).



subj_control_verb *>
  (synsem:loc:cat:arg_st:(ArgSt,
                          hd:loc:cat:head:subj:hd:loc:cont:ind:SubjInd))
  goal last(ArgSt,loc:cont:ind:SubjInd).


obj_control_verb *>
  (synsem:loc:cat:arg_st:(hd:loc:cat:head:subj:hd:loc:cont:ind:ObjInd,
                          append(_,[loc:cont:ind:ObjInd,_Subj])),
   rels:[arg2:ObjInd]).

  
% versuchen, versprechen
% sowohl für kohärente als auch für inkohärente Konstruktion
np_v_subj_zu_inf_control_verb *>
  (%zu_inf_subj_control_verb,
   synsem:loc:cat:arg_st:[loc:cat:comps:Comps|append(Comps,[@np_str])]).

np_v_subj_control_verb(Relation) :=
  (np_v_subj_zu_inf_control_verb,
   rels:hd:Relation).

np_np_v_subj_zu_inf_control_verb *>
  (%zu_inf_control_verb,
   synsem:loc:cat:arg_st:[loc:cat:comps:Comps|append(Comps,[@np(ObjInd),@np_str])],
   rels:hd:arg2:ObjInd).


% ihm versprechen
np_np_v_subj_control_verb(Case,Relation) :=
  (np_np_v_subj_zu_inf_control_verb,
   synsem:loc:cat:arg_st:[loc:cat:comps:Comps|append(Comps,[@np(Case,_ObjInd),_])],
   rels:hd:Relation).

% zwingen
np_np_v_obj_control_verb(Relation) :=
  (np_np_v_obj_zu_inf_control_verb,
   synsem:loc:cat:arg_st:[loc:cat:comps:Comps|append(Comps,[@np_str,_])],
   rels:hd:Relation).

% scheinen
coherent_subject_raising_verb(Relation) :=
 (non_flip_coherent_zu_inf_subj_raising_verb,
  rels:hd:Relation).

% beginnen
phase_verb(Relation) :=
 (phase_verb,
  rels:hd:Relation).

% lassen, sehen, hören
aci_verb *>
 (synsem:loc:cat:arg_st:[(loc:cat:(head:subj:Subj,
                                   comps:Comps))|append(append(Comps,Subj),[@np_str(Ind)])],
  rels:hd:arg1:Ind).

aci_verb(Relation) :=
 (aci_verb,
  rels:hd:Relation).



preposition_word *>
(%word,
 %non_scopal_le
 synsem:loc:cat:(head:(prep,
                       initial:plus),
                 spr:[], % otherwise the NP may map to the SPR
                 arg_st:[ (@np_lex,
                           nonloc:slash:[]) ] )).

comp_preposition *>
 (%preposition_word,
  %transparent_head_le % Shares IND and LTOP with argument.
  synsem:loc:cat:(head:case:Case,
                  arg_st:[loc:cat:head:case:Case])).

comp_prep(PForm,Case) :=
 (comp_preposition,
  synsem:loc:cat:head:(pform:PForm,
                       case:morph_case:Case)).

/* falsch, denn modifizierende Adjektive haben eine Ereignisvariable:
der mit dem Stock spielende Affe
isect_modifier *>
 loc:(cat:head:(scopal:minus,
                mod:loc:cont:ind:Ind),
      cont:ind:Ind).
*/
isect_modifier *>
 synsem:loc:cat:head:scopal:minus.

n_modifier *>
 synsem:loc:cat:head:mod: @nbar.

% Das LBL wird vom Adjunkt im Schema beigesteuert.
% Adjektive und Adverbien
isect_modifier_le *>
(%non_scopal_le,
 %isect_modifier
 synsem:loc:cat:head:mod:loc:cont:ind:Ind,
 rels:[arg1:Ind]).
 
attr_adjective_word *>
 (%n_modifier_word,
  synsem:loc:cat:(head:attr_adj,
                  spr:[])).

general_attr_adj(Case,Genus,Num,DType) :=
 (synsem:loc:cat:head:mod:loc:cat:spr:[loc:cat:head:(case:morph_case:Case,
                                                     gen:Genus,
                                                     num:Num,
                                                     dtype:DType)]).

% klug
simple_attr_adj *>
 (%intersective_adj
  synsem:loc:cat:arg_st:[]).

attr_adj(Case,Genus,Num,DType,Relation) :=
 (simple_attr_adj,
  @general_attr_adj(Case,Genus,Num,DType),
  rels:hd:Relation).

% für Pluralformen
attr_adj(Case,Num,DType,Relation) :=
 (simple_attr_adj,
  @general_attr_adj(Case,genus,Num,DType),
  rels:hd:Relation).

% treu
attr_np_adj *>
 (%intersective_adj
  synsem:loc:cat:arg_st:[@np(Ind2)],
  rels:hd:arg2:Ind2).

attr_adj_np(Case,Genus,Num,DType,Relation,GCase) :=
 (attr_np_adj,
  @general_attr_adj(Case,Genus,Num,DType),
  synsem:loc:cat:arg_st:[@np(GCase,_Ind2)],
  rels:hd:Relation).

attr_adj_np(Case,Num,DType,Relation,GCase) :=
 (attr_np_adj,
  @general_attr_adj(Case,genus,Num,DType),
  synsem:loc:cat:arg_st:[@np(GCase,_Ind2)],
  rels:hd:Relation).


scopal_modifier_le *>
  (%ltop_lbl_le
   synsem:loc:cat:head:(mod:loc:cont:ltop:VLTop,
                        scopal:plus),
   rels:[arg1:Arg1],
   hcons:[(qeq,
           harg:Arg1,
           larg:VLTop)]).

% mutmaßlich
scopal_adj *>
 (%saturated_word
  %attr_adjective_word
  %scopal_modifier_le
  synsem:loc:(cat:head:mod:loc:cont:ind:Ind,
              cont:ind:Ind)).

scopal_attr_adj(Case,Genus,Num,DType,Relation) :=
 (scopal_adj,
  @general_attr_adj(Case,Genus,Num,DType),
  rels:[Relation]).

scopal_attr_adj(Case,Num,DType,Relation) :=
 (scopal_adj,
  @general_attr_adj(Case,genus,Num,DType),
  rels:[Relation]).

v_modifier *>
 synsem:loc:cat:head:mod:loc:cat:head:(adj_or_verb,
                                       initial:minus).

adv_word *>
 synsem:loc:cat:head:adv.

% wahrscheinlich
scopal_adv(Relation) :=
 (scopal_adv_word,
  rels:[Relation]).   

isect_adv(Relation) :=
 (isect_adv_word,
  rels:[Relation]).

mod_preposition *>
 (%preposition_word,
  synsem:loc:(cat:(head:mod:loc:cont:ind:Ind,
                   arg_st:[ @np(Ind2) ] ),
              cont:ind:Ind),
  rels:[(arg1:Ind,
         arg2:Ind2)]).

noun_mod_preposition *>
 (%mod_preposition
  %isect_n_modifier_word
  synsem:loc:cat:head:pre_modifier:minus).

location_noun_mod_prep *>
 (%noun_mod_preposition
  synsem:loc:cat:arg_st:[ @np(dat,_) ] ).

location_noun_mod_prep(Relation) :=
 (location_noun_mod_prep,
  rels:hd:Relation).

location_verb_mod_prep *>
 (%verb_mod_preposition
  synsem:loc:cat:arg_st:[ @np(dat,_Ind2) ]).

location_verb_mod_prep(Relation) :=
 (location_verb_mod_prep,
  rels:hd:Relation).


complementizer_like_sign *>
 (%transparent_head_le
  %spr_saturated_le
  synsem:loc:cat:(head:initial:plus,
                  arg_st:[(loc:cat:(head:(verb,
                                          vform:fin,
                                          initial:minus),
                                    spr:[],
                                    comps:[]),
                           trace:minus) ] )).

complementizer_word *>
 (%complementizer_like_sign
  synsem:loc:cat:(head:comp,
                  arg_st:[loc:cat:head:dsl:none])).

complementizer(CForm) :=
 (complementizer_word,
  synsem:loc:cat:head:cform:CForm).



