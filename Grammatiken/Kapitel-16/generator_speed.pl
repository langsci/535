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