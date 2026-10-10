% -*-  coding:utf-8; mode:trale-prolog   -*-

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.12 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- (environ('TRALE_UNICODE', true);
    format(user_error,"~n~n**ERROR: Please start trale with the option `-u' to enable unicode support, which is needed for this grammar.~n~n~n",[]),
    abort).

% für [incr TSDB()]
grammar_version('Lehrbuchgrammatik Kapitel 4').
% Short label for app names in the task switcher and for Grale output titles.
grammar_name('Kapitel 15').


% Load phonology and tree output
:- [phonology].

:- [setup].

root_symbol(@root).
decl_symbol(@decl).
que_symbol(@interrog).
imp_symbol(@imp).

% specify signature file
signature('signature.tdl').

% macros for the lexicon
:- [le_macros].
:- [flex_macros].


% load suffixes for inflection
:- [suffixes].

% load lexical rules
:- ['lexrules'].
%:- ['lexrules-without-dtrs']. % for circumventing bug TRALE for SP 4 cannot output the signs with DTR.

% load lexicon
:- [lexicon].

% load lexical rule for multiple frontings
%:- ['mehrfache-vorfeldbesetzung'].

% load phrase structure rules
:- [rules].

% load phrase structure rules for Oberfeldumstellung
:- [oberfeldumstellung].

% load phrase structure macros
:- [syntax].


% load lexical items and grammar rules for coordination
:- [coordination].

% Nur zum Spielen noch da.
%:- ['old-constraints-head-movement'].


% load some constraints that are not linguistically necessary,
% but good for performance/termination
:- [speed].


% load relational constraints for rules
:- [constraints].

% load a test sequence
:- [test_items].


% load a sequence that is executed after the grammar is loaded
:- ['../Gemeinsames/common.pl'].


% p_and_g("Der Affe schläft.",@decl).
% p_and_g("Jede Frau und jeder Mann kennt ein Buch.",@decl).

% p_and_g("Der Affe, von dessen Kind er ein Bild kennt, lacht.",@decl).

% p_and_g("Lesen muss er das Buch.",@decl).

gtest :- p_and_g("Der Affe, von dessen Kind er ein Bild kennt, lacht.",@decl).


% testgt(all).
% testgt(5).
% testgt([2,5]).
% testgt(all, summary(Bestanden, Fehlgeschlagen)).


examples(['  dass Aicke lachen muss',
          '  Lachen muss Aicke.',
          '  Dem Kind erzählen muss Aicke die Geschichte.',
          '  Eine Geschichte erzählen muss Aicke dem Kind.']).



