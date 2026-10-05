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
undelayed_list_of_non_dsl_synsems([arg:loc:cat:head:dsl:none|T]) if
   list_of_non_dsl_synsems(T).


% Nur Verben und adjektivische Partizipien können mit zu kombiniert
% werden. Unflektierte Wörter sind immer ZU-.
% ZU ist nur ein technisches Hilfsmerkmal.
% alle sichtbaren Lexikonelemente außer Lexikonregeln
overt_le *> inf_marking:minus.

% Alle Töchter außer denen in der zu-Regel müssen inf_marking:minus sein.
% to do

non_overt_le *>
  (%empty_rel_le,
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

empty_rel_le *>
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


np :=
  (arg:loc:cat:(spr:list_of_spirits,
                comps:list_of_spirits),
   arg:loc:cat:head:noun).

% eine NP mit strukturellem Kasus
% Diese Makros werden auch vom Kasus-Prinzip verwendet und da kann realized:plus sein.
% Deshalb dürfen sie nicht von @argument erben.
np_str :=
  (@np,
   arg:loc:cat:head:case:case_type:str).

np_lex :=
  (@np,
   arg:loc:cat:head:case:case_type:lex).


% Alle Argumente, die in Valenzrahmen spezifiziert werden, sind realized:minus.
% Es gibt auch solche, die nicht spezifiziert sondern angehoben werden.
% Diese können realized:plus oder realized:minus sein, das hängt davon ab,
% ob sie in einer Projektion im Vorfeld realisiert wurden, oder nicht.
% Die Makros np_str, np_str(Per,Num) und np_lex werden für Kasusvergabe
% und für Kongruenz genutzt. Bei ihnen darf also der REALIZED-Wert nicht
% spezifiziert sein.
argument :=
  realized:minus.

argument_np :=
  (@argument,
   @np).

xp :=
  (@argument,
   arg:loc:cat:(spr:list_of_spirits,
                comps:list_of_spirits)).

% kennen, helfen, denken an
xp(Ind) :=
  (@xp,
   arg:loc:cont:ind:Ind).

np_ref :=
  (@argument_np,
   arg:loc:cont:ind:ref).

np(Ind) :=
  (@np_ref,
   arg:loc:cont:ind:Ind).

np_expl :=
  (@argument_np,
   @np_str,
   arg:loc:cont:ind:expl).

% das Subjekt von Adjektiven, Infinitiven und vom Passiv
pro_np :=
 (@np,
  arg:(loc:cat:(spr:[],       % ansonsten hängt ein Constraint rum
                comps:[]),
       lex:minus),
%  realized:plus,
  raised:minus).         

fun list_of_pro_nps(-).
list_of_pro_nps(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_pro_nps(L) ).

undelayed_list_of_pro_nps([]) if true.
undelayed_list_of_pro_nps([@pro_np|T]) if
   list_of_pro_nps(T).


% attributive Adjektive
pro_np(Ind) :=
 (@pro_np,
  @np(Ind)).

pro_np_ref :=
 (@np_ref,
  @pro_np).


% für Passiv und Partizipien
blocked_np_ref :=
 (@pro_np_ref,
  realized:minus).

blocked_np_ref(Ind) :=
 (@blocked_np_ref,
  @np(Ind)).

np_str(Ind) :=
  (@np_str,
   @np(Ind)).

np_str(Per,Num) :=
  (@np_str,
   arg:loc:cont:ind:(per:Per,
                     num:Num)).

%pro_np_ref_str(Ind) :=
%  (@pro_np_ref,
%   @np_str(Ind)).


lex(Case) :=
 (case_type:lex,
  morph_case:Case).


np(Case,Ind) :=
  (@np(Ind),
   arg:loc:cat:head:case: @lex(Case)).


np_(Per,Num) :=
 (@np,
  arg:loc:cont:ind:(per:Per,
                    num:Num)).

no_noun :=
  (arg:loc:cat:head: @not(noun)).

nbar :=
  (loc:cat:(head:noun,
            spr:[realized:minus],
            comps:list_of_spirits)).

nbar(Ind) :=
  (@nbar,
   loc:cont:ind:Ind).

pp :=
  (@xp,
   arg:loc:cat:head:prep).

pp(Ind) :=
  (@pp,
   @xp(Ind)).

pp(PForm,Case) :=
  (@pp,
   arg:loc:cat:head:(pform:PForm,
                     case:morph_case:Case)).

pp(PForm,Case,Ind) :=
  (@pp(PForm,Case),
   arg:loc:cont:ind:Ind).

% Could be done in signature.tdl, but then the HCONS feature would not be displayed
non_scopal_le *>
  hcons:[].

% expletives and markers
non_relational_le *>
  rels:[].

% complement prepositions and some complementizers.
transparent_head_le *>
 synsem:loc:(cat:arg_st:[arg:loc:cont:(ind:Ind,
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
                   arg_st:last((@argument,
                                arg:loc:cat:(head:(det,
                                                  case:Case,
                                                  num:Numerus,
                                                  gen:Genus),
                                            spr:[],
                                            comps:[])))),
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
                   spr:[arg:loc:cat:head:gen:SynGenus]),
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
  synsem:loc:cat:spr:[arg:loc:cat:head:dtype:DType]).


% keine Extraktion des Genitivs, aber Extraktion der PP
% Kasuszuweisung nur unter Adjazenz.
%   ein Bild des Affen
% * dessen ich ein Bild gemalt habe
%   ein Bild von dem Affen
% * von dem ich eine Bild gemalt habe
relational_noun *>
 (%det_noun_word
  synsem:loc:cat:arg_st:[((@np_str(Ind2),
                           arg:(loc:cat:head:case:morph_case:gen,
                                nonloc:slash:[]))
                         ;@pp(von_pform,dat,Ind2)),_],
   rels:hd:arg2:Ind2).

% * Der Affe, ein Bild von dessen Kind er kennt lacht.
% * Der Affe, ein Bild dessen Kindes er kennt lacht.
relational_noun *>
 (%det_noun_word
  synsem:loc:cat:arg_st:hd:arg:nonloc:rel:[]).


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

expl_pronoun *>
 (%overt_saturated_non_rel_pronoun
  synsem:loc:(cat:head:case:morph_case:nom_or_acc,
              cont:ind:expl)).


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
non_flip_verb_stem *>
  synsem:loc:cat:head:flip:minus.

intrans_unacc_verb *>
  synsem:loc:cat:head:da:[].


% Das designierte Argument Nicht-Unakkusativischer Verben ist das letzte
% Element in der SUBCAT-Liste. Das kann eintweder eine NP mit strukturellem
% Kasus oder ein Satzargument sein.
nerg_verb *>
  (synsem:loc:cat:(head:da:[last_of(ArgSt)],
                   arg_st:ArgSt)).

intrans_nerg_verb *>
 (%non_flip_verb_le,
  synsem:loc:cat:arg_st:ArgSt,
  rels:[arg1:Ind])
       goal last(ArgSt,@np_str(Ind)).

% schlafen
strict_intrans_verb *>
 (%non_scopal_intrans_verb
  synsem:loc:cat:arg_st:[_]).


intrans_verb(Relation) :=
 (strict_intrans_nerg_verb,
  rels:hd:Relation).

intrans_unacc_verb *>
 (%non_flip_verb_le,
  synsem:loc:cat:arg_st:ArgSt,
  rels:[arg2:Ind])
       goal last(ArgSt,@np_str(Ind)).

intrans_unacc_verb(Relation) :=
 (strict_intrans_unacc_verb,
  rels:hd:Relation).


np_pp_verb *> 
 (%non_scopal_intrans_verb,
  %bi_or_more_val_verb, 
  synsem:loc:cat:arg_st:[ @pp, _ ]).

np_pp_verb(PForm,Case,Relation) :=
 (np_pp_verb,
  synsem:loc:cat:arg_st:hd: @pp(PForm,Case),
  rels:hd:Relation).

% regnen
expl_np_verb *>
 (synsem:loc:cat:arg_st:[ @np_expl ]).

expl_np_verb(Relation) :=
 (expl_np_verb,
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

% helfen
np_np_dat_nerg_verb *>
 (%bi_or_more_val_verb
  synsem:loc:cat:arg_st:[ @np(dat,_), _ ]).

np_np_dat_verb(Relation) :=
 (np_np_dat_nerg_verb,
  rels:hd:Relation).

% gelingen
np_np_unacc_verb *> 
 (synsem:loc:cat:arg_st:[ @np(Ind2), @np_str(Ind1) ],
  rels:[(arg1:Ind1,
         arg2:Ind2)]).

np_np_unacc_verb(Case,Relation) :=
 (np_np_unacc_verb,
  synsem:loc:cat:arg_st:hd: @np(Case,_Ind2),
  rels:hd:Relation).


ditrans_verb *>
 (%trans_verb = bi_or_more_val_verb
  synsem:loc:cat:arg_st:[ @np_str(Ind3), @np(dat,_), _  ],
  rels:[arg3:Ind3]).

ditrans_verb(Relation) :=
 (ditrans_verb,
  rels:hd:Relation).


glauben_denken_verb *>
 (%intrans_nerg_verb,
  synsem:loc:cat:arg_st:[ (arg:loc:(cat:(head:(comp,
                                               cform:dass),
                                         spr:[],
                                         comps:list_of_spirits),
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
  (loc:cat:comps:list_of_spirits,
   lex:minus).

fun list_of_non_complex_forming_arguments(-).
list_of_non_complex_forming_arguments(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_complex_forming_arguments(L) ).

undelayed_list_of_non_complex_forming_arguments([]) if true.

% Mit Spirits muß man die folgenden beiden Fälle unterscheiden:
% Das Element ist noch nicht realisiert, muß also non_complex_formin sein.
undelayed_list_of_non_complex_forming_arguments([(@argument,
                                                  arg: @non_complex_forming_synsem)|T]) if
   list_of_non_complex_forming_arguments(T).

% Des Element ist bereits realisiert -> Es ist uns egal, wie es aussieht.
undelayed_list_of_non_complex_forming_arguments([realized:plus|T]) if
   list_of_non_complex_forming_arguments(T).


% optional kohärente Verben ziehen alle Elemente auf ARG-ST an.
% auch die Verbbewegungsregeln fallen darunter.
optionally_coherent_le *>
  synsem:loc:cat:arg_st:[@argument|list_of_non_complex_forming_arguments].

% Anhebungsverben aber auch die Verbbewegungsregel
% optional kohärente Verben zeihen alle Elemente von COMPS an.
% Es können weitere Argumente hinzukommen. Das Subjekt bei Hilfsverben und dann zusätzlich noch das Subjekt bei ACI-Verben.
% Die Satztypenbestimmung geht von genau einem Argument aus. Die müsste man dann ändern.
%optionally_coherent_le *>
%  synsem:loc:cat:arg_st:[arg:loc:cat:comps:Comps)|append_known_prefix(Comps,_)].

% alle Anhebungsverben, also auch die, die optional kohärent konstruieren,
% Phasenverben (beginnen), sehen, lassn und die, die obligatorisch kohärent konstruieren,
% Modalverben, Futur-Hilfsverb, Perfekt-Hilfsverb

% HCONS oder direkte Einbettung?
raising_verb *>
 (%optionally_coherent_verb,
  synsem:loc:cat:arg_st:hd:arg:loc:(cat:head:dsl:none, % the embedded verb is a real verb not a verb trace. 
                                    cont:ltop:VCont),
  rels:[arg3:VCont],
  hcons:[]).



%% DA-Wert schließt Passivierung von Hilfsverben aus.
raising_verb *>
 synsem:loc:cat:head:da:[].


% scheinen, not AcI
subj_raising_verb *>
 (%raising_verb,
  synsem:loc:cat:arg_st:[arg:loc:cat:(head:subj:(Subj,
                                                 list_of_raised_arguments),
                                      comps:Comps)
                        |raise(append_known_prefix(Comps,Subj))]).


coherent_le *>
  (%optionally_coherent_le
  synsem:loc:cat:arg_st:hd:arg:lex:plus).


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
  synsem:loc:cat:arg_st:hd:arg:loc:cat:head:vform:GovVForm).
*/

modal_verb *>
 (%argument_raising_verb
  synsem:loc:cat:arg_st:hd:arg:loc:cat:head:(vform:bse,
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



irregular_verb(VForm) :=
 (
  (bse_verb_infl_lr
  ;inf_verb_infl_lr
  ;ppp_verb_infl_lr
  ),
  dtr:synsem:loc:cat:head:vform:VForm).


irregular_verb(Per,Num,TeMo) :=
 (irreg_fin_verb_infl_lr,
  synsem:loc:cat:arg_st:subj_verb_agreement(Per,Num),
  rels:hd:TeMo).



% Passiv
passive_aux_verb *>
 (%coherent_non_flip_raising_verb
  synsem:loc:cat:arg_st:hd:arg:loc:cat:head:da:[@blocked_np_ref]).

% alle Passivhilfsverben außer lassen
simple_passive_aux_verb *>
 (%coherent_non_flip_raising_verb
  synsem:loc:cat:arg_st:[arg:loc:cat:comps:Comps|raise(Comps)]).

agentive_passive_aux_verb *>
 (%simple_ppp_passive_aux_verb
  rels:hd:agentive_passive_rel).




% werden Vorgangspassiv
werden_pas(Per,Num,TeMo) :=
 (@irregular_verb(Per,Num,TeMo),
  dtr:agentive_passive_aux_verb).


werden(Per,Num,TeMo) :=
  (@futur_aux_verb(Per,Num,TeMo)
  ;
   @werden_pas(Per,Num,TeMo)).

werden_pas(VForm) :=
  (@irregular_verb(VForm),
   dtr:agentive_passive_aux_verb).

werden(VForm) :=
  @werden_pas(VForm).


stative_passive_aux_verb *>
 (%simple_ppp_passive_aux_verb
  rels:hd:stative_passive_rel).


% sein Zustandspassiv
sein_pas(Per-per,Num-num,TeMo-temo) :=
  (@irregular_verb(Per,Num,TeMo),
  dtr:stative_passive_aux_verb).


sein_pas(VForm) :=
  (@irregular_verb(VForm),
   dtr:stative_passive_aux_verb).



perfect_aux_verb *>
  rels:hd:perfect_rel.

haben_perfect *>
  synsem:loc:cat:(head:flip:Flip,
                  arg_st:hd:arg:loc:cat:head:flip:Flip).


% sein 
sein_perf(Per-per,Num-num,TeMo-temo) :=
  (@irregular_verb(Per,Num,TeMo),
   dtr:sein_perfect).

sein_perf(VForm) :=
  (@irregular_verb(VForm),
   dtr:sein_perfect).


zu_inf_verb_le *>
  (%non_flip_verb
   synsem:loc:cat:arg_st:hd:arg:loc:cat:head:vform:inf).

% bse-Verben sind immer Anhebungsverben
bse_inf_verb_le *>
  (%raising_verb
   %coherent_le
   synsem:loc:cat:arg_st:hd:arg:loc:cat:head:vform:bse).

ppp_inf_verb_le *>
  (%raising_verb
   %coherent_le
   synsem:loc:cat:arg_st:hd:arg:loc:cat:head:vform:ppp).

% Dativpassiv

fun promote_dat(+,-).
promote_dat(List,Promoted) if
  del((@np(dat,Ind),
       @pro_np_ref),List,Rest),
  append(Rest,[@np_str(Ind)],Promoted).

dative_passive_aux_verb *>
  (%non_flip_verb_stem
   synsem:loc:cat:arg_st:[(@argument,
                           arg:loc:(cat:comps:Comps,
                                    cont:ltop:VCont))
                         |promote_dat(Comps)],
   rels:[(passive_rel,
          arg3:VCont)]).



% Modale Infinitive


modal_zu_inf *>
 rels:hd:modal_rel.



sein_modal(Per-per,Num-num,TeMo-temo) :=
 (@irregular_verb(Per,Num,TeMo),
  dtr:modal_sein).

sein_modal(VForm) :=
  (@irregular_verb(VForm),
   dtr:modal_sein).


sein(Per-per,Num-num,TeMo-temo) :=
  ( @sein_pas(Per,Num,TeMo)
  ; @sein_perf(Per,Num,TeMo)
  ; @sein_modal(Per,Num,TeMo)).

sein(VForm) :=
  ( @sein_pas(VForm)
  ; @sein_perf(VForm)
  ; @sein_modal(VForm)).


% Kontrollverben betten den Infinitiv semantisch ein
% und haben ein Subjekt.
control_verb *>
  (synsem:loc:cat:arg_st:(ArgSt,
                          hd:arg:loc:(cat:head:subj:hd: @pro_np,
                                      cont:ltop:VLTop)),
   rels:[(arg1:SubjInd,
          arg3:VLTop)])
  goal last(ArgSt,@np_str(SubjInd)).



subj_control_verb *>
  (synsem:loc:cat:arg_st:(ArgSt,
                          hd:arg:loc:cat:head:subj:hd:arg:loc:cont:ind:SubjInd))
  goal last(ArgSt,arg:loc:cont:ind:SubjInd).


obj_control_verb *>
  (synsem:loc:cat:arg_st:(hd:arg:loc:cat:head:subj:hd:arg:loc:cont:ind:ObjInd,
                          append(_,[arg:loc:cont:ind:ObjInd,_Subj])),
   rels:[arg2:ObjInd]).

  
% versuchen, versprechen
% sowohl für kohärente als auch für inkohärente Konstruktion
np_v_subj_zu_inf_control_verb *>
  (%zu_inf_subj_control_verb,
   synsem:loc:cat:arg_st:[arg:loc:cat:comps:Comps|append(attract_unrealized(Comps),[@np_str])]).


np_v_subj_control_verb(Relation) :=
  (np_v_subj_zu_inf_control_verb,
   rels:hd:Relation).

np_np_v_subj_zu_inf_control_verb *>
  (%zu_inf_control_verb,
   synsem:loc:cat:arg_st:[arg:loc:cat:comps:Comps|append(attract_unrealized(Comps),[@np(ObjInd),@np_str])],
   rels:hd:arg2:ObjInd).

% ihm versprechen
np_np_v_subj_control_verb(Case,Relation) :=
  (np_np_v_subj_zu_inf_control_verb,
   synsem:loc:cat:arg_st:[arg:loc:cat:comps:Comps|append(attract_unrealized(Comps),[@np(Case,_ObjInd),_])],
   rels:hd:Relation).

% zwingen
np_np_v_obj_control_verb(Relation) :=
  (np_np_v_obj_zu_inf_control_verb,
   synsem:loc:cat:arg_st:[arg:loc:cat:comps:Comps|append(attract_unrealized(Comps),[@np_str,_])],
   rels:hd:Relation).

% erlauben
np_np_v_obj_control_verb(Case,Relation) :=
  (np_np_v_obj_zu_inf_control_verb,
   synsem:loc:cat:arg_st:[arg:loc:cat:comps:Comps|append(attract_unrealized(Comps),[@np(Case,_ObjInd),_])],
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
 (synsem:loc:cat:arg_st:[(arg:loc:cat:(head:subj:Subj,
                                       comps:Comps))|append(attract_unrealized(append(Comps,Subj)),[@np_str(Ind)])],
  rels:hd:arg1:Ind).

aci_verb(Relation) :=
 (aci_verb,
  rels:hd:Relation).

% the same as above but the embedded subject is not raised
% and the DA is required to contain a referential element

%   Dieses Buch läßt hoffen. -> sowohl belebte als auch unbelebte Subjekte möglich
% * Das Buch läßt die Theorie revidieren.
lassen_passive *>
  (synsem:loc:cat:arg_st:[arg:loc:cat:(head:subj:Subj,
                                       comps:Comps)|append(raise(append(Comps,Subj)), [@np_str(Ind)])],
   rels:[(lassen_rel,
          arg1:Ind)]).


preposition_word *>
(%word,
 %non_scopal_le
 synsem:loc:cat:(head:(prep,
                       initial:plus),
                 spr:[], % otherwise the NP may map to the SPR
                 arg_st:[ (@np_lex,
                           arg:nonloc:slash:[]) ] )).

comp_preposition *>
 (%preposition_word,
  %transparent_head_le % Shares IND and LTOP with argument.
  synsem:loc:cat:(head:case:Case,
                  arg_st:[arg:loc:cat:head:case:Case])).

comp_prep(PForm) :=
 (comp_preposition,
  synsem:loc:cat:head:pform:PForm).

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


adj_stem *>
 (%spr_saturated_le & non_rel_le & underived_stem.
  synsem:loc:cat:head:adj).


% Nicht alle Adjektive haben ein Subjekt (mir ist warm),
% manche haben nicht mal ein Argument (weil offen ist)
isect_adj *>
 (%adj_stem
  synsem:loc:cat:(head:scopal:minus,
                  arg_st:last(@np_str(Ind))),
  rels:[arg1:Ind]).


% klug
np_adj *>
 (%isect_adj
  synsem:loc:cat:arg_st:[@np_str]).

np_adj(Relation) :=
 (np_adj,
  rels:hd:Relation).

% treu
np_np_adj *>
 (%isect_adj
  synsem:loc:cat:arg_st:[@np(Ind2),_],
  rels:hd:arg2:Ind2).

np_np_adj(Case,Relation) :=
 (np_np_adj,
  synsem:loc:cat:arg_st:hd: @np(Case,_Ind2),
  rels:hd:Relation).

np_pp_adj *>
 (%isect_adj
  synsem:loc:cat:arg_st:[@pp(Ind),_],
  rels:hd:arg2:Ind).

np_pp_adj(Pform,Case,Relation) :=
 (np_pp_adj,
  synsem:loc:cat:arg_st:hd: @pp(Pform,Case),
  rels:hd:Relation).



scopal_modifier_le *>
  (%ltop_lbl_le
   synsem:loc:cat:head:(mod:loc:cont:ltop:VLTop,
                        scopal:plus),
   rels:[arg1:Arg1],
   hcons:[(qeq,
           harg:Arg1,
           larg:VLTop)]).

% mutmaßlich(affe(x))
% Ist der Index ein event? Er ist jedenfalls nicht Argument von mutmaßlich.
scopal_adj *>
 (%adj_stem & scopal_modifier_le
  synsem:loc:(cat:(head:mod:loc:cont:ind:Ind,
                   arg_st:[@np(Ind)]),
              cont:ind:event)).

scopal_adj(Relation) :=
 (scopal_adj,
  rels:hd:Relation).

scopal_attr_adj(Case,Num,DType,Relation) :=
 (scopal_adj,
  @general_attr_adj(Case,genus,Num,DType),
  rels:[Relation]).

v_modifier *>
 synsem:loc:cat:head:mod:loc:cat:head:(adj_or_participle_or_verb,
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
                  arg_st:[(@argument,
                           arg:(loc:cat:(head:(verb,
                                               vform:fin,
                                               initial:minus),
                                         spr:[],
                                         comps:list_of_spirits),
                                trace:minus)) ] )).

complementizer_word *>
 (%complementizer_like_sign
  synsem:loc:cat:(head:comp,
                  arg_st:[arg:loc:cat:head:dsl:none])).

complementizer(CForm) :=
 (complementizer_word,
  synsem:loc:cat:head:cform:CForm).



