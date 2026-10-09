
:- ['../Gemeinsames/setup'].

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% -*-  coding:utf-8; mode:trale-prolog   -*-

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)

>>> phon.        % phon shall be shown first
phon  <<< p_o_s.
p_o_s <<< spr.
spr   <<< comps.
comps <<< arg_st.

%:- nofs. % do not print feature structures after parsing
