% -*-trale-prolog-*-

:- ['../Gemeinsames/setup'].

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)
hidden_feat(trace).
hidden_feat(phrase).

>>> phon.        % phon shall be shown first
>>> lbl.

head   <<< spr.
spr    <<< comps.
comps  <<< arg_st.

%gtop <<< ltop.
ltop <<< ind.
ind  <<< rels.
rels <<< hcons.
hcons  <<< dtrs.

arg0 <<< rstr.
rstr <<< body.

%:- nofs. % do not print feature structures after parsing

% display MRSes after each parse in the interactive mode.
:- mrs.

% send MRSes to utool for display
:- display_mrs.

% send MRSes to utool for scoping
:- scope_mrs.

ind_path([loc,cont,ind]).
gtop_path([loc,cont,gtop]).
cont_path([loc,cont]).
liszt_path([loc,cont,rels]).
hcons_path([loc,cont,hcons]).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).

% Optionaler Head-Movement-Filter: Implementierung in TRALE, Angaben hier.
% Einschalten: ale_flag(head_movement_filter,_,on).
% Ausschalten: ale_flag(head_movement_filter,_,off).
% Der Lizenzgeber muss vor der geprüften Kante stehen. Der Vergleich bindet
% die Kante nicht. Ohne Flag oder Konfiguration bleibt der Parser ungefiltert.
% Bei möglicher Koordination nicht filtern: koordinierte Köpfe können einen
% LOCAL-Wert beitragen, der in keinem einzelnen Lexikoneintrag vorkommt.
:- multifile parser_head_movement_filter/6.
parser_head_movement_filter(
  (loc:cat:head:(verb,initial:minus,vform:fin),phrase:minus,trace:minus),
  [loc],                         % Wert des lexikalischen Lizenzgebers
  [loc,cat,head,dsl], % zu lizenzierender Wert
  local, before, bypass(loc:cat:head:coord)).
