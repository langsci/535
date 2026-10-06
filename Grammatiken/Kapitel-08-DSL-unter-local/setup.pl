% -*-trale-prolog-*-

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).
:- ale_flag(msl,_,off).

% This reduces the number of pre-computed rules. It rules out rules that would be inconsistent anyway.
:- ale_flag(efdcheck,_,on).
%:- ale_flag(efdcheck,_,off).

% This checks for verb traces whether there is a plausible filler before adding an item to the chart.
:- ale_flag(head_movement_filter,_,on).
%:- ale_flag(head_movement_filter,_,off).


% Nur Wörter, die im Input vorkommen, und leere Elemente verwenden
%:- ale_flag(generator_input_lexicon,_,on).
%:- ale_flag(generator_input_lexicon,_,off). % Default

% Wörter, die nicht im Input sind und leere Semantik haben, ignorieren.
:- ale_flag(generator_input_lexicon,_,empty_only). 


% Anzahl der paralleln Prozesse für Testsuites.
use_cpus_parallel(10).


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

% use ghostview for drawing signatures
% für Linux
%graphviz_option(ps,gv).


% für Mac
%graphviz_option(svg,'batik-squiggle').

% Install gapplin, so that it is the default app.
%graphviz_option(svg,'sleep 0.1; open').

% just use built-in preview for SVG
% graphviz_option(svg,'qlmanage -p').

% install SVGViewer from Appstore and use
graphviz_option(svg,'sleep 0.1; open').


:- trale_milca_version('2.7.12') -> true; ['../Gemeinsames/new-trale.pl'].


:- chart_display.

:- nochart_debug.  % this helps if somebody interrupted during chart debugging and the
                   % flag is still set to 'on'.

:- german.

:- notcl_warnings.  % on = output of warnings in a TCL window, off = output to console


%:- nofs. % do not print feature structures after parsing

% display MRSes after each parse in the interactive mode.
:- mrs.

% send MRSes to utool for display
:- display_mrs.

% send MRSes to utool for scoping
:- scope_mrs.


ind_path([loc,cont,ind]).
% Just use h1 and add a qeq to the local top. This does not have any effect in Utool.
% gtop_path(implicit).

% Just print h1 and do not do anything else.
gtop_path(none).

ltop_path([loc,cont,ltop]).
cont_path([loc,cont]).
liszt_path([loc,cont,rels]).
hcons_path([loc,cont,hcons]).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).
