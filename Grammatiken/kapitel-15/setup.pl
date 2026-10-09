% -*-trale-prolog-*-

:- ['../Gemeinsames/setup'].

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)
hidden_feat(dtr).           % hide the dtrs attribute (shown by tree)
hidden_feat(affix).         % hide the affix attribute 
hidden_feat(infl).          % hide the affix attribute 

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
hcons  <<< dtrs.
hcons  <<< dtr.
dtr <<< affix.

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
gen_pathes([[synsem,loc,cat,head],[synsem,loc,cat,spr],[synsem,loc,cat,comps],[synsem,loc,cont],[rels],[hcons]]).

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
                       (synsem:(loc:cat:(spr:[],comps:[]),
                                nonloc:(slash:[],rel:ne_list),trace:minus))).

% Argument attraction: anchor verbal extraction traces before projecting
% empty clusters with an otherwise open COMPS list.
generator_empty_anchor([synsem,loc],[synsem,loc],
                       (synsem:(loc:cat:head:(verb,dsl:none),
                                nonloc:slash:[],trace:minus))).

generator_valence_path([synsem,loc,cat,comps]).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).

% Optional parsing experiment; leave the standard parser enabled by default.
:- compile('../Gemeinsames/parser_head_movement_filter4').
