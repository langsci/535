% -*-trale-prolog-*-

:- ['../Gemeinsames/setup'].

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% -*-trale-prolog-*-

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)

>>> phon.        % phon shall be shown first
>>> lbl.

head   <<< spr.
spr    <<< comps.
comps  <<< arg_st.
comps  <<< head_dtr.
head_dtr <<< non_head_dtrs.
non_head_dtrs <<< dtrs.

%gtop <<< ltop.
ltop <<< ind.
ind  <<< rels.
rels <<< hcons.

arg0 <<< rstr.
rstr <<< body.

%:- nofs. % do not print feature structures after parsing

% display MRSes after each parse in the interactive mode.
:- mrs.

% send MRSes to utool for display
:- display_mrs.

% send MRSes to utool for scoping
:- scope_mrs.

% If a description that should be used for generation is produced from a chart edge,
% which pathes of the input sign shall be considered?
gen_pathes([[cat,head],[cat,spr],[cat,comps],[cont]]).

syntactic_object(sign).
ind_path([cont,ind]).
% Just print h1 and do not do anything else.
gtop_path(none).
cont_path([cont]).
liszt_path([cont,rels]).
hcons_path([cont,hcons]).
%pos_path([cat,head]).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).
