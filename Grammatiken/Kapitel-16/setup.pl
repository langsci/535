% -*- coding: utf-8; mode: trale-prolog -*-

:- ['../Gemeinsames/setup'].

% Zusaetzliche Wörter ohne eigene Semantikrelation für Paraphrasen.
% Die übrigen semantisch leeren Wörter bleiben auf die Eingabe beschränkt.
generator_input_lexicon_exceptions([von,durch]).
% Relativpronomen erlauben Paraphrasen zwischen Attribut und Relativsatz.
% Andere Lesarten derselben Wortformen bleiben auf die Eingabe beschraenkt.
generator_input_lexicon_exception_type(rel_pronoun).

% Modalrelationen duerfen beim Generieren nicht spezifischer werden als
% die Eingabe: z.B. müssen_sollen_rel darf nicht zu müssen_rel werden.
% Er hat das Buch zu lesen. -/-> Er muss das Buch lesen.
% Allgemeinere Lexikoneintraege koennen weiterhin die Eingabesemantik erben.
% TEMO bleibt von dieser Beschraenkung unberuehrt (synkretische Flexion).
%
% Generated phrases: 18.
% Generation: 240.183 s CPU time.
% Chart: 3586 edges (1240 active, 2346 inactive).
%
% Generated phrases: 13.
% Generation: 112.562 s CPU time.
% Chart: 2534 edges (1020 active, 1514 inactive).
generator_no_semantic_specialization(modal_rel).

% Auch SORT-Werte in semantischen Indizes duerfen nicht spezifischer werden.
% Z.B. object im Input lizenziert weder agentive (jemand) noch non_agentive
% (etwas), sofern diese zusaetzliche Einschraenkung nicht schon gegeben ist.
generator_no_semantic_specialization(anything).

% Zusaetzlich exakt: Auch allgemeinere lexikalische Modalrelationen werden
% ausgeschlossen. Bei muessen_rel im Input sollen modales haben/sein mit
% muessen_sollen_rel bzw. duerfen_koennen_muessen_sollen_rel nicht antreten.
% Geprueft wird der Typ VOR der Unifikation mit der Eingabe.
% TEMO bleibt weiterhin synkretisch; die Typhierarchie bleibt unverändert.
% Zum schwächeren Verhalten oben zurück: folgende Zeile auskommentieren.
% Ein Märchen erzählen wird er ihr müssen.
% Er wird ihr ein Märchen zu erzählen haben.
% Ein Märchen wird ihr von ihm zu erzählen sein.
%
% generator_exact_semantic_type(modal_rel).

% Distributive Tempus-/Modussemantik bei verbaler Koordination.
generator_distributive_relation(temo,conjunction_rel).
generator_distributive_operator(temo,[lbl],[arg0],[arg3]).
generator_distributive_conjunction(conjunction_rel,[lbl],[arg0],[[lhandle],[rhandle]],[[lindex],[rindex]]).

% Zeige alle morphologischen Formen, die über Lexikoneregeln erzeugt werden.
% In Kapiteln kann Ausgabe von Flexionsmerkmalen konfiguriert werden.
% Pro Kapitel einschalten.
%:- ale_flag(morphoutput,_,on).
:- ale_flag(morphoutput,_,off).


% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)
hidden_feat(dtr).           % hide the dtrs attribute (shown by tree)
hidden_feat(affix).         % hide the affix attribute 
hidden_feat(infl).          % hide the affix attribute 
hidden_feat(inf_marking).   % hide technical feature

% Binäres Merkmal, das aus Effizenzgründen verwendet wird.
% Sieht nicht gut aus in Demos ... =;-)
hidden_feat(trace).
hidden_feat(phrase).    % V1 ist eine unäre Projektion, keine Lexikonregel
                        % Koordinationen von Wörtern dürfen Töchter sein, echte Phrasen nicht.
                        % Da das Merkmal im Buch nicht eingeführt wurde, wird es nciht angezeigt.

hidden_feat(max_).

>>> phon.        % phon shall be shown first
>>> lbl.

head   <<< spr.
spr    <<< comps.
comps  <<< arg_st.

%gtop <<< ltop.
ltop <<< ind.

arg0 <<< rstr.
rstr <<< body.

loc <<< nonloc.
nonloc <<< lex.

synsem <<< rels.
rels   <<< hcons.
hcons  <<< root_cont.
root_cont <<< dtrs.
root_cont <<< dtr.
dtr <<< affix.

v2 <<< cannonical.

arg0   <<< lindex.
lindex <<< rindex.
rindex <<< lhandle.
lhandle <<< rhandle.

%:- fs. print AVM after parsing
%:- nofs. % do not print feature structures after parsing

% display MRSes after each parse in the interactive mode.
:- mrs.

% send MRSes to utool for display
:- display_mrs.

% send MRSes to utool for scoping
:- scope_mrs.

% If a description that should be used for generation is produced from a chart edge,
% which pathes of the input sign shall be considered?
%gen_pathes([[synsem,loc,cat,head],[synsem,loc,cat,spr],[synsem,loc,cat,comps],[synsem,loc,cont],[rels],[hcons]]).
gen_pathes([[synsem,loc,cat,head]]).
% Preserve the NP category while allowing all grammatical cases.
gen_pathes_exclude([[synsem,loc,cat,head,case]]).
% Require complete results without copying the input valence/spirits.
gen_root_condition(@root).

% Nur diese spielen in der Syntax eine Rolle. Töchter in syntaktischen Regeln sind alle vom Typ syntactic_sign.
syntactic_object(syntactic_sign).

ind_path([synsem,loc,cont,ind]).
% Just use h1 and add a qeq to the local top. This does not have any effect in Utool.
% gtop_path(implicit).

% Just print h1 and do not do anything else.
gtop_path(none).

ltop_path([synsem,loc,cont,ltop]).
cont_path([synsem,loc,cont]).
liszt_path([rels]).
hcons_path([hcons]).

% Generator: Die Verbspur bezieht Valenz und Semantik von einem ausgewaehlten
% Verb (auch einer Wortkoordination). Sie verbraucht dessen Relationen nicht
% ein zweites Mal. Die Quellbeschreibung entspricht der Tochter der V1-Regel.
generator_empty_anchor([synsem,loc,cat,head,dsl],[synsem,loc],
                       (synsem:(loc:cat:head:(verb,initial:minus),
                                phrase:minus,trace:minus))).

% Extraktionsspuren erhalten ihren LOC-Wert vom ausgewaehlten Filler.
% Das gilt auch fuer eine PP innerhalb einer NP (z.B. "von dessen Kind").
generator_empty_anchor([synsem,loc],[synsem,loc],
                       (synsem:(loc:cat:(spr:list_of_spirits,comps:list_of_spirits),
                                nonloc:(slash:[],rel:ne_list),trace:minus))).

% Argument attraction: anchor verbal extraction traces before projecting
% empty clusters with an otherwise open COMPS list.
generator_empty_anchor([synsem,loc],[synsem,loc],
                       (synsem:(loc:cat:head:(verb,dsl:none),
                                nonloc:slash:[],trace:minus))).

% Gewöhnliche gesättigte Modifikatoren liefern den LOC-Wert der Spur.
% Relative Füller (REL nicht leer) sind durch den Anker oben abgedeckt.
generator_empty_anchor([synsem,loc],[synsem,loc],
  synsem:(loc:cat:(head:modifier_head,
                  spr:list_of_spirits,comps:list_of_spirits),
          nonloc:(slash:[],rel:[]),trace:minus)).

% Auch gesättigte Modifikatorspuren benötigen einen passenden sichtbaren
% Füller. Sonst können unbestimmte leere Adjunkte beliebig kombiniert werden.
%
% Das Buch ist zu lesen.
% Alt:
% Generation: 736.718 s CPU time.
% Chart: 8709 edges (2038 active, 6671 inactive).
% Neu:
% Generation: 363.001 s CPU time.
% Chart: 5441 edges (1526 active, 3915 inactive).
generator_empty_anchor_required(
  synsem:(trace:extraction,loc:cat:head:modifier_head)).


% Eine verbale Extraktionsspur kann trotz geschlossener COMPS-Liste noch
% eine offene SUBJ-Liste haben. AcI-Verben ziehen beide Listen an.
% Deshalb muss vor der Projektion stets ein passender verbaler Filler den
% gesamten LOC-Wert liefern, auch wenn COMPS bereits leer ist.
generator_empty_anchor_required(
  synsem:(trace:extraction,loc:cat:head:verb)).

generator_valence_path([synsem,loc,cat,comps]).
% Nominal spirits may stay open until their filler is known; verbal valence
% must be anchored before the generator projects an empty category.
generator_valence_anchor_required(synsem:loc:cat:head:verb).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).



% Nodes in Trees
grale_abbreviation(
    synsem:loc:cat:(head:(noun,case:morph_case:Case),
                    spr:[realized:plus],
                    comps:([]
                          ;[realized:plus])),
    'NP'(Case)).

    
grale_abbreviation(
    synsem:loc:cat:(head:(noun,case:morph_case:Case),
                    spr:[realized:minus],
                    comps:([]
                          ;[realized:plus])),
    '\x0305\N'(Case)). % N̅[nom].
    % 'N'''(Case)      % N'[nom]                   

    
grale_abbreviation(
    synsem:loc:cat:(head:(noun,case:morph_case:Case),
                    spr:[realized:minus],
                    comps:[realized:minus]),
    'N'(Case)).

grale_abbreviation(
    synsem:loc:cat:head:(det,case:morph_case:Case),
    'Det'(Case)).

    
grale_abbreviation(
    synsem:loc:cat:(head:(comp_prep,pform:PForm),
                    comps:[realized:plus]),
    'PP'(PForm)).

% Elements in ARG-ST Lists
grale_abbreviation(arg:loc:cat:head:det, 'Det').

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:str,
                                 morph_case:nom)),
    'NP'(snom)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:str,
                                 morph_case:gen)),
    'NP'(sgen)).
    
grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:str,
                                 morph_case:acc)),
    'NP'(sacc)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:nom)),
    'NP'(lnom)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:gen)),
    'NP'(lgen)).
    
grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:dat)),
    'NP'(ldat)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:acc)),
    'NP'(lacc)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:case_type:str),
    'NP'(str)).
    
grale_abbreviation(
    arg:loc:cat:head:(noun,case:morph_case:Case),
    'NP'(Case)).

grale_abbreviation(
    arg:loc:cat:head:(comp_prep,pform:PForm),
    'PP'(PForm)).

grale_abbreviation(
    arg:loc:cat:head:(verb,dsl:local),
    'VP//V').

grale_abbreviation(
    arg:loc:cat:head:(verb,dsl:local),
    'V//V').

grale_abbreviation(
    arg:loc:cat:head:vform:VForm,
    'V'(VForm)).

    
strike_out_pattern(realized:plus).

:- dynamic morphology_info/2.

:-retractall(morphology_info/2).

/*
morphology_info((synsem:loc:cat:(head:(verb,
                                       vform:fin),
                                 arg_st:last(arg:loc:cont:ind:(per:Per,
                                                               num:Num))),
                 rels:hd:Relation),
                [Per,Num,type(Relation)]).

morphology_info(synsem:loc:cat:head:(verb,
                                     vform:VForm),
                [VForm]).

morphology_info(synsem:loc:cat:head:(attr_participle,
                                     mod:loc:cat:spr:hd:arg:loc:cat:head:(case:morph_case:Case,
                                                                          dtype:DType,
                                                                          gen:Gen,
                                                                          num:Num)),
                [adj,Gen,Num,Case,DType]).

*/
% Additional coverage records, separate from the linguistic MRS.
generator_rels_path([generator_rels]).
generator_extra_rels(FS,Extra) :-
   get_type(FS,Type),
   (Type \== 0,
    (sub_type(pers_pronoun,Type) -> Kind=generator_pers_pronoun_rel
     % Alte Variante: Relativpronomen waren an die Eingabe gebunden.
     % Das verhindert Paraphrasen wie Partizipialattribut <-> Relativsatz.
     %; sub_type(rel_pronoun,Type) -> Kind=generator_relative_pronoun_rel
    )
    -> add_to(Kind,EP),ind_path(Path),gen_pathval(Path,FS,bot,Index,bot),
       gen_pathval([generator_index],EP,bot,Argument,bot),Argument=Index,Extra=[EP]
    ; Extra=[]).

% Optionaler Head-Movement-Filter: Implementierung in TRALE, Angaben hier.
% Einschalten: ale_flag(head_movement_filter,_,on).
% Ausschalten: ale_flag(head_movement_filter,_,off).
% Der Lizenzgeber muss vor der geprüften Kante stehen. Der Vergleich bindet
% die Kante nicht. Ohne Flag oder Konfiguration bleibt der Parser ungefiltert.
% Bei möglicher Koordination nicht filtern: koordinierte Köpfe können einen
% LOCAL-Wert beitragen, der in keinem einzelnen Lexikoneintrag vorkommt.
:- multifile parser_head_movement_filter/6.
parser_head_movement_filter(
  (synsem:(loc:cat:head:(verb,initial:minus,vform:fin),phrase:minus,trace:minus)),
  [synsem,loc],                         % Wert des lexikalischen Lizenzgebers
  [synsem,loc,cat,head,dsl], % zu lizenzierender Wert
  local, before, bypass(synsem:loc:cat:head:coord)).

% Valenzdiagnose auf fertigen Lexikoneinträgen; verändert keine Beschränkungen.
% DA muss geschlossen sein. Bei ARG-ST muss nur das erste Argument samt
% Wortart feststehen; der Rest darf für Argumentanziehung offen bleiben.

% Die vier Argumente bedeuten:

% 1. **`[synsem,loc,cat,head]`**: Pfad vom Lexikoneintrag zu dem Wert, der die Auswahl der zu prüfenden Einträge bestimmt.
% 2. **`verb`**: Nur wenn dieser Wert bereits vom Typ `verb` oder einem Untertyp ist, wird geprüft.
% 3. **`[synsem,loc,cat,arg_st]`**: Pfad zur zu prüfenden Liste.
% 4. **`first([arg,loc,cat,head],head)`**: Beim ersten Listenelement wird dem Pfad `arg:loc:cat:head` gefolgt. Dort muss ein spezifischerer Typ als der allgemeine Typ `head` stehen, beispielsweise `noun`, `verb` oder `prep`.

% Die Prüfung warnt also, wenn die erste Listenzelle noch unbestimmt ist oder die Wortart ihres Arguments noch nicht feststeht. **Der Listenrest darf offen bleiben**, damit Argumentanziehung möglich bleibt. Eine leere ARG-ST-Liste wird akzeptiert.

% Allgemein lautet das Format:

% lexical_valence_check(Auswahlpfad, Auswahltyp, Listenpfad, Prüfung).

% Als Prüfung sind außerdem `closed` für eine vollständig geschlossene Liste und `first` für ein bereits typmäßig spezifiziertes erstes Element möglich. Es werden ausschließlich Warnungen ausgegeben, keine Werte ergänzt.


:- ale_flag(lexical_valence_checks,_,on).
lexical_valence_check([synsem,loc,cat,head],verb,
                     [synsem,loc,cat,head,da],closed).
lexical_valence_check([synsem,loc,cat,head],verb,
                     [synsem,loc,cat,arg_st],first([arg,loc,cat,head],head)).

% Semantisch leeres Präpositions-zu braucht eine passende PFORM-Selektion.
% Infinitiv-zu wird direkt von inf_zu über token> zu bereitgestellt.
:- ale_flag(generator_lexical_selection,_,on).
generator_lexical_selection(
    (comp_preposition,synsem:loc:cat:head:pform:zu_pform),
    bot,[synsem,loc,cat,arg_st],
    [[synsem,loc,cat,head,pform]-[arg,loc,cat,head,pform]]).

% Attributive Kongruenz: Der Index ordnet nur das Bezugsnomen zu.
% Verglichen werden die syntaktischen Anforderungen an den Artikel,
% nicht GEN/NUM am semantischen Index (vgl. Mädchen).
:- ale_flag(generator_lexical_agreement,_,on).
generator_lexical_agreement(
    attr_adj_infl_lr,
    [synsem,loc,cat,head,mod,loc,cont,ind],
    [synsem,loc,cat,head,mod,loc,cat,spr,hd,arg,loc,cat,head],
    synsem:loc:cat:head:noun,
    [synsem,loc,cont,ind],
    [synsem,loc,cat,spr,hd,arg,loc,cat,head]).

% Fruehe Partnerpruefung fuer argumentanziehende Verben.
% Die Projektion erhaelt HEAD und die COMPS-Argumente, aber nicht deren
% REALIZED/RAISED-Werte: Diese koennen sich bei der Phrasenbildung aendern.
% Bekannte IND-/LTOP-Bezuege ordnen moegliche lexikalische Partner zu.
% Unbekannte oder nur phrasal verfuegbare Bezuege werden nicht ausgeschlossen.
% Delays werden nur auf Kopien durch die Partnerprobe geweckt.
%:- ale_flag(generator_lexical_support,_,on).
%:- ale_flag(generator_lexical_support,_,chains).
:- ale_flag(generator_lexical_support,_,tabled).
:- ale_flag(generator_chain_anchor_matching,_,strict).
%:- ale_flag(generator_chain_anchor_matching,_,permissive).

generator_lexical_support(
    [synsem,loc,cat,arg_st,hd,arg,loc],
    [synsem,loc],head([cat,head],verb),
    [[cont,ind],[cont,ltop]],valence([cat,comps],[arg])).

% Experimentelle Valenzvorschau bei der Generierung (ohne Hilfsmerkmale).
% Offene Kopf-Komplement-Kanten warten auf eine passende verbale Projektion.
% participle_or_verb umfasst auch die attributiven Partizipien: Deren offene
% Valenz darf nicht an der Pruefung vorbeigehen. Die uebrigen Pfade stammen
% aus generator_lexical_support/5 oben. REALIZED bleibt bei der Projektion
% erhalten; RAISED wird nicht geteilt. Vergleich: Flag auf off setzen.
:- ale_flag(generator_valence_wait,_,on).
generator_valence_wait(
    head_complement_phrase,
    head([synsem,loc,cat,head],participle_or_verb),
    projection([cont],[realized],[cat,head,vform])).

% Lexikalische Valenzvorschau auch beim Parsen, ohne attracted_comps_.
% Nutzt die obigen generator_valence_wait-/generator_lexical_support-Pfade.
% COMPS behaelt in dieser Grammatik realisierte Argumente als "spirits";
% deshalb koennen Listenlaenge und Argumenttypen vorab verglichen werden.
% Kein Wortstellungsfilter: auch Scrambling/Voranstellung bleibt moeglich.
% Keine Bindung der Kante durch die Probe. Bei Koordination oder zu grosser
% Vorschau wird normal geparst. Ausschalten: ale_flag(parser_valence_filter,_,off).
%:- ale_flag(parser_valence_filter,_,on).
% Der Filter verringert bei einem Gesamtlauf die Kanten um 1016, braucht aber 38 Sekunden länger (5:54 gesamt)
:- ale_flag(parser_valence_filter,_,off).
:- multifile parser_valence_filter/4.
parser_valence_filter(
 [cat,head,subj],
 restructured([synsem,loc,cat,head,initial],plus), % V1/V2 ersetzt die Valenz
 argument([loc],head([cat,head],participle_or_verb),
   [[loc,cat,head],[loc,cat,head,case],[loc,cat,head,pform],
    [loc,cat,head,vform],[loc,cont,ind,per],[loc,cont,ind,num]]),
 bypass(synsem:loc:cat:head:coord)).

% Experimental generic runtime contract; closure itself is grammar code.
root_cont_paths([utterance],plus,[root_cont,rels],[root_cont,hcons]).
generator_root_cont_relations([exists_q,ec_trial_entity_rel]).
