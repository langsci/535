% -*-trale-prolog-*-

% :- trale_make. % loads all trale files that have been changed since loading the system.

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).
:- ale_flag(msl,_,off).

% This reduces the number of pre-computed rules. It rules out rules that would be inconsistent anyway.
:- ale_flag(efdcheck,_,on).
%:- ale_flag(efdcheck,_,off).

% This checks for verb traces whether there is a plausible filler before adding an item to the chart.
:- ale_flag(head_movement_filter,_,on).

%:- ale_flag(head_movement_filter,_,off).

% inform user about word forms generated
:- ale_flag(morphoutput,_,on).

% Nur Wörter, die im Input vorkommen, und leere Elemente verwenden
%:- ale_flag(generator_input_lexicon,_,on).
%:- ale_flag(generator_input_lexicon,_,off). % Default

% Wörter, die nicht im Input sind und leere Semantik haben, ignorieren.
:- ale_flag(generator_input_lexicon,_,empty_only). 



% Anzahl der paralleln Prozesse für Testsuites.
use_cpus_parallel(10).

% Keine Fortschrittsmeldungen zeigen
:- ale_flag(test_progress,_,off).

% Der Wert ist in Millisekunden, der Standard ist 120000 (2 Minuten).  Das gilt für die
% Generierungstests und testall.  Bei testall verwendet auch das Parsing mit Skopusberechnung diesen
% Wert. Der interaktive Aufruf p_and_g(...) wird dadurch nicht begrenzt.

% generator_test_timeout(300000). % 5 Minuten



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


% load tokenization rules for parsing ordinary strings and atoms
:- ['../Gemeinsames/tokenization'].


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
graphviz_option(svg,'sleep 0.5; open').


:- trale_milca_version('2.7.12') -> true; ['../Gemeinsames/new-trale.pl'].


:- chart_display.

:- nochart_debug.  % this helps if somebody interrupted during chart debugging and the
                   % flag is still set to 'on'.

:- german.

:- notcl_warnings.  % on = output of warnings in a TCL window, off = output to console

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
                       (synsem:(loc:cat:(spr:list_of_spirits,comps:list_of_spirits),
                                nonloc:(slash:[],rel:ne_list),trace:minus))).

% Argument attraction: anchor verbal extraction traces before projecting
% empty clusters with an otherwise open COMPS list.
generator_empty_anchor([synsem,loc],[synsem,loc],
                       (synsem:(loc:cat:head:(verb,dsl:none),
                                nonloc:slash:[],trace:minus))).

generator_valence_path([synsem,loc,cat,comps]).
% Nominal spirits may stay open until their filler is known; verbal valence
% must be anchored before the generator projects an empty category.
generator_valence_anchor_required(synsem:loc:cat:head:verb).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).


% Optional parsing experiment; leave the standard parser enabled by default.
:- compile('../Gemeinsames/parser_head_movement_filter4').


% Nodes in Trees
grale_abbreviation(
    synsem:loc:cat:(head:(noun,case:morph_case:Case),
                    spr:[realized:plus],
                    comps:([]
                          ;[realized:plus])),
    'NP'(Case)).

    
grale_abbreviation(
    synsem:loc:cat:(head:(noun,case:morph_case:Case),
                    spr:[realized:minus],
                    comps:([]
                          ;[realized:plus])),
    '\x0305\N'(Case)). % N̅[nom].
    % 'N'''(Case)      % N'[nom]                   

    
grale_abbreviation(
    synsem:loc:cat:(head:(noun,case:morph_case:Case),
                    spr:[realized:minus],
                    comps:[realized:minus]),
    'N'(Case)).

grale_abbreviation(
    synsem:loc:cat:head:(det,case:morph_case:Case),
    'Det'(Case)).

    
grale_abbreviation(
    synsem:loc:cat:(head:(comp_prep,pform:PForm),
                    comps:[realized:plus]),
    'PP'(PForm)).


% Elements in ARG-ST Lists
grale_abbreviation(arg:loc:cat:head:det, 'Det').

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:str,
                                 morph_case:nom)),
    'NP'(snom)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:str,
                                 morph_case:gen)),
    'NP'(sgen)).
    
grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:str,
                                 morph_case:acc)),
    'NP'(sacc)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:nom)),
    'NP'(lnom)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:gen)),
    'NP'(lgen)).
    
grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:dat)),
    'NP'(ldat)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:(case_type:lex,
                                 morph_case:acc)),
    'NP'(lacc)).

grale_abbreviation(
    arg:loc:cat:head:(noun,case:case_type:str),
    'NP'(str)).
    
grale_abbreviation(
    arg:loc:cat:head:(noun,case:morph_case:Case),
    'NP'(Case)).

grale_abbreviation(
    arg:loc:cat:head:(comp_prep,pform:PForm),
    'PP'(PForm)).

grale_abbreviation(
    arg:loc:cat:head:(verb,dsl:local),
    'VP//V').

grale_abbreviation(
    arg:loc:cat:head:(verb,dsl:local),
    'V//V').

grale_abbreviation(
    arg:loc:cat:head:vform:VForm,
    'V'(VForm)).

    
strike_out_pattern(realized:plus).



morphology_info((synsem:loc:cat:(head:(verb,
                                       vform:fin),
                                 arg_st:last(arg:loc:cont:ind:(per:Per,
                                                               num:Num))),
                 rels:hd:Relation),
                [Per,Num,type(Relation)]).

morphology_info(synsem:loc:cat:head:(verb,
                                     vform:VForm),
                [VForm]).
