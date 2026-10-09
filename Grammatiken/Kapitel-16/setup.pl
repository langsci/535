% -*-trale-prolog-*-

:- ['../Gemeinsames/setup'].

% Zusaetzliche Woerter ohne eigene Semantikrelation fuer Paraphrasen.
% Die uebrigen semantisch leeren Woerter bleiben auf die Eingabe beschraenkt.
generator_input_lexicon_exceptions([von,durch]).

% TDL signature input; TRALE supplies missing least upper bounds.
:- ale_flag(subintro,_,file).

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)
hidden_feat(dtr).           % hide the dtrs attribute (shown by tree)
hidden_feat(affix).         % hide the affix attribute 
hidden_feat(infl).          % hide the affix attribute 
hidden_feat(inf_marking).   % hide technical feature

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

v2 <<< cannonical.

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

/*
morphology_info((synsem:loc:cat:(head:(verb,
                                       vform:fin),
                                 arg_st:last(arg:loc:cont:ind:(per:Per,
                                                               num:Num))),
                 rels:hd:Relation),
                [Per,Num,type(Relation)]).

morphology_info(synsem:loc:cat:head:(verb,
                                     vform:VForm),
                [VForm]).

morphology_info(synsem:loc:cat:head:(attr_participle,
                                     mod:loc:cat:spr:hd:arg:loc:cat:head:(case:morph_case:Case,
                                                                          dtype:DType,
                                                                          gen:Gen,
                                                                          num:Num)),
                [adj,Gen,Num,Case,DType]).

*/
% Additional coverage records, separate from the linguistic MRS.
generator_rels_path([generator_rels]).
generator_extra_rels(FS,Extra) :-
   get_type(FS,Type),
   (Type \== 0,
    (sub_type(pers_pronoun,Type) -> Kind=generator_pers_pronoun_rel
     ; sub_type(rel_pronoun,Type) -> Kind=generator_relative_pronoun_rel)
    -> add_to(Kind,EP),ind_path(Path),gen_pathval(Path,FS,bot,Index,bot),
       gen_pathval([generator_index],EP,bot,Argument,bot),Argument=Index,Extra=[EP]
    ; Extra=[]).
