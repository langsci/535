% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.3 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile '*>'/2.
:- discontiguous '*>'/2.

:- multifile ':='/2.
:- discontiguous ':='/2.

:- multifile if/2.
:- discontiguous if/2.

:- multifile fun/1.
:- discontiguous fun/1.


%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (synsem:loc:cat:head:Head,
    head_dtr:synsem:loc:cat:head:Head).

%% Das Valenzprinzip

head_complement_phrase *>
   (synsem:loc:cat:comps:append(FirstPart,append([(arg:NonHeadDtr,
                                                   raised:Raised,
                                                   realized:plus)],LastPart)),
    head_dtr:synsem:loc:cat:comps:append(FirstPart,append([(arg:NonHeadDtr,
                                                            raised:Raised,
                                                            realized:minus)],LastPart)),
    non_head_dtrs:[synsem:NonHeadDtr]).

% specifiers are taken off the list from the beginning of the list
% so the prefix must be a list of spirits.
head_specifier_phrase *>
   (synsem:loc:cat:spr:append(FirstPart,append([(arg:NonHeadDtr,
                                                   raised:Raised,
                                                   realized:plus)],LastPart)),
    head_dtr:synsem:loc:cat:(spr:append((FirstPart,
                                         list_of_spirits),append([(arg:NonHeadDtr,
                                                                   raised:Raised,
                                                                   realized:minus)],LastPart)),
                             comps:list_of_spirits),
    non_head_dtrs:[synsem:NonHeadDtr]).


head_non_complement_phrase *>
   (synsem:loc:cat:comps:Comps,
    head_dtr:synsem:loc:cat:comps:Comps).

head_non_specifier_phrase *>
   (synsem:loc:cat:spr:Spr,
    head_dtr:synsem:loc:cat:spr:Spr).

head_cluster_phrase *>
 (synsem:loc:cat:comps:[(arg:NonHeadDtr,
                         raised:Raised,
                         realized:plus)|Rest],
  head_dtr:synsem:loc:cat:comps:[(arg:NonHeadDtr,
                                  raised:Raised,
                                  realized:minus)|Rest],
  non_head_dtrs:[synsem:NonHeadDtr]).



head_adjunct_phrase *>
   (head_dtr:synsem:HD,
    non_head_dtrs:[synsem:loc:cat:(head:mod:HD,
                                   spr:list_of_spirits,
                                   comps:list_of_spirits)]).
       

% for headed structures the head daughter is appended to the non-head daughters to give a list of all daughters.
% This daughters list can be used to collect RELS, HCONS and so on.
% See rules.pl. The dtrs are ordered according to surface order in rules.pl.

%headed_phrase *>
%   head_dtr:HD,
%   non_head_dtrs:NHDtrs,
%   dtrs:[HD|NHDtrs].


% Argumentrealisierungsprinzip ARP
(word,
 cannonical:plus) *> synsem:loc:cat:(head:subj:Subj, %is_subj_list(Subj),
                                     spr:Spr,
                                     comps:Comps,
                                     arg_st:append(Comps,append(Spr,Subj))).


% Entweder es gibt kein Subjekt, oder es ist eine NP mit strukturellem Kasus.
is_subj_list(List) if
       when( List=(e_list;ne_list)
           , undelayed_is_subj_list(List)
           ).

undelayed_is_subj_list([])  if true.
undelayed_is_subj_list([@np_str])  if true.


% Semantik

phrase *>
  (rels:collect_rels(Dtrs),
   dtrs:Dtrs).

phrase *>
  (hcons:collect_hcons(Dtrs),
   dtrs:Dtrs).



/* GTop wird nicht wirklich gebraucht. 
headed_phrase *>
   (cont:(ind:Ind,
          gtop:GTop),
    head_dtr:cont:(ind:Ind,
                   gtop:GTop),
    non_head_dtrs:[cont:gtop:GTop]).
*/

headed_phrase *>
   (synsem:loc:cont:ind:Ind,
    head_dtr:synsem:loc:cont:ind:Ind).

% head_complement_phrase, head_specifier_phrase, head_filler_phrase
head_non_adjunct_phrase *>
   (synsem:loc:cont:ltop:LTop,
    head_dtr:synsem:loc:cont:ltop:LTop).

head_adjunct_phrase *>
   (synsem:loc:cont:ltop:LTop,
    non_head_dtrs:[synsem:loc:cont:ltop:LTop]).

% Wegen „ein scheinbar schwieriges Beispiel“ kann sich „schwieriges“ nicht im Lexikon den LTop-Wert
% von „Beispiel“ nehmen, denn der LTop-Wert von „Beispiel“ muss mit dem von „scheinbar schwieriges“ gleichgesetzt werden.
(head_adjunct_phrase,
 non_head_dtrs:[synsem:loc:cat:head:scopal:minus]) *>
 (head_dtr:synsem:loc:cont:ltop:LTop,
  non_head_dtrs:[synsem:loc:cont:ltop:LTop]).

(headed_phrase,
 non_head_dtrs:[synsem:loc:cat:head:spec:synsem]) *>
 (head_dtr:synsem:Spec,
  non_head_dtrs:[synsem:loc:cat:head:spec:Spec]).


% die Verbbewegungsanalyse

% Der zu-Wert wird geteilt. Für finite Verben ist das irrelevant, aber bei der scheinbar mehrfachen
% Vorfeldbesetzung können auch infinite Verben beteiligt sein:
% Zum zweiten Mal die Weltmeisterschaft hat Clark 1965 errungen.
% Theoretisch können auch zu-Infinitive involviert sein.
% Zum zweiten Mal die Weltmeisterschaft schien Calrk 1965 zu erringen.
% Hier würde die Lexikonregel auf "zu erringen" angewendet. Bei Koordinationen muss der zu-Wert übertragen werden:
% Zum zweiten Mal die Weltmeisterschaft schien Calrk 1965 zu erringen und verteidigen.

verb_movement_rule *>
( %complex_word
  %optionally_coherent_word
  phon:Phon,
  synsem:(loc:(cat:(head:(verb,
                          subj:raise(Subj)),
                    comps:hd:arg:loc:(cat:head:dsl:Loc,
                                      cont:Cont)),
               cont:Cont),
          nonloc:Nonloc,
          trace:Trace,
          lex:Lex),
  rels:Rels,
  hcons:HCons,
  inf_marking:minus,
  dtrs:[( %word,
          phon:Phon,
          synsem:(loc:(Loc,
                       cat:head:(verb,
                                 initial:minus,
                                 subj:Subj)),
                  nonloc:Nonloc,
                  trace:Trace,
                  lex:Lex,
                  trace:minus,
                                % nur koordinierte Wörter dürfen zu V1-Verben umkategorisiert werden.
                  phrase:minus),
          rels:Rels,
          hcons:HCons)]).


verb_initial_rule *>
( %verb_movement_rule
  %complementizer_like_word
  synsem:loc:cat:head:vform:fin,
  dtrs:[ synsem:loc:cat:(head:vform:fin,
                         comps:list_of_non_raised_arguments)]).



/*
% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
% Siehe auch coordination.pl.
verb_initial_rule *>
( %complementizer_like_sign
  phon:Phon,
  synsem:(loc:(cat:(head:(verb,
                          vform:fin),
                    spr:[],
                    comps:[arg:loc:(cat:head:dsl:Loc,
                                    cont:(ind:Ind,
                                          ltop:LTop))]),
               cont:(ind:Ind,
                     ltop:LTop)),
          nonloc:Nonloc),
  rels:Rels,
  hcons:HCons,
  dtrs:[(phon:Phon,
         synsem:(loc:(Loc,
                      cat:head:(verb,
                                vform:fin,
                                initial:minus)),
                 nonloc:Nonloc,
                 trace:minus,
                                % nur koordinierte Wörter dürfen zu V1-Verben umkategorisiert werden.
                 phrase:minus),
         rels:Rels,
         hcons:HCons)]).
*/


% [einen Mann _i] und schläft kann koordiniert werden.
% dabei muss "einen Mann" irgendwo in der COMPS-Liste von _i auftreten.
% Bei der Koordination wird die COMPS-Liste von [einen Mann _i] mit der von schläft identifiziert.
% Damit ist die COMPS-Liste der Spur < NP[nom], NP[acc] > und die zweite NP durch "einen Mann" realisiert.
% Die Spur hat diese Info auch in DSL. Weil schläft aber als Verbletztverb noch einen offenen DSL-Wert hat,
% kann es mit [ein Mannen _i] koordiniert werden. Das Ergebnis ist eine Projektion mit einer einstelligen
% Valenz und einem zweistelligen DSL-Wert. Diese kann nie verwendet werden, denn entweder ist das Verb hinten
% overt, dann passt der DSL-Wert nicht, oder die Spur identifiziert LOC mit DSL. Dann wird auch in
% [ein Mann _i] und schläft der LOC-Wert mit DSL identifiziert, was aber nicht möglich ist, weil DSL zweistellig,
% die koordinierte Phrase aber einstellig ist.

%[V1 [coord_phrase [ X [ und Y]]

% Auch * [[Den Roman kennt] und [schläft]] er.

(verb_initial_rule,
 dtrs:[coord_phrase]) *> dtrs:hd:dtrs:[synsem:phrase:minus,              % X
                                       dtrs:tl:hd:synsem:phrase:minus].  % Y



headed_phrase *> synsem:phrase:plus.

word *> synsem:phrase:minus.

% Da coord_phrase nicht Untertyp von headed_phrase ist,
% ist der PHRASE-Wert unterspezifiziert.

% [Ihn kennt und schläft] er.
% Ist dennoch ausgeschlossen, da die obige Implikation
% dafür sorgt, daß der DSL-Wert von `ihn kennt' none ist.
% Damit hat die Konjunktion auch den DSL-Wert none und kann
% dann nicht mehr Tochter der V1-Regel sein.

% Sätze mit Verb in Erststellung können Imperativsätze oder auch Interrogativsätze sein.
% Die beiden folgenden Sätze unterscheiden sich nur hinsichtlich ihrer Flexion:
%
%     Gib   Du mir das Buch!
%     Gibst Du mir das Buch?
%
% Die genaue Auflösung der Relation erfolgt erst in der Grammatik für Kapitel 16,
% da dort erst eine Morphologiekomponente eingeführt wird.

% Konditionalsätze werden ignoriert.


(verb_initial_rule,
 synsem:loc:cat:comps:[arg:nonloc:slash:[]])      *> synsem:loc:cont:ind:mode:imperative_or_interrogative.

% Hier spielt das Element in SLASH eine entscheidende Rolle.
% Ist es eine Interrogativphrase, muss ein entsprechender Operator angenommen
% werden. Da die vorliegende Grammatik keine Interrogativpronomina enthält,
% wird die Fallunterscheidung nicht gemacht.
% Jetzt gib ihm das Buch!
% Du kommst morgen?
% Du kommst morgen.
%
% Alles außer Konditional: Kämest Du morgen, könnten wir ...
%
(verb_initial_rule,
 synsem:loc:cat:comps:[arg:nonloc:slash:ne_list]) *> synsem:loc:cont:ind:mode:assertion_or_imperative_or_interrogative.


% Linearisierungsregeln: Wenn der Initial-Wert plus ist, steht die Kopf-Tochter vor der
% Nicht-Kopf-Tochter, sonst danach.
head_complement_phrase *> (head_dtr:HD,
                            non_head_dtrs:[NHD],
                            ( head_dtr:synsem:loc:cat:head:initial:plus,
                              dtrs:[HD,NHD]
                            ; head_dtr:synsem:loc:cat:head:initial:minus,
                              dtrs:[NHD,HD]
                            )).


% In Head-Cluster-Strukturen wird nicht auf den INITIAL-Wert bezug genommen,
% da auch Nomina wie `Herumgerenne' durch diese Strukturen lizenziert werden.
% Für die Linearisierung ist nur der FLIP-Wert relevant.
head_cluster_phrase *> (head_dtr:HD,
                            non_head_dtrs:[NHD],
                            ( non_head_dtrs:hd:synsem:loc:cat:head:flip:plus, % zur Oberfeldumstellung siehe Müller99a:14.2
                              dtrs:[HD,NHD]
                            ;
                              non_head_dtrs:hd:synsem:loc:cat:head:flip:minus,  
                              dtrs:[NHD,HD])
                            ).


% Wenn der Pre-Modifier-Wert plus ist, steht die Adjunkt-Tochter vor der
% Kopf-Tochter, sonst danach.
head_adjunct_phrase *> (head_dtr:HD,
                           non_head_dtrs:[NHD],
                           ( non_head_dtrs:[synsem:loc:cat:head:pre_modifier:minus],
                               dtrs:[HD,NHD]
                           ; non_head_dtrs:[synsem:loc:cat:head:pre_modifier:plus],
                               dtrs:[NHD,HD]
                           )).

% Der Spezifikator steht vor dem Kopf.
head_specifier_phrase *>
             (dtrs:[NonHeadDtr,HeadDtr],
              head_dtr:HeadDtr,
              non_head_dtrs:[NonHeadDtr]).

% Der Filler steht vor dem Kopf.
head_filler_phrase *> (dtrs:[NonHeadDtr,HeadDtr],
                       head_dtr:HeadDtr,
                       non_head_dtrs:[NonHeadDtr]).

% Relativsätze (unheaded) und V2-Sätze mit Kopf.
filler_phrase *>
   (synsem:nonloc:slash:[],
    dtrs:[synsem:(loc:Slash,
                  nonloc:slash:[]),
          synsem:(loc:cat:(head:(verb,
                                 vform:fin,
                                 dsl:none),
                           spr:list_of_spirits,
                           comps:list_of_spirits),
                  nonloc:slash:[Slash])]).

head_filler_phrase *>
   (v2:plus,
    head_dtr:synsem:loc:cat:head:initial:plus).

%%
head_non_filler_phrase *>
   (synsem:nonloc:slash:(append(Slash1,Slash2),
                         list_with_zero_or_one_element), % The ordering of the two constraints is important.
                                                         % If list_with ... is stated first, rule computation does not terminate.
                                                         % This seems to be a bug. (St. Mü. 01.04.2025)
       head_dtr:synsem:nonloc:slash:Slash1,
       non_head_dtrs:[synsem:nonloc:slash:Slash2]).

% In Argumentpositionen dürfen nur phrasale Einheiten
% stehen. Das wird gebraucht, da ausgeschlossen werden muß,
% daß "lachen wird" mit dem Kopf-Argument-Schema kombiniert
% wird. `wird' verlangt von seinem Argument, daß es LEX+ ist,
% und das Kopf-Argument-Schema spezifiziert LEX aber als -.
% Somit kann nur das Verbalkomplexschema angewendet werden.
% Bei adjazentem eingebetteten Verb würden unechte Mehrdeutigkeiten
% entstehen und bei nicht-adjazentem eingebetteten Verb ungrammatische
% Sätze zugelassen:
%
% * daß lesen er den Aufsatz wird
% * daß er lesen den Aufsatz wird
%
head_complement_phrase *> non_head_dtrs:[synsem:lex:minus].


% Diese Beschränkung schließt die Kombination von teilweise gesättigten
% VPen mit optional kohärent konstruierenden Verben aus.
% Da Determinatoren über SPR selegiert werden, sind Fälle wie
% "vom Buch", in denen eine Präposition mit einer N' kombiniert wird,
% nicht betroffen.
% Bei Koordinationen kann die COMPS-Liste allerdings gefüllt sein:
% "und liebt": "und" wird mit einem nicht gesättigten "liebt" kombiniert.

% not geht nicht im Antecendce:
% (head_complement_phrase,
%  head_dtr:synsem:loc:cat:head: @not(coord)) *>
%   non_head_dtrs:[synsem:loc:cat:comps:[]].

head_complement_phrase *>
  ( head_dtr:synsem:loc:cat:head:coord
  ; head_dtr:synsem:loc:cat:head: @not(coord),
    non_head_dtrs:[synsem:loc:cat:comps:list_of_spirits]
  ).


%% Der Kopf kann nicht extrahiert werden.
%% Ein Problem stellt hierbei das Verb in PVP-Konstellationen
%% dar (siehe Müller, 1999)
%% "Helfen wird er ihm morgen."
headed_phrase *>
   head_dtr:synsem:trace:minus_or_vm.


% Adjunkte sind Extraktionsinseln
(headed_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *>
      head_dtr:synsem:loc:cat:head:mod:none.


% Das entspricht auch der Analyse von Frey 2004 und Fanselow 2003. Die gehen davon
% aus, daß das höchste Element im Mittelfeld ins Vorfeld vorangestellt werden kann.
% Die pragmatischen Eigenschaften der vorangestellten Konstituente entsprechen dabei
% denen, die sie im Mittelfeld in Initialstellung haben würde.

% Die folgenden Beschränkungen stellen sicher, daß immer das letzte verbleibende
% Argument extrahiert wird, d.h. wenn Extraktion stattgefunden hat kann ein Kopf
% nicht mehr projiziert werden.

% Diese Beschränkung kann aus technischen Gründen nicht mit Bezug auf SUBCAT gemacht
% werden, da sonst del/3 deblockiert werden würde, was nicht erwünscht ist, da die
% SUBCAT-Liste bis zur Kombination mit dem Verb in Erststellung unterspezifiziert ist.
%
% Mit der auskommentierten Beschränkung gibt es für den folgenden Satz 55 Kanten.
%
%   Das Buch gibt er ihr oft.
%
% Mit der verwendeten Beschränkung jedoch nur 48. Das liegt daran, daß `er ihr'
% + Trace dazu führt, daß folgende Abfolgen in der SUBCAT-Liste der Verbspur berechnet
% werden: < Trace, er, ihr >, < er, Trace, ihr >, < er, ihr, Trace >
% Nur eine dieser Abfolgen liegt aber in der SUBCAT-Liste des Verbs in Erststellung
% vor.
   
%(head_complement_phrase,
% non_head_dtrs:[trace:extraction]) *> loc:cat:comps:[].

% Wenn die Nicht-Kopftochter eine Extraktionsspur ist, ist die gesamte
% Phrase maximal.
(head_complement_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> synsem:max_:plus.

% Maximale Phrasen können keine Köpfe in Kopf-Argumentstrukturen sein, da sie ja maximal sind.
% Durch die beiden Beschränkungen wird Maximalität erneut und ohne Bezug auf COMPS definiert.
% Wie gesagt, nur ein technischer Trick.
head_complement_phrase *> head_dtr:synsem:max_:minus.


headed_phrase *>
  (synsem:nonloc:rel:(list_with_zero_or_one_element,
                      append(Rel1,Rel2)),
       head_dtr:synsem:nonloc:rel:Rel1,
       non_head_dtrs:[synsem:nonloc:rel:Rel2]).

% Relativsätze Laut ERG 2025-04-04 wird das LTOP aus NONLOC|REL mit dem LTOP des modifizierten
% Nomens geteilt.  Dadurch kann das Possessivpronomen in Relativsätzen konjunktiv mit dem
% modifizierten Nomen verknüpft werden. "Der Mann, dessen Kind schläft, lacht."
rc *>
 (%isect_n_modifier,
  %filler_phrase
  synsem:(loc:(cat:(head:(relativizer,
                          mod:loc:cont:(ind:Ind,
                                        ltop:LTop)),
                    spr:[],
                    comps:[]),
               cont:Cont),
%      (ind:Ind,
%             ltop:LTop),
          nonloc:rel:[]),
  dtrs:[synsem:nonloc:rel:[(ind:Ind,
                            ltop:LTop)],
        synsem:(loc:(cat:head:initial:minus,
                     cont:(Cont,
                           ltop:LTop)),
                nonloc:rel:[],
                                % Der finite Satz selbst darf nicht extrahiert werden.
                                % Das könnte man auch durch loc:Loc, Loc =/= Slash erzwingen.
                trace:minus)]).


% Die Beschränkung auf Initial:minus für die Nicht-Kopftochter ist in dieser
% Grammatik noch nicht relevant, da es keine Kopulakonstruktionen gibt und somit
% auch keine Nominalphrasen, die einen Komplex bilden könnten, allerdings
% hilft diese Beschränkung bereits, wenn eine Verbspur mit einer Extraktionsspur
% kombiniert worden ist, denn danach könnte dieser Komplex mit jedem beliebigen
% Wort kombiniert werden. Da aber Nomina initial:plus sind, scheiden sie aus.
%
% Die Beschränkung der Kopftochter auf `word' ist zu stark, da dadurch
% Koordination wie "lieben will und muß" ausgeschlossen werden.
% Damit man diese erfassen kann, muß man ein weiteres binäres Merkmal
% einführen.
% Da Adjunkte nur an LEX+ Projektionen gehen und der LEX-Wert von
% Kopf-Adjunktstrukturen nicht spezifiziert wird, wären sonst Adjunkte
% im Verbalkomplex zugelassen.


head_cluster_phrase *> (head_dtr:(word;v_trace),
                        non_head_dtrs:[synsem:loc:cat:head:initial:minus]).

head_complement_phrase *> synsem:lex:minus.
head_filler_phrase     *> synsem:lex:minus.
head_specifier_phrase  *> synsem:lex:minus.

head_cluster_phrase *> head_dtr:synsem:trace:minus_or_vm.

% Wenn eine vorangestellte Phrase über das Cluster-Schema kombiniert wird,
% darf sie nicht vollständig sein, denn diese Phrasen sollen über das head_complement_schema abgebunden werden.
% Das erste Element in der COMPS-Liste ist der Spirit des eingebetteten Verbs und dann muss aber noch was kommen.
(head_cluster_phrase,
 non_head_dtrs:hd:e_trace) *> synsem:loc:cat:comps:tl:ne_list.


% Geht durch eine Liste und gibt dem letzten Element die
% Person und Numerus-Merkmale, wenn die Liste mit einer NP_str
% endet. Ansonsten muß das Verb dritte Perosn sg sein.

% Dieses Constraint wird gebraucht, da Modalverben
% nicht wissen, ob sie ein Subjekt haben.

fun subj_verb_agreement(-,+,+).
subj_verb_agreement(X,Per,Num) if
  when( X=(e_list;ne_list)
      , subj_verb_agreement1(X,Per,Num)
      ).

% subject verb agreement
% []                wird gearbeitet
% [np_lex]          dürsten
% [np_str]          schlafen
% [np_lex, np_str]  helfen
% [cp]              stimmen
% [np_lex, cp]      auffallen


% there is no argument at all
subj_verb_agreement1([],third,sg) if true.

% there is a list of arguments
% the last one may be a subject. If it is a subject, i.e. np_str_nom
% it has to agree with the verb.
% If the last element is not a noun or has lexical case, the verb
% has to be third sg.
% As a side effect the constraint assigns accusative to all nouns
% that are not initial
subj_verb_agreement1([H|T],Per,Num) if
  when( T=(e_list;ne_list)
      , undelayed_subj_verb_agreement_([H|T],Per,Num)
      ).

undelayed_subj_verb_agreement_([@np_str(Per,Num)],         Per,  Num) if true.
undelayed_subj_verb_agreement_([@np_lex],                  third,sg)  if true.
undelayed_subj_verb_agreement_([arg:loc:cat:head:(@not(noun))],third,sg)  if true.
undelayed_subj_verb_agreement_(tl:T1,Per,Num) if
  subj_verb_agreement2(T1,Per,Num).

subj_verb_agreement2(L,Per,Num) if
  when( L=(e_list;ne_list)
      , undelayed_subj_verb_agreement_(L,Per,Num)
      ).





% Kasusprinzip 

(word,
 synsem:loc:cat:head:adj_or_participle_or_verb) *> synsem:loc:cat:arg_st:ArgSt goal assign_case_verb(ArgSt).

fun assign_case_verb(-).
assign_case_verb(List) if
  assign_case_verb_wait(List,List).

% Warten, bis die Listenstruktur bekannt ist. Das erste Argument wird
% schrittweise abgearbeitet; das zweite bewahrt die gesamte ARG-ST-Liste
% für die anschließende Kasuszuweisung.
assign_case_verb_wait(List,ArgSt) if
  when(List=(e_list;ne_list),assign_case_verb_wait_list(List,ArgSt)).

assign_case_verb_wait_list([],ArgSt) if
  undelayed_assign_case_verb(ArgSt).


% The second condition lists the non-nominal head classes of this signature.
% A negated-type macro cannot be used as a when/2 condition.
% RAISED must be supplied by the construction, not chosen by case assignment.
assign_case_verb_wait_list([H|T],ArgSt) if
  when(H=raised:(plus;minus),
   when((H=arg:loc:cat:head:(noun,case:case_type:(str;lex));
        H=arg:loc:cat:head:(det;adj_or_participle_or_verb;prep;comp;coord;relativizer;adv)),
       assign_case_verb_wait(T,ArgSt))).



% Wenn die Argumente nicht lokal realisiert wurden, passiert nichts.
undelayed_assign_case_verb([]) if true.

undelayed_assign_case_verb([raised:plus|Rest]) if assign_case_verb(Rest).

% Wenn die Argumente lokal realisiert wurden, weise NPen mit strukturellem
% Kasus ja nach Position Nominativ oder Akkusativ zu.

% Die letzte NP mit strukturellem Kasus bekommt Nominativ.
undelayed_assign_case_verb([(raised:minus,
                             @np_str,
                             arg:loc:cat:head:case:morph_case:nom)])  if true.

% Ein Aufsatz wurde ihm zu lesen erlaubt.
undelayed_assign_case_verb([(raised:minus,
                             @np_str,
                             arg:loc:cat:head:case:morph_case:nom),@np_lex])  if true.






% Alle anderen NPen mit strukturellem Kasus bekommen Akkusativ.
% Es muß noch mindestens ein Element in der Valenzliste geben, daß
% nicht durch Passivierung blockiert ist (realized:bool = nicht realized:blocked).
% Für dieses werden die obigen Klauseln angewendet.
undelayed_assign_case_verb([(raised:minus,
                             @np_str,
                             arg:loc:cat:head:case:morph_case:acc),(Nom,
                                                                    @np_str)|Rest])  if assign_case_verb([Nom|Rest]).
% Er verspricht ihm das lied zu singen.
undelayed_assign_case_verb([(raised:minus,
                             @np_str,
                             arg:loc:cat:head:case:morph_case:acc),(Lex,
                                                                    @np_lex),
                                                                   (Nom,
                                                                    @np_str)|Rest])  if assign_case_verb([Lex,Nom|Rest]).
undelayed_assign_case_verb([(raised:minus,
                             @np_lex)|Rest])                                 if assign_case_verb(Rest).
undelayed_assign_case_verb([(raised:minus,
                             @no_noun)|Rest])                                if assign_case_verb(Rest).



fun attract(+,-).
attract(List1,List2) if
       when( (List1=(e_list;ne_list);
              List2=(e_list;ne_list))
           , undelayed_attract(List1,List2)
           ).

undelayed_attract([],[]) if true.
undelayed_attract([(arg:Synsem,
                    realized:Realized)|Rest1],[(realized:Realized,
                                                arg:Synsem)|Rest2]) if attract(Rest1,Rest2).


% Kopiert die ARGUMENT-Werte einer Liste1 in eine Liste2 und markiert die Elemente
% von Liste1 als angezogen.
fun raise(+,-).
raise(List1,List2) if
       when( (List1=(e_list;ne_list);
              List2=(e_list;ne_list))
           , undelayed_raise(List1,List2)
           ).

undelayed_raise([],[]) if true.
undelayed_raise([(arg:Synsem,
                  realized:Realized,
                  raised:plus)|Rest1],[(realized:Realized,
                                        arg:Synsem)|Rest2]) if raise(Rest1,Rest2).



fun list_of_raised_arguments(-).
list_of_raised_arguments(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_raised_arguments(L) ).

undelayed_list_of_raised_arguments([]) if true.
undelayed_list_of_raised_arguments([raised:plus|T]) if
   list_of_raised_arguments(T).


% In inkohärenten Konstruktionen werden nur die nicht realisierten
% Argumente angezogen.
fun attract_unrealized(+,-).
attract_unrealized(List1,List2) if
       when( List1=(e_list;ne_list)
           , undelayed_attract_unrealized(List1,List2)
           ).

undelayed_attract_unrealized([],[]) if true.
undelayed_attract_unrealized([(realized:(minus,
                                         Realized),
                               arg:Synsem,
                               raised:plus)|Rest1],[(realized:Realized,
                                                     arg:Synsem)|Rest2]) if attract_unrealized(Rest1,Rest2).

% Bereits realisierte Argumente werden nicht angehoben.
% Das ist für die inkohärente Konstruktion wichtig.
undelayed_attract_unrealized([(realized:plus,
                               raised:minus)|Rest1],Rest2) if attract_unrealized(Rest1,Rest2).



fun list_of_non_raised_arguments(-).
list_of_non_raised_arguments(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_raised_arguments(L) ).

undelayed_list_of_non_raised_arguments([]) if true.
undelayed_list_of_non_raised_arguments([raised:minus|T]) if
   list_of_non_raised_arguments(T).


% Das ist die erste Version gewesen, leider ist sie aber mit der scheinbar mehrfachen Vorfeldbesetzung
% nicht kompatibel. Wenn die MVF als Instanz der kohärenten Konstruktion analysiert werden soll, dann
% ist es für die Analyse von Sätzen wie (1) nötig, die Anhebung von Argumenten eines finiten Verbs zuzulassen.
%
% (1) Der Frau das Buch gibt er nicht.
%
%(word,
% synsem:loc:cat:head:vform:fin) *> synsem:loc:cat:subcat:list_of_non_raised_arguments.

% Bei der folgenden Formulierung wird der raised-Wert erst festgelegt, wenn das Verb in einer
% syntaktischen Struktur verwendet wird.

head_dtr:(word,
          phon:ne_list, % sonst würde die finite Spur im Vorfeld die Anhebung eines Arguments nicht gestatten.
                        % Leider wird die Implikation somit auch nicht auf die Verbspur in der rechten Satzklammer
                        % im Hauptsatz angewendet. Deshalb muß die Beschränkung noch mal extra in der
                        % Lexikonregel für die Bewegung des finiten Verbs formuliert werden.

          synsem:loc:cat:head:vform:fin) *> synsem:loc:cat:comps:list_of_non_raised_arguments.


fun list_of_spirits(-).
list_of_spirits(List) if
       when( List=(e_list;ne_list)
           , undelayed_list_of_spirits(List)
           ).

undelayed_list_of_spirits([]) if true.
undelayed_list_of_spirits([realized:plus|Rest]) if list_of_spirits(Rest).

fun list_of_syntactic_signs(-).
list_of_syntactic_signs(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_syntactic_signs(L) ).

undelayed_list_of_syntactic_signs([]) if true.
undelayed_list_of_syntactic_signs([syntactic_sign|T]) if
   list_of_syntactic_signs(T).

% Schließt Stämme in der Syntax aus.
% Stämme als Kopftochter sind bereits in der Signatur ausgeschlossen
phrase *>
   dtrs:list_of_syntactic_signs.


fun list_of_zu_minus(-).
list_of_zu_minus(L) if
   when( (L=(e_list;ne_list)),
         list_of_zu_minus2(L) ).


list_of_zu_minus2([]) if true.
list_of_zu_minus2([H|T]) if
   when( (H=(word;phrase)),
         undelayed_list_of_zu_minus([H|T]) ).

undelayed_list_of_zu_minus([]) if true.
undelayed_list_of_zu_minus([(word,
                             inf_marking:minus)|T]) if
   list_of_zu_minus(T).
undelayed_list_of_zu_minus([phrase|T]) if
   list_of_zu_minus(T).

% Sorgt dafür, daß Objekte, die noch ein `zu' benötigen,
% nicht in der Syntax als Töchter auftreten können.
% Das kann nicht ausschließlich an Typen festgemacht werden,
% da `zu lesende' eine Form mit Adjektivflexion ist. Flektierte
% Objekte sind aber normalerweise syntaktische Objekte (z.B. `kluge') 
phrase *> dtrs:list_of_zu_minus.


root :=
 synsem:(loc:cat:(head:dsl:none,
                  spr:list_of_spirits,
                  comps:list_of_spirits),
         nonloc:slash:[]).

initial_fin_verb :=
 (@root,
  synsem:loc:cat:head:(verb,
                       initial:plus,
                       vform:fin)).

% interrogative
interrog :=
 (@initial_fin_verb,
  synsem:loc:cont:ind:mode:interrogative).

% Funktioniert nicht, weil das oberste Element eine Konjunktion sein kann:
% Paul ist ein Idiot und warum merkt das außer mir niemand?

% assertion
decl :=
 (@initial_fin_verb,
  synsem:loc:cont:ind:mode:assertion,
  v2:plus).

% imparative = v1 oder v2 mit Ausrufezeichen
imp :=
 (@initial_fin_verb,
  synsem:loc:cont:ind:mode:imperative).
