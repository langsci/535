
:- ['../Gemeinsames/setup'].

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
%hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
%hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)

>>> phon.        % phon shall be shown first
phon   <<< head.
head   <<< spr.
spr    <<< comps.
comps  <<< arg_st.
arg_st <<< head_dtr.

%:- nofs. % do not print feature structures after parsing
