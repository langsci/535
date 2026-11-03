% -*- coding: utf-8; mode: trale-prolog -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: particle-verb-lr-hack.pl,v $
%%  $Revision: 1.7 $
%%      $Date: 2006/08/19 07:00:23 $
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


% Die Analyse der Partikelverben so, wie sie im Buch beschrieben ist,
% sieht vor, daß der Verbstamm flektiert und erst danach mit der Partikel
% kombiniert wird. Da es Lexikoneinträge für Partikeln gibt und da
% Trale keine eigene Morphologiekomponente hat, die eine Kombination
% von Wörtern zu neuen Wörtern erlaubt, muß man die Kombination mit
% Lexikonregeln nachbauen, die die Information der Lexikoneinträge
% für die Partikel einschließen.

% Da die Lexikonregel die Arbeit eines Schemas übernimmt, muß sie
% auch die Ergebnisse von Beschränkungen einbauen, die für Schemata gelten
% würden. Dazu zählt die Spezifikation des DSL-Werts bei phonologisch gefüllten
% Töchtern.

transparent_particle_verb_lr_hack(Dtr) :=
(complex_word_dtrs,
 cannonical:Canonical,
 synsem:(loc:(cat:(head:Head,
                   spr:Spr,
                   comps:[Satisfied|Comps],
                   arg_st:[(Satisfied,
                            raised:Raised,
                            realized:plus,
                            arg:Arg)|ArgSt]),
              cont:Cont),
         nonloc:Nonloc,
         lex:Lex,
         trace:Trace),
 rels:collect_rels(Dtrs),
 hcons:collect_hcons(Dtrs),
 dtrs:(Dtrs,
       ec_internal_daughters,
       [(particle,
        synsem:Arg),
       (Dtr,
        word,
        cannonical:Canonical,
        synsem:(loc:(cat:(head:(Head,
                                (adj_or_participle_or_verb;noun), % ansonsten könnte LR auf Konjunktionen angewendet werden.
                                dsl:none),
                          spr:Spr,
                          comps:[Unsatisfied|Comps],
                          arg_st:[(Unsatisfied,
                                   raised:Raised,
                                   realized:minus,
                                   arg:Arg)|ArgSt]), % Das erste Element ist die Partikel. Das wird abgebunden.
                     cont:Cont),
                nonloc:Nonloc,
                lex:Lex,
                trace:Trace))])
).




% für fin-, bse- und ppp-Formen = anlachst, anlachen, gelacht
% für Adjektive und Nomina
particle_verb_orth_lr lex_rule
 (inf_marking:(Zu,
               minus),
  Dtr)
**>
(@transparent_particle_verb_lr_hack(Dtr),
 dtrs:hd:phon:[a_ ParticlePhon],
 inf_marking:Zu)
morphs
  X becomes (ParticlePhon,X).


% für inf-Formen = anzulachen
particle_verb_zu_orth_lr lex_rule
 (inf_marking:plus,
  Dtr)
**>
(@transparent_particle_verb_lr_hack(Dtr),
 dtrs:hd:phon:[a_ ParticlePhon],
 inf_marking:minus)
morphs
  X becomes (ParticlePhon,zu,X).

