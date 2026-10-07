% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: rules.pl,v $
%%  $Revision: 1.3 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile rule/2.

% Diese Datei kann ignoriert werden, sie hilft nur dem Parser
% und wird aus technischen Gründen gebraucht.

% Wenn man hier die INITIAL und PRE_MODIFIER-Werte nicht angeben würde,
% würde man jeweils nur eine Regel brauchen. Die Regelnamen sind aber
% beim Debuggen der Grammatik ganz nützlich, so dass ich weiterhin mit
% Regel-Paaren arbeite. Oder?

h_comp rule (head_complement_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             head_dtr:synsem:loc:cat:head:initial:plus)
  ===>
cat> HeadDtr,
cat> NonHeadDtr.

comp_h rule (head_complement_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:synsem:loc:cat:head:initial:minus,
             non_head_dtrs:[(NonHeadDtr,
                             synsem: @argument_synsem   % speed + Regelberechnung
                            )])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.

spr_h rule (head_specifier_phrase,
             dtrs:[NonHeadDtr,HeadDtr])
  ===>
cat>      NonHeadDtr,
sem_head> HeadDtr.


adj_h rule (head_adjunct_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             non_head_dtrs:[synsem:loc:cat:head:pre_modifier:plus])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.



h_adj rule (head_adjunct_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             non_head_dtrs:[synsem:loc:cat:head:pre_modifier:minus])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.





f_h rule (head_filler_phrase,
             dtrs:[NonHeadDtr,HeadDtr])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.


% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
v1 rule (verb_initial_rule,
         dtrs:[Dtr])
  ===>
cat>     Dtr.


rc rule (rc,
         dtrs:[Filler,Clause])
  ===>
cat> Filler,
cat> Clause.


cl_h rule (head_cluster_phrase,
           non_head_dtrs:hd:synsem:loc:cat:head:flip:minus,
           dtrs:[NonHeadDtr,HeadDtr])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.


% Hierfür würde man eigentlich eine Lexikonregel verwenden,
% die den Verbstamm auf den zu-Infinitiv abbildet, aber
% das geht aus technischen Gründen nicht, da zwischen
% `zu' und Infinitiv ein Leerzeichen steht.
% Das ist übrigens bei den Partikelverben nicht so ...

% der zu lesende Aufsatz, eigentlich `zu lesen' + de
% Der Aufsatz ist zu lesen.
inf_zu rule

 (complex_word,
  phon:[(a_ zu)|Phon],
  synsem:Synsem,
  rels:Rels,
  hcons:HCons,
  inf_marking:minus,
  cannonical:minus) % ARG-ST wird in der zweiten Tochter shcon berechent.  Es würde nichts schaden,
                    % wenn wir das hier noch einmal berechneten, aber es würde dasselbe herauskommen
                    % und nur Zeit benötigen.
  ===>
  % Als erste Tochter nehmen wir irgendein `zu', das in der Grammatik vorhanden ist.
  % Es muß eindeutig sein!
cat> (word,
            phon:[(a_ zu)],
            synsem:loc:cat:head:comp_prep),
cat> (word,
      phon:Phon,
      synsem:Synsem,
      rels:Rels,
      hcons:HCons,
      inf_marking:plus).

