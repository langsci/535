% -*-trale-prolog-*-

:- ['../Gemeinsames/setup'].

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)

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
nonloc <<< rels.
rels   <<< hcons.
hcons  <<< dtrs.

arg0   <<< lindex.
lindex <<< rindex.
rindex <<< lhandle.
lhandle <<< rhandle.

%:- nofs. % do not print feature structures after parsing

% display MRSes after each parse in the interactive mode.
:- mrs.

% send MRSes to utool for display
:- display_mrs.

% send MRSes to utool for scoping
:- scope_mrs.

% If a description that should be used for generation is produced from a chart edge,
% which pathes of the input sign shall be considered?
gen_pathes([[loc,cat,head],[loc,cat,spr],[loc,cat,comps],[loc,cont],[rels],[hcons]]).

syntactic_object(sign).

ind_path([loc,cont,ind]).
% Just use h1 and add a qeq to the local top. This does not have any effect in Utool.
% gtop_path(implicit).

% Just print h1 and do not do anything else.
gtop_path(none).

ltop_path([loc,cont,ltop]).
cont_path([loc,cont]).
liszt_path([rels]).
hcons_path([hcons]).

% Generator: Die Verbspur bezieht Valenz und Semantik von einem ausgewaehlten
% Verb (auch einer Wortkoordination). Sie verbraucht dessen Relationen nicht
% ein zweites Mal. Die Quellbeschreibung entspricht der Tochter der V1-Regel.
generator_empty_anchor([loc,cat,head,dsl],[loc],
                       (phrase:minus,trace:minus,
                        loc:cat:head:(verb,initial:minus))).

% Extraktionsspuren erhalten ihren LOC-Wert vom ausgewaehlten Filler.
% Das gilt auch fuer eine PP innerhalb einer NP (z.B. "von dessen Kind").
generator_empty_anchor([loc],[loc],
                       (loc:cat:(spr:[],comps:[]),
                        nonloc:(slash:[],rel:ne_list),trace:minus)).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).

