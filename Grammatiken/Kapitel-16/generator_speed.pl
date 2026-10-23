% -*- coding: utf-8; mode: trale-prolog -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: speed.pl,v $
%%  $Revision: 1.11 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Linguistisch nicht signifikante Hacks
%%             zur Effizienzsteigerung/Terminierung
%%             bei der Generierung
%%   Language: Trale
%%     System: TRALE 2.3.7 under Sicstus 4.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.
:- multifile if/2.
:- discontiguous if/2.
:- multifile fun/1.
:- discontiguous fun/1.

:- multifile macro/2.
:- discontiguous macro/2.


% Das ist technisch nicht nötig, es ergibt sich aus dem Kongruenzsystem in der NP.  Für den
% Generator ist es aber gut, denn der semantische Index das Subjekts kann bekannt sein: Wenn von die
% klugen Affen generiert wird, braucht man keine Singular-Formen des Adjektivs.  Wegen Mädchen, das
% als Genus semantisch fem_or_neu hat, kann man das Kongruenz-Genus nicht einfach mit dem Index
% identifizieren. Aber schon Numerus bringt eine Reduktion von 212 auf 192 Kanten bei "dem klugen Kind". Und von 230 auf 210 bei "der kluge Affe".
attr_adj_infl_lr *>
  synsem:loc:cat:head:(mod:loc:cat:spr:hd:arg:loc:cat:head:num:Num,
                       subj:hd:arg:loc:cont:ind:num:Num).

/*
head_filler_phrase *> (dtrs:hd:synsem:loc:cat:head:verb
                      ;dtrs:hd:synsem:loc:cat:(spr:list_of_spirits,
                                               comps:list_of_spirits)).

*/

% Der kluge Affe lacht.
% Generation: 29.688 s CPU time.
% Chart: 1156 edges (707 active, 449 inactive).

% Generation: 8.680 s CPU time.
% Chart: 1126 edges (677 active, 449 inactive).

head_filler_phrase *> dtrs:hd:synsem:loc:cat:head:(adv;verb;noun;prep;comp).


% Generation: 11.653 s CPU time.
% Chart: 1104 edges (655 active, 449 inactive).
% Stimmt nicht für mehrfache Vorfeldbesetzung.
(head_filler_phrase,
 dtrs:hd:synsem:loc:cat:head:(verb,
                              vform:fin)) *> dtrs:hd:synsem:loc:cat:comps:list_of_spirits.

% Generation: 10.759 s CPU time.
% Chart: 1094 edges (645 active, 449 inactive).
head_filler_phrase *> dtrs:hd:synsem:loc:cat:spr:list_of_spirits.


(head_filler_phrase,
 dtrs:hd:synsem:loc:cat:head:prep) *> dtrs:hd:synsem:loc:cat:comps:list_of_spirits.

% Die erste Relation in der RELS-Liste der zweiten Tochter muss eine Konjunktion sein.
% Im Generator speziell angelegt:
% Codex: 11.10.2026:
% „Ich ergänze dafür eine allgemeine Vorprüfung: Wenn die erwartete Tochter bereits eine obligatorische Relation verlangt, muss dafür noch eine passende Eingaberelation verfügbar sein. Die Prüfung verwendet die konfigurierten Relationspfade und kennt keine spezielle Koordinationsregel.“
coord_phrase *>
  dtrs:tl:hd:rels:hd:conjunction_rel.

%head_cluster_phrase *>
%  non_head_dtrs:hd:synsem:lex:plus.


% Der Generator baut Kanten für "ihn ihm lesen zu sehen".  Das liegt daran, dass lesen und sehen
% zwar NPen mit strukturllem Kasus verlangen, aber noch nicht festgelegt ist, ob die NPen angehoben sind. Deshalb wird kein Kasus zugewiesen. Und es entsteht eine NP mit strukturellem Dativ.

% Weiß nicht, ob das in die richtige Grammatik gehört. Es ergibt sich ja aud dem Kasusprinzip.
% Hier sorgt es für delayed constraints. Da es auch für Beschreibungen in MOD gilt
% case_type:str *> morph_case:nom_or_gen_or_acc.

np_str_speed :=
  arg:loc:cat:head:case:morph_case:nom_or_gen_or_acc.


% Struktureller Kasus an verbalen Argumenten ist immer Nominativ oder
% Akkusativ. Diese notwendige Bedingung gilt schon vor der positionsabhaengigen
% Kasuszuweisung: RAISED bleibt offen, und nom/acc wird hier nicht entschieden.
% Lexikalischer Kasus und Genitivzuweisung in nominalen Umgebungen bleiben frei.
(word,
 synsem:loc:cat:head:verb) *>
  synsem:loc:cat:arg_st:ArgSt goal generator_verbal_cases(ArgSt).

fun generator_verbal_cases(-).
generator_verbal_cases(Args) if
  when(Args=(e_list;ne_list),generator_verbal_cases_list(Args)).

generator_verbal_cases_list([]) if true.
generator_verbal_cases_list([H|T]) if
  when((H=arg:loc:cat:head:(noun,case:case_type:(str;lex));
        H=arg:loc:cat:head:(det;adj_or_participle_or_verb;prep;comp;coord;relativizer;adv)),
       generator_verbal_case(H)),
  generator_verbal_cases(T).

generator_verbal_case((@np_str,
                        arg:loc:cat:head:case:morph_case:nom_or_acc)) if true.
generator_verbal_case(@np_lex) if true.
generator_verbal_case(arg:loc:cat:head:(det;adj_or_participle_or_verb;prep;comp;coord;relativizer;adv)) if true.


% Das wird in der Grammatik auch gefordert, aber da die Valenzliste offen ist, greifen die Forderungen nicht.
%(head_complement_phrase,
% synsem:loc:cat:head:attr_adj_or_attr_participle) *> synsem:nonloc:rel:e_list.