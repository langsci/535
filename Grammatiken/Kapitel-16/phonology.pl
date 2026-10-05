% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: constraints.pl,v $
%%  $Revision: 1.5 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@fu-berlin.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile '*>'/2.
:- multifile if/2.


% Hier werden einfach die PHON-Werte von Lexikoneinträgen festgelegt und bei Phrasen von den
% Töchtern aufgesammelt.


phonology
forall Word ---> FS do
 FS = phon:[(a_ Word)].


% % Lösung von CodeX, Gerald hatte einfachere, die ich aber überschrieben habe. 03.08.2026

% % Die Morphologie einer Lexikonregel wird intern mit "became" dargestellt.
% % Das Output-Pattern enthält bereits Stamm und Affix; pattern_to_word wandelt
% % ihn in das Atom um, das auch bei Lexikoneinträgen unter PHON steht.
% phonology
% forall _ lex_rule (_ **> FS morphs (_ became Pattern)) do
%  FS = phon:[@pattern_to_word(Pattern)].

% pattern_to_word(Pattern) macro pattern_to_word((a_ Pattern)).
% fun pattern_to_word(+,-).
% pattern_to_word((a_ Pattern),(a_ Word)) if
%  prolog((morph_pattern(Pattern,Chars),
%          make_char_list(Codes,Chars),
%          name(Word,Codes))).

% Gerald Penn 01.08.2026:
% Die Morphologie einer Lexikonregel wird intern mit "became" dargestellt.
% Das Output-Pattern enthält bereits Stamm und Affix; pattern_to_word wandelt
% ihn in das Atom um, das auch bei Lexikoneinträgen unter PHON steht.
phonology
forall _ lex_rule (_ **> FS morphs (_ became Pattern)) do
 prolog(pattern_to_word(Pattern,Word)),
 (FS = phon:[a_ Word]).

pattern_to_word(Pattern,Word) :-
 morph_pattern(Pattern,Chars),
 make_char_list(Codes,Chars),
 name(Word,Codes).


phrase *> (phon:P,
           dtrs:Dtrs) goal collect_phonologies(Dtrs,P).



collect_phonologies(Dtrs,PhonL) if 
   when( (Dtrs=(e_list;ne_list) %;
%          PhonL=(e_list;ne_list)
         ) 
       , undelayed_collect_phonologies(Dtrs,PhonL)
       ).

undelayed_collect_phonologies([],[]) if true.
undelayed_collect_phonologies([phon:Phon|T1],PhonL) if 
  append(Phon,PhonRestL,PhonL),
  collect_phonologies(T1,PhonRestL).

