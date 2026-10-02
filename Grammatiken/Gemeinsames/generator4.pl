%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is the main file for the chart generator
%% Ported to native TRALE feature structures and SICStus Prolog 4 (2026).
%%
%% Author: Aurelien Giraud, aurelien@cl.uni-bremen.de
%%        Universität Bremen
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% PREREQUISITES
%%
%%  o These can be given in theory.pl:
%%          syntactic_object(<type being the mgsat of all syntactic objects>).
%%
%%          ind_path([path,to,index,of,the,mrs]).
%%
%%          cont_path([path,to,mrs]).
%%          liszt_path([path,to,list,of,EPs]).
%%          hcons_path([path,to,handle,constraints]).
%%
%%     Here is what I use. There are chances that it is similar to that:
%%
%%          syntactic_object(syntactic_object).
%%
%%          ind_path([synsem,loc,cont,ind]).
%%          cont_path([synsem,loc,cont]).
%%          liszt_path([synsem,loc,cont,rels]).
%%          hcons_path([synsem,loc,cont,h_cons]).
%%
%% LOADING
%%
%%  o either launch trale with otion:
%%          -e "compile('/path/to/generator/directory/generator.pl')"
%%    or call within trale:
%%          compile('/path/to/generator/directory/generator.pl').
%%
%% USE
%%
%%  o To parse a sentence and generate from its semantics: 
%%          p_and_g([sentence,as,list,of,words]).
%%
%%  o To parse a phrase of description Desc and generate from its semantics:
%%          p_and_g([sentence,as,list,of,words],Desc).
%%
%%  o To generate from a description Desc (representing the whole sign, not only the
%%    semantics), getting all the outputs in the list Words, and matching Desc to the
%%    description Root:
%%          g(Desc).
%%          g(Desc,Words).
%%          g_d(Desc,Words,Root).
%%          g_d(Desc,Root).
%%
%% TEST SUITE HANDLING
%%
%%  o The test suite handling for generation parses a sentence and tries then to
%%    generate from its semantics.
%%
%%  o Example lines to be added to test_items.pl for generation test suite handling:
%%          tg(6,[pierre,donne,une,fée,à,clochette],@root).
%%          tg(6,"Pierre donne une fée à clochette.",@root).
%%
%%  o To test the sentence numbered No in test_items.pl
%%          testg(No).
%%    To test all sentences in test_items.pl
%%          testg(all).
%%  o These can also be used to -write- the test results in file File
%%    (if File exists, its content is replaced by the output)
%%          testgw(No,File).
%%          testgw(all,File).
%%  o These can also be used to -append- the test results to file File
%%    (if File exists, its content is not erased and the results are added at the
%%     end of it)
%%          testga(No,File).
%%          testga(all,File).
%%
%%
%%
%% BUGS:
%%
%% Indices get mixed sometimes in a way that subject and complements of a verb
%% get interchanged leading to more output than it should give.
%%  02/02/06 - Aurelien G.
%% 
%% Does not work yet for difference-lists of EPs in liszt_path(...) and hcons_path(...).
%%  02/02/06 - Aurelien G.




:- use_module(library(system), [datime/1]).
:- use_module(library(file_systems), [file_exists/1]).
:- [generator_grale].
:- dynamic agenda/1.
:- dynamic debug/1.
:- dynamic dbi/2.
:- dynamic stopg/0.
:- dynamic slg_chart/1.
:- dynamic slg_chart_copy/1.
:- dynamic allBits/1.
:- dynamic bitPos/2.
:- dynamic u_st_mod/1.
:- dynamic u_modRules/1.
:- dynamic u_modCats/1.
:- dynamic gen_words/1.
:- dynamic gen_test_quiet/0.

:- dynamic u_syntactic_object/1, seta/1, toggleModification/1.
:- dynamic u_gen_root/1, output_query/1, parsed_words/1, parse_count/1.
:- dynamic gen_store/3.
:- dynamic gen_store_index/3.


%================================================================================
%Debugging predicates
%================================================================================
%--------------------------------------------------------------------------------
%To display the chart and the agenda at their current state with only the words
%and the BitString
%--------------------------------------------------------------------------------
dt:-displayThings.

displayThings :-
   write('Chart:'),nl,
   dwc,
   write('Agenda:'),nl,
   dwa.

%--------------------------------------------------------------------------------
%To display the agenda at its current state with only the words
%and the BitString
%--------------------------------------------------------------------------------
dwa:-
   (  current_predicate(a_edge,a_edge(_,_,_,_,_,_)))
   -> (dwa2 -> true ; true )
   ;  true.

dwa2:-
   a_edge(_,BS,Ws,_,_,_),
   write(BS),
   write(': '),
   write(Ws),nl,
   fail.

%--------------------------------------------------------------------------------
%To display the chart at its current state with only the words
%and the BitString
%--------------------------------------------------------------------------------
dwc:-
   (  current_predicate(c_edge,c_edge(_,_,_,_,_,_)))
   -> (dwc2 -> true ; true )
   ;  true.

dwc2:-
   c_edge(_,BS,Ws,_,_,_),
   write(BS),write(': '),write(Ws),nl,
   fail.

%--------------------------------------------------------------------------------
%Used at the end of initAgenda to display its starting state with only the words
%and the BitString
%--------------------------------------------------------------------------------
displayWords([]):- nl.
        
displayWords([edge(_,BS,Ws,_,_,_)|L]):-
   write(BS),write(': '),write(Ws),nl,
   displayWords(L).



%================================================================================
%General Predicates
%================================================================================
%--------------------------------------------------------------------------------
%open(+L:<list>,-O:<openlist>)
%--------------------------------------------------------------------------------
%O is an open list whose non open part is L.
%--------------------------------------------------------------------------------
open([X],[X|_]).
open([X|Y],[X|Z]):-open(Y,Z).

%--------------------------------------------------------------------------------
%open_h(+L:<list>,-O:<openlist>,-H:<list>)
%--------------------------------------------------------------------------------
%like open/2 but with access to H, the difference between L and O
%--------------------------------------------------------------------------------
open_h([],L,L).
open_h([X|Y],[X|Z],L):-open_h(Y,Z,L).

%--------------------------------------------------------------------------------
%To write a %
%--------------------------------------------------------------------------------
writep(S):-
    name(C,[37]),
    write(C),write(S).

%--------------------------------------------------------------------------------
%To get an independent copy of a FS
%--------------------------------------------------------------------------------
copyFS(FS1,CopyFS1):-
   residuate_term(FS1,Residue),
   copy_term(FS1-Residue,CopyFS1-CopyResidue),
   call(CopyResidue).



%================================================================================
%Predicates for handling the list of generated sentences
%================================================================================
%--------------------------------------------------------------------------------
%Initialisation of the list of generated sentences
%--------------------------------------------------------------------------------
initGenWords:-
   retractall(gen_words(_)),
   assert(gen_words([])).
   
%--------------------------------------------------------------------------------
%To add a sentence to the list of generated sentences
%--------------------------------------------------------------------------------
add_words(L):-
   gen_words(L1),
   retractall(gen_words(_)),
   append(L1,[L],L2),
   assert(gen_words(L2)).



%================================================================================
%Predicates useful for manipulating bitstring bags of EPs
%================================================================================
%--------------------------------------------------------------------------------
%twoPower(+N:<int>, -V:<int>)
%--------------------------------------------------------------------------------
%2^N
%--------------------------------------------------------------------------------
twoPower(0,1).
twoPower(N,V) :- N>0, NMinusOne is N-1, twoPower(NMinusOne,W), V is W*2.

%--------------------------------------------------------------------------------
%getAllBits(+L:<list>, -BitString<int>)
%--------------------------------------------------------------------------------
%get (as an integer) a bitstring AllBits of 1s from a list L
%Allbits and L having the same "length"
%--------------------------------------------------------------------------------
getAllBits(L,AllBits) :-
   getAllBits(L,_,AllBits).

getAllBits([],0,0).
getAllBits([_X|L],N2,V2) :-
   getAllBits(L,N1,V1),
   N2 is N1+1,
   twoPower(N1,W),
   V2 is (V1+W).

%--------------------------------------------------------------------------------
%makeAllBits(+L:<list>, -AllBits:<int>, -EPsBits:<list>)
%--------------------------------------------------------------------------------
%Same as getAllBits plus keeps records of the list elements'bit position
%--------------------------------------------------------------------------------
makeAllBits(L,AllBits,EPsBits) :-
   makeAllBits(L,_,AllBits,EPsBits).

makeAllBits([],0,0,[]).
makeAllBits([X|L],N2,V2,[bitPos(X,W)|M]) :-
   makeAllBits(L,N1,V1,M),
   N2 is N1+1,
   twoPower(N1,W),
   V2 is (V1+W).

%--------------------------------------------------------------------------------
%getBitString(+EPsBits:<list>,+EPs:<list>,-N:<int>)
%--------------------------------------------------------------------------------
%It maps a bag of EPs to a bitstring integer.
%It fails if some EPs are present more than once
%and if an EP was not given in the input bag (bitPos/2 would fail).
%--------------------------------------------------------------------------------
getBitString(_EPsBits,[],0).

getBitString(EPsBits,[EP1|EPs],BS) :-
   getBitString(EPsBits,EPs,BS2),
   member(bitPos(EP1,BS1),EPsBits),
   bs_disjoint(BS1,BS2),
   bs_union(BS1,BS2,BS).

%--------------------------------------------------------------------------------
%getMaxBitString(+EPsBits:<list>,-N:<int>)
%--------------------------------------------------------------------------------
%EPsBits is a list of bitpos(EP,BS)
%getMaxBitString/2 gets the bitstring value of a bag which would contain all the
%EPs found in EPsBits
%--------------------------------------------------------------------------------
getMaxBitString(L,EPs,BS) :-
   getMaxBitString(L,EPs,0,BS).

getMaxBitString([],[],BS,BS).
   
getMaxBitString([bitPos(EP1,BS1)|L],[EP1|K],BStemp,BS) :-
bs_disjoint(BS1,BStemp),
   bs_union(BS1,BStemp,BStemp2),
   getMaxBitString(L,K,BStemp2,BS).
      
%--------------------------------------------------------------------------------
%retrieveEPsBitString(+EPsBits:<list>,-EPs:<list>,-N:<int>)
%--------------------------------------------------------------------------------
%retrieves from a set EPsBits of bitPos(A,B) structures, via backtracking, all
%the possible bags of EPs (As) together with the corresponding bitString value
%of the bag
%--------------------------------------------------------------------------------
retrieveEPsBitString(EPsBits,EPs,BS) :-
   retrieveEPsBitString2(_List1,EPsBits,EPs,0,BS).

retrieveEPsBitString2([],[],[],BS,BS).

retrieveEPsBitString2([bitPos(EP1,BS1)|EPBits1],[bitPos(EP1,BS1)|EPBits],[EP1|L],BStemp,BS) :-
   bs_disjoint(BS1,BStemp),
   bs_union(BS1,BStemp,BStemp2),
   retrieveEPsBitString2(EPBits1,EPBits,L,BStemp2,BS).

retrieveEPsBitString2(L1,[_|EPBits],L,BStemp,BS) :-
   retrieveEPsBitString2(L1,EPBits,L,BStemp,BS).

%--------------------------------------------------------------------------------
%sameBags(+N:<int>,+M:<int>)
%--------------------------------------------------------------------------------
%(bitstring) bag equality
%--------------------------------------------------------------------------------
sameBags(N,N).

%--------------------------------------------------------------------------------
%bs_disjoint(+BitS1:<int>,+BitS2:<int>)
%--------------------------------------------------------------------------------
%(bitstring) bag disjunction
%--------------------------------------------------------------------------------
bs_disjoint(BitS1,BitS2) :-
    X is BitS1/\BitS2, X=0.

%--------------------------------------------------------------------------------
%bs_union(+BitS1:<int>,+BitS2:<int>,-NewBitS:<int>)
%--------------------------------------------------------------------------------
%(bitstring) bag union
%--------------------------------------------------------------------------------
bs_union(BitS1,BitS2,NewBitS) :-
NewBitS is BitS1\/BitS2.




%================================================================================
%Predicates for manipulating edges, chart and agenda
%================================================================================
%--------------------------------------------------------------------------------
%actEdge(+Edge:<edge>)  inactEdge(+Edge:<edge>)
%--------------------------------------------------------------------------------
%Definition/test of active and inactive edges
%--------------------------------------------------------------------------------
actEdge(edge(_Vertex,_Bag_EPs,_Words,_Cat,_Found,[_|_])).

inactEdge(edge(_Vertex,_Bag_EPs,_Words,_Cat,_Found,[])).

%--------------------------------------------------------------------------------
%getEdge(-Edge:<edge>)
%--------------------------------------------------------------------------------
%retrieves an edge from the agenda
%--------------------------------------------------------------------------------
getFromAgenda(edge(A,B,C,D,E,F)) :-
   gen_take(a_edge,edge(A,B,C,D,E,F)).

%--------------------------------------------------------------------------------
%getFromChart(-Edge:<edge>)
%--------------------------------------------------------------------------------
%retrieves an edge from the chart
%--------------------------------------------------------------------------------
getFromChart(edge(A,B,C,D,E,F)) :-
   gen_take(c_edge,edge(A,B,C,D,E,F)).

getFromChartCopy(edge(A,B,C,D,E,F)) :-
   gen_take(cc_edge,edge(A,B,C,D,E,F)).

%--------------------------------------------------------------------------------
%addToChart(+Edge:<edge>)   
%--------------------------------------------------------------------------------
%adds the edge Edge to the chart
%--------------------------------------------------------------------------------
addToChart(edge(A,B,C,D,E,F)) :-
   gen_save(c_edge,edge(A,B,C,D,E,F)).

%--------------------------------------------------------------------------------
%addToChartCopy(+Edge:<edge>)   
%--------------------------------------------------------------------------------
%adds the edge Edge to the chart copy
%--------------------------------------------------------------------------------
addToChartCopy(edge(A,B,C,D,E,F)) :-
   gen_save(cc_edge,edge(A,B,C,D,E,F)).

%--------------------------------------------------------------------------------
%addToAgenda(+Edge:<edge>)   
%--------------------------------------------------------------------------------
%adds the edge Edge to the Agenda
%--------------------------------------------------------------------------------
addToAgenda(edge(A,B,C,D,E,F)) :-
            (
             ( F == [] -> gen_set_phon(D,C), gen_complete_node(D,C,E) ; true ),
             gen_save(a_edge,edge(A,B,C,D,E,F)),
                (   F=[]
-> ( (dotMovementCheck(edge(A,B,C,D,E,F));true),
     (gen_empty_from_source(edge(A,B,C,D,E,F),Empty),
      dotMovementCheck(Empty);true))
                ;   true) )
        .

%--------------------------------------------------------------------------------
%initChart
%--------------------------------------------------------------------------------
%Chart Initialisation
%--------------------------------------------------------------------------------
initChart :-
   clearChart.

%--------------------------------------------------------------------------------
%Chart deletion
%--------------------------------------------------------------------------------
clearChart :- gen_clear(c_edge), gen_clear(cc_edge).

%--------------------------------------------------------------------------------
%Agenda deletion
%--------------------------------------------------------------------------------
clearAgenda :- gen_clear(a_edge).

%--------------------------------------------------------------------------------
%initAgenda(+EPsBits:<list>)
%--------------------------------------------------------------------------------
%Agenda Initialisation
%For empty rels, specialEdgesToAgenda is used
%--------------------------------------------------------------------------------
initAgenda(EPsBits) :-
   gen_bag_from_bits(EPsBits,Bag),gen_input_nodes(Bag,Nodes),
   initAgenda(EPsBits,Nodes).
initAgenda(EPsBits,Nodes) :-
   clearAgenda,
   (  (
initAgenda2(EPsBits,Nodes))
   -> true
   ;  true).

initAgenda2(EPsBits,Nodes):-
   gen_lexical_rels(Word,Ref-SVs,Rels,Vert),
   Vert=_-gen_context(EPsBits,Nodes),
   gen_resolve_lexical_types(Ref,Rels),
   gen_lexical_coverage(Rels,EPsBits,W_BitStr),
   W_BitStr > 0,
   gen_fully_deref(Ref,SVs,RefOut,SVsOut),
   gen_save(a_edge,edge(Vert,W_BitStr,[Word],RefOut-SVsOut,[],[])),
   fail.

%--------------------------------------------------------------------------------
%ignore special edges (i_se) or use them (u_se)
%--------------------------------------------------------------------------------
i_se:-retractall(seta(_)),assert(seta(no)).
u_se:-retractall(seta(_)),assert(seta(yes)).

seta(yes).

%--------------------------------------------------------------------------------
%specialEdgesToAgenda
%--------------------------------------------------------------------------------
%Special Edges Agenda Initialisation
%-For empty rels-
%--------------------------------------------------------------------------------
specialEdgesToAgenda :- specialEdgesToAgenda(_,_).
specialEdgesToAgenda(Context,Nodes) :-
   write('Adding special edges to the agenda...'),nl,
   (  (
specialEdgesToAgenda2(Context,Nodes))
   -> true
   ;  true).

specialEdgesToAgenda2(Context,Nodes):-
gen_lexical_rels(Word,Ref-SVs,Rels,Vert),
   Vert=_-gen_context(Context,Nodes),
   gen_match_lexical_rels(Rels,[]),
   gen_fully_deref(Ref,SVs,RefOut,SVsOut),
   gen_save(a_edge,edge(Vert,0,[Word],RefOut-SVsOut,[],[])),
   fail.

% A grammar may anchor semantic-transfer empty categories in an already
% selected overt category. This supplies finite valence and semantics before
% an empty daughter is combined, without consuming its anchor's EPs twice.
% Hook: generator_empty_anchor(EmptyPath,SourcePath,SourceDescription).
gen_empty_edge(Vertex,Bits,Words,Category,Found,Rest) :-
   gen_empty_edge_for(_-bot,Vertex,Bits,Words,Category,Found,Rest).

% Constrain the empty daughter before looking for its overt anchor. Otherwise
% every waiting rule rebuilds all anchored traces, including incompatible ones.
gen_empty_edge_for(Expected,Vertex,0,[],Category,[],[]) :-
   current_predicate(generator_empty_anchor,generator_empty_anchor(_,_,_)),
   generator_empty_anchor(EmptyPath,SourcePath,Description),
   empty_cat(_Number,0,FS,EmptyDtrs,Rule),
   gen_ud(FS-bot,Expected),
   add_to(Description,Restriction),
   gen_pathval(EmptyPath,FS,bot,Anchor,bot),
   gen_pathval(SourcePath,Restriction,bot,Anchor,bot),
   (gen_disjoint_edge(c_edge,0,Restriction-bot,edge(SourceVertex,Bits,[_|_],Source-_,_,[]))
   ;gen_disjoint_edge(a_edge,0,Restriction-bot,edge(SourceVertex,Bits,[_|_],Source-_,_,[]))),
   Bits>0, Source=Restriction,
   gen_resolve_empty_valence(FS,EmptyDtrs,SourceVertex),
   getEPsFromRef(FS,bot,_),
   gen_empty_derivation(FS,EmptyDtrs,Rule,Category),
   getVertex(FS-bot,Vertex),
   gen_share_context(SourceVertex,Vertex).

% A newly completed filler also enables empty daughters of older active edges.
% This is the converse of looking up an anchor when processing an active edge.
gen_empty_from_source(edge(SourceVertex,Bits,[_|_],Source-_,_,[]),
                      edge(Vertex,0,[],Category,[],[])) :-
   Bits>0,
   current_predicate(generator_empty_anchor,generator_empty_anchor(_,_,_)),
   generator_empty_anchor(EmptyPath,SourcePath,Description),
   add_to(Description,Restriction), Source=Restriction,
   gen_anchored_empty(EmptyPath,SourcePath,Source,SourceVertex,Vertex,Category).

gen_anchored_empty(EmptyPath,SourcePath,Source,SourceVertex,Vertex,Category) :-
   empty_cat(_Number,0,FS,EmptyDtrs,Rule),
   gen_pathval(SourcePath,Source,bot,Anchor,bot),
   gen_pathval(EmptyPath,FS,bot,Anchor,bot),
   gen_resolve_empty_valence(FS,EmptyDtrs,SourceVertex),
   getEPsFromRef(FS,bot,_),
   gen_empty_derivation(FS,EmptyDtrs,Rule,Category),
   getVertex(FS-bot,Vertex),
   gen_share_context(SourceVertex,Vertex).

% Argument attraction can leave an extracted verbal daughter's valence open
% inside an EFD-closed empty phrase. Anchor that daughter before constructing
% overt projections of the empty phrase. The path is grammar-specific.
gen_resolve_empty_valence(FS,Refs,Vertex) :-
   (current_predicate(generator_valence_path,generator_valence_path(_))
   -> generator_valence_path(Path),
      gen_resolve_empty_valence(FS,Refs,Vertex,Path)
   ; true).

gen_resolve_empty_valence(FS,[],Vertex,Path) :-
   (gen_closed_valence(FS,Path) -> true
   ; generator_empty_anchor(EmptyPath,SourcePath,Description),
     add_to(Description,Restriction),
     gen_pathval(EmptyPath,FS,bot,Anchor,bot),
     gen_pathval(SourcePath,Restriction,bot,Anchor,bot),
     (gen_disjoint_edge(c_edge,0,Restriction-bot,
                       edge(SourceVertex,Bits,[_|_],Source-_,_,[]))
     ;gen_disjoint_edge(a_edge,0,Restriction-bot,
                       edge(SourceVertex,Bits,[_|_],Source-_,_,[]))),
     Bits>0,Source=Restriction,
     gen_share_context(Vertex,SourceVertex),
     gen_closed_valence(FS,Path)).
gen_resolve_empty_valence(FS,[Ref|Refs],Vertex,Path) :-
   dtrs_feat_(Feature),gen_pathval([Feature],FS,bot,List,bot),
   getListFromFS(List,bot,Children),
   gen_resolve_empty_children([Ref|Refs],Children,Vertex,Path),
   gen_closed_valence(FS,Path).

gen_resolve_empty_children([],[],_,_).
gen_resolve_empty_children([empty(Number,Position)|Refs],[FS-_|Children],Vertex,Path) :-
   empty_cat(Number,Position,_,SubRefs,_),
   gen_resolve_empty_valence(FS,SubRefs,Vertex,Path),
   gen_resolve_empty_children(Refs,Children,Vertex,Path).

% EFD closure also embeds empty daughters directly in compiled rules.
% Resolve these after matching the overt daughter, so the governing verb has
% supplied the extracted verb's selectional constraints.
gen_resolve_empty_prefix(Prefix,Vertex) :-
   (current_predicate(generator_valence_path,generator_valence_path(_))
   -> generator_valence_path(Path),
      gen_resolve_empty_nodes(Prefix,Vertex,Path)
   ; true).
gen_resolve_empty_nodes([],_,_).
gen_resolve_empty_nodes([FS-gen_node(_,_,Daughters)|Rest],Vertex,Path) :-
   (Daughters=[] -> gen_resolve_empty_valence(FS,[],Vertex,Path)
   ; gen_resolve_empty_nodes(Daughters,Vertex,Path),gen_closed_valence(FS,Path)),
   gen_resolve_empty_nodes(Rest,Vertex,Path).

gen_closed_valence(FS,Path) :-
   gen_pathval(Path,FS,bot,List,bot),
   catch(getListFromFS(List,bot,_),
         error(generator_list(open_tail(_,_)),getListFromFS/3),fail).

%--------------------------------------------------------------------------------
%udList(+A:<list>,+B:<list>)
%--------------------------------------------------------------------------------
%unifies the element of two lists from left to right
%--------------------------------------------------------------------------------
udList([A],[B]) :- gen_ud(A,B).

udList([A|L],[B|M]) :-
   gen_ud(A,B),
   udList(L,M).

%--------------------------------------------------------------------------------
%udListReOrder(+A:<list>,+B:<list>,-C:<list>)
%--------------------------------------------------------------------------------
%it does kind of the same job as would be done by calling sameOrderRelsList and
%udList one after the other. Namely it unifies two lists, element by element,
%but in any possible order.
%--------------------------------------------------------------------------------
udListReOrder([FS1],[FS2]):- gen_ud(FS1,FS2).

udListReOrder([FS1|L],L2) :-
   select(FS2,L2,Rest2),
   gen_ud(FS1,FS2),
   udListReOrder(L,Rest2).

%--------------------------------------------------------------------------------
%isAWordSRels(-Word:<list>,-Cat:<FS>,-W_Bag:<FS>,-Vert:<FS>)         ?
%isAWordSRels(-Word:<list>,-Cat:<svs>,-W_Bag:<svs>,-Vert:<svs>)   ?
%--------------------------------------------------------------------------------
%Like isAWord/4 but fails if the Word has not a specified 'rels' value
%--------------------------------------------------------------------------------
isAWordSRels(Word,Tag-SVs,Word_Bag,Vertex) :-
   gen_lexical_rels(Word,Tag-SVs,Rels,Vertex),
   liszt_path(Path),
   catch(getListFromFS(Rels,bot,Word_Bag),
         error(generator_list(Problem),getListFromFS/3),
         throw(error(generator_list(Problem),lexical_rels(Word,Path)))).

gen_lexical_rels(Word,Tag-SVs,Rels,Index-gen_context(_,_)) :-
   lex(Word,Tag),
   SVs=gen_node(lexicon,[Word],[]),
   check_syntactic_object(Tag-SVs),
   gen_set_phon(Tag-SVs,[Word]),
   liszt_path(Path),
   gen_pathval(Path,Tag,SVs,Rels,bot),
   ind_path(IndexPath),
   gen_pathval(IndexPath,Tag,SVs,Index,bot).

% Demand the constraints that produce an open lexical RELS list before
% assigning an arbitrary input subset to its tail. Refine only finite types
% tested by an active suspension whose continuation refers to this list.
% Recursive domains (notably lists and signs) are never enumerated here.
gen_resolve_lexical_types(FS,Rels) :-
   ( catch((getListFromFS(Rels,bot,_),Closed=yes),
           error(generator_list(open_tail(_,_)),getListFromFS/3),Closed=no),
     Closed==yes
   -> true
   ; residuate_term(FS,Residue),
     ( gen_semantic_type_delay(Residue,Rels,Node,Types)
     -> member(Type,Types),
        add_to(Type,Typed),
        Node=Typed,
        gen_resolve_lexical_types(FS,Rels)
     ; true ) ).

gen_semantic_type_delay(Residue,Rels,Node,Types) :-
   gen_type_delay(Residue,_,Node,Goal),
   gen_contains_term(Goal,Rels,[]),
   deref(Node,_,Current,_),
   Current \== 0, Current \== bot,
   gen_finite_type(Current,[]),
   findall(Type,
           (gen_type_delay(Residue,Type,Other,Continuation),
            Other==Node, gen_contains_term(Continuation,Rels,[]),
            Type \== Current, sub_type(Current,Type)),Types0),
   sort(Types0,Types), Types=[_|_],
   !.

gen_type_delay((Left,Right),Type,FS,Goal) :-
   !, (gen_type_delay(Left,Type,FS,Goal);gen_type_delay(Right,Type,FS,Goal)).
gen_type_delay(prolog:when(_,_,user:when_type_delayed0(Type,FS,_,Goal)),Type,FS,Goal).

gen_contains_term(Term,Target,_) :- Term==Target, !.
gen_contains_term(Term,Target,Seen) :-
   compound(Term), \+ gen_list_seen(Term,Seen),
   functor(Term,_,Arity),
   gen_contains_arg(Arity,Term,Target,[Term|Seen]).
gen_contains_arg(N,Term,Target,Seen) :-
   N>0,
   (arg(N,Term,Arg),gen_contains_term(Arg,Target,Seen)
   ; M is N-1,gen_contains_arg(M,Term,Target,Seen)), !.

gen_finite_type(Type,Seen) :-
   \+ memberchk(Type,Seen),
   findall(Restriction,
           (sub_type(Type,Sub),approp(_,Sub,Restriction)),Restrictions0),
   sort(Restrictions0,Restrictions),
   gen_finite_types(Restrictions,[Type|Seen]).
gen_finite_types([],_).
gen_finite_types([Type|Types],Seen) :-
   gen_finite_type(Type,Seen),
   gen_finite_types(Types,Seen).

% Match lexical relations directly against unused input occurrences. Enumerating
% every input subset first is exponential even for a one-relation word.
% Each selection consumes one occurrence, so delayed/open lexical lists remain
% bounded by the input. Unification can wake constraints before the next step.
gen_lexical_coverage(Rels,_Available,0) :-
   add_to(e_list,Empty),
   Rels=Empty.
gen_lexical_coverage(Rels,Available,Bits) :-
   Available=[_|_],
   add_to(ne_list,Nonempty),
   Rels=Nonempty,
   gen_pathval([hd],Rels,bot,Head,bot),
   select(bitPos(EP,Bit),Available,Rest),
   gen_ud(Head-bot,EP),
   gen_pathval([tl],Rels,bot,Tail,bot),
   gen_lexical_coverage(Tail,Rest,TailBits),
   bs_union(Bit,TailBits,Bits).

% The input bag bounds traversal. Unifying each relation immediately can
% wake lexical constraints (coord_sem) that determine the remaining list.
% Sharing and suspensions stay on the lexical feature structure.
gen_match_lexical_rels(Rels,[]) :-
   add_to(e_list,Empty),
   Rels=Empty.
gen_match_lexical_rels(Rels,Bag) :-
   Bag=[_|_],
   add_to(ne_list,Nonempty),
   Rels=Nonempty,
   gen_pathval([hd],Rels,bot,Head,bot),
   select(EP,Bag,Rest),
   gen_ud(Head-bot,EP),
   gen_pathval([tl],Rels,bot,Tail,bot),
   gen_match_lexical_rels(Tail,Rest).


%--------------------------------------------------------------------------------
%check_syntactic_object(+Cat:<FS>)
%--------------------------------------------------------------------------------
%checks if the word found is not a stem...
%--------------------------------------------------------------------------------
check_syntactic_object(Tag-_SVs):-
   deref(Tag,_,Type,_),
   u_syntactic_object(SO),
   unify_type(Type,SO,_Res).

%--------------------------------------------------------------------------------
%syntactic_object(+Cat:<FS>)
%--------------------------------------------------------------------------------
%This is made modifyable by the user, if the user does not use this type...
%--------------------------------------------------------------------------------
u_syntactic_object(syntactic_object).

syntactic_object_act:-
   current_predicate(syntactic_object,syntactic_object(_))
   -> syntactic_object(L),
      retractall(u_syntactic_object(_)),
      assert(u_syntactic_object(L))
   ;  true.

%--------------------------------------------------------------------------------
%getEPsFromRef(+Tag:<ref>,+SVs:<svs>,-Bag:<list>)
%--------------------------------------------------------------------------------
%Bag is the list of EPs corresponding to the ale-list of EPs found in the
%semantics of the sign Tag-SVs
%--------------------------------------------------------------------------------
getEPsFromRef(Tag,SVs,Bag) :-
   getRelsFromRef(Tag,SVs,Ref2,SVs2),
   getListFromFS(Ref2,SVs2,Bag).

%--------------------------------------------------------------------------------
%getRelsFromRef(+Tag:<ref>,-SVs:<svs>,-Ref2:<ref>,-SVs2:<svs>)
%--------------------------------------------------------------------------------
%Ref2-SVs2 is the liszt part of the sign Tag-SVs
%--------------------------------------------------------------------------------
getRelsFromRef(Tag,SVs,Ref2,SVs2) :-
   liszt_path(L),
   gen_pathval(L,Tag,SVs,Ref2,SVs2).

%--------------------------------------------------------------------------------
%getListFromRef(+Tag:<ref>,+SVs:<svs>,-List:<list>)
%--------------------------------------------------------------------------------
%List is the prolog list corresponding to the ale-list Tag-SVs
%--------------------------------------------------------------------------------
getListFromFS(FS,SVs,List) :-
   gen_read_closed_list(FS,SVs,List,[]).

% Read an existing finite list, rather than creating its spine with pathval.
% On an open tail, looking up HD/TL would force another ne_list indefinitely.
% Test the actual FS first, and preserve all its element sharing/constraints.
gen_read_closed_list(FS,SVs,List,Seen) :-
   deref(FS,_,Type,_),
   ( gen_list_seen(FS,Seen)
   -> throw(error(generator_list(cyclic),getListFromFS/3))
   ; Type \== 0, sub_type(e_list,Type)
   -> List=[]
   ; Type \== 0, sub_type(ne_list,Type)
   -> List=[Head-HeadSVs|Rest],
      gen_pathval([hd],FS,SVs,Head,HeadSVs),
      gen_pathval([tl],FS,SVs,Tail,TailSVs),
      gen_read_closed_list(Tail,TailSVs,Rest,[FS|Seen])
   ; length(Seen,Position),
     throw(error(generator_list(open_tail(Position,Type)),getListFromFS/3))
   ).

gen_list_seen(FS,[Seen|_]) :- FS == Seen, !.
gen_list_seen(FS,[_|Seen]) :- gen_list_seen(FS,Seen).

%--------------------------------------------------------------------------------
%to rebuild the chart from the chart copy
%--------------------------------------------------------------------------------
rebuild_chart:-
   (  rebuild_chart2
   -> true
   ; true).

rebuild_chart2:-
   getFromChartCopy(edge(A,B,C,D,E,F)),
   addToChart(edge(A,B,C,D,E,F)),
   fail.



%================================================================================
%Predicates for grammar rules access and special treatment of modification 
%================================================================================
%--------------------------------------------------------------------------------
%grRule(-RuleName:<atom>,-FS:<fs>,-DtrsList:<list>) :-
%--------------------------------------------------------------------------------
%To retrieve grammar rules from the grammar
%--------------------------------------------------------------------------------
grRule(Name,Mother,DtrsList) :-
   secret_noadderrs_toggle(OldMode),
   gen_rule_candidate(Name,Mother,DtrsList),
   secret_adderrs_toggle(OldMode).

gen_rule_candidate(Name,TagMoth-gen_node(Name,_,_),DtrsList) :-
 clause(alec_rule(Name,DtrsDesc,_,Moth,Residue,EmptyRefs,EmptyRefsRest,Store,StoreRest),true),
   call(Residue),
   satisfy_dtrs(DtrsDesc,_DtrCats,[],NativeDtrs,gdone),
   gen_wrap_dtrs(NativeDtrs,OvertDtrs),
   gen_rule_empty_prefix(Store,StoreRest,EmptyRefs,EmptyRefsRest,DtrsList,OvertDtrs),
   add_to(Moth,TagMoth).

% EFD-closed rules retain their consumed empty daughters in a difference
% list. Keep those daughters in the derivation and in its daughter numbering.
gen_rule_empty_prefix(Store,Rest,Refs,RefsRest,Dtrs,Dtrs) :-
   Store==Rest, Refs==RefsRest, !.
gen_rule_empty_prefix([FS|Store],Rest,[empty(Number,Position)|Refs],RefsRest,
                      [empty>Category|Dtrs],Overt) :-
   empty_cat(Number,Position,_,Children,Rule),
   gen_empty_derivation(FS,Children,Rule,Category),
   gen_rule_empty_prefix(Store,Rest,Refs,RefsRest,Dtrs,Overt).

% Empty categories may themselves be derived phrases. Their reference tree
% comes from TRALE's empty-category closure; use the actual daughter AVMs of
% this instance so the displayed subtree retains all parent/child sharing.
gen_empty_derivation(FS,[],Rule,FS-gen_node(Rule,[],[])).
gen_empty_derivation(FS,[Ref|Refs],Rule,FS-gen_node(Rule,[],Children)) :-
   dtrs_feat_(Feature),
   gen_pathval([Feature],FS,bot,List,bot),
   getListFromFS(List,bot,NativeChildren),
   gen_empty_children([Ref|Refs],NativeChildren,Children).

gen_empty_children([],[],[]).
gen_empty_children([empty(Number,Position)|Refs],[FS-_|Native],
                   [Category|Children]) :-
   empty_cat(Number,Position,_,Dtrs,Rule),
   gen_empty_derivation(FS,Dtrs,Rule,Category),
   gen_empty_children(Refs,Native,Children).

gen_split_empty_prefix([empty>FS|Dtrs],[FS|Found],Overt) :-
   !, gen_split_empty_prefix(Dtrs,Found,Overt).
gen_split_empty_prefix(Dtrs,[],Dtrs).

%-------------------------------------------------------------------------------
%u_modRules(+L:<list>)
%-------------------------------------------------------------------------------
%predicate which may be re-defined by the user via mod_rules/1.
%It says to the generator that no grammar rule perform modification
%--------------------------------------------------------------------------------
u_modRules([]).

%-------------------------------------------------------------------------------
%mod_rules_act(+L:<list>)
%-------------------------------------------------------------------------------
%allows the user to specify the rules performing modification.
%(L is a list of grammar rule names)
%It changes the asserted value of u_modRules/1
%-------------------------------------------------------------------------------
mod_rules_act:-
   current_predicate(mod_rules,mod_rules(_))
   -> mod_rules(L),
      retractall(u_modRules(_)),
      assert(u_modRules(L))
   ;  true.

%--------------------------------------------------------------------------------
%isARule(-Moth:<fs>,-DtrsList:<fs>,-RuleName:<atom>)
%--------------------------------------------------------------------------------
%It succeeds if the grammar contains a rule building the FS Moth from the list
%of daughteres DtrsList.
%It only succeeds for non-modification rules when modifiers edges have not
%come back to the agenda. And it only succeeds for modification rules when
%modifiers edges have come back to the agenda.
%--------------------------------------------------------------------------------
isARule(Moth,DtrsList,Name) :-
   (  u_st_mod(no)
   -> ( non_mod_grRule(Name,Moth,DtrsList) ; (current_predicate(mod_grRule,mod_grRule(_,_,_)),mod_grRule(Name,Moth,DtrsList)) )
   ;
      (
        (  toggleModification(yes)
        -> ( (current_predicate(mod_grRule,mod_grRule(_,_,_)),mod_grRule(Name,Moth,DtrsList)) ; non_mod_grRule(Name,Moth,DtrsList) )
        ;  non_mod_grRule(Name,Moth,DtrsList)
        )
      )
   ).

%--------------------------------------------------------------------------------
%modRule(-RuleName:<atom>)
%--------------------------------------------------------------------------------
%Used to check if a rule is said as performing modification
%--------------------------------------------------------------------------------
modRule(RuleName):-
   u_modRules(L),
   member(RuleName,L).

%--------------------------------------------------------------------------------
%stores the modification and non-modification rules separately as
%[non_]mod_grRule/3  clauses.
%--------------------------------------------------------------------------------
sortRules :-
   gen_clear(mod_grRule),
   gen_clear(non_mod_grRule),
   sortRules1.

sortRules1:-
   ( sortRules2 -> true ; true ).

sortRules2 :-
   grRule(Name,Moth,DtrsList),
   ( (
      modRule(Name))
   ->
     (
      gen_save(mod_grRule,rule(Name,Moth,DtrsList)) )
   ;
     (
      gen_save(non_mod_grRule,rule(Name,Moth,DtrsList)) )
   ),
   fail.

%--------------------------------------------------------------------------------
%initialises the modification mechanism:
%stores the modification and non-modification rules separately
%determines the modifiers categories
%--------------------------------------------------------------------------------
initMod :-
   retractall(toggleModification(_)),
   assert(toggleModification(no)),
   mod_cats_act,
   mod_rules_act,
   sortRules.


%--------------------------------------------------------------------------------
%specifies the modifiers descriptions
%it would enable to only bring back to the agenda the edges that correspond to a
%potential modifier
%--------------------------------------------------------------------------------
modCat(Tag-SVs):-
   u_modCats(L),     
   member(Type,L),
   pos_path(M),
   gen_pathval(M,Tag,SVs,Ref2,_SVs2),
   deref(Ref2,_,Type2,_),
   unify_type(Type2,Type,_Res).

mod_cats_act:-
   current_predicate(mod_cats,mod_cats(_))
   -> mod_cats(L),
      retractall(u_modCats(_)),
      assert(u_modCats(L))
   ;  true.

u_modCats([]).

%--------------------------------------------------------------------------------
%To switch on or off the special treatment of modification
%--------------------------------------------------------------------------------
u_st_mod(no).

st_mod_act:-
   current_predicate(st_mod,st_mod(_))
   -> st_mod(K),
      retractall(u_st_mod(_)),
      assert(u_st_mod(K))
   ;  true.

st_mod:-
   retractall(u_st_mod(_)),
   assert(u_st_mod(yes)).

no_st_mod:-
   retractall(u_st_mod(_)),
   assert(u_st_mod(no)).

%--------------------------------------------------------------------------------
%When all edges have been processed excluding modification, then
%toggleModification/0 puts modifiers edges back into the agenda and toggles
%modification rules.
%--------------------------------------------------------------------------------
toggleModification :-
   (  (u_st_mod(yes), u_modCats([_|_]))
   -> write('Bringing back modification edges to the agenda'),nl,
      toggleModification1,
      rebuild_chart
   ;  true
   ),
   retractall(toggleModification(_)),
   assert(toggleModification(yes)).

toggleModification1 :-
   (  toggleModification2
   -> true
   ;  true).

toggleModification2 :-
     getFromChart(edge(Vert,W_BitStr,Word,Cat,Found,[])), 
     (  modCat(Cat)
     -> addToAgenda(edge(Vert,W_BitStr,Word,Cat,Found,[]))
     ;  addToChartCopy(edge(Vert,W_BitStr,Word,Cat,Found,[])) ),
     fail.



%================================================================================
%Generation predicates
%================================================================================
%--------------------------------------------------------------------------------
%start Symbol
%--------------------------------------------------------------------------------
startSymbol(Tag-SVs):-
      u_gen_root(Root),
      gen_add_to(Root,TagRoot,bot),
      gen_ud(TagRoot-bot,Tag-SVs).

%--------------------------------------------------------------------------------
%to enable the user to specify the categories of the generated FS
%--------------------------------------------------------------------------------
u_gen_root(R):-root_symbol(R).

gen_root_act:-
   current_predicate(gen_root,gen_root(_))
   -> gen_root(Desc), %gen_root might be put in theory.pl by the user to change from default
      retractall(u_gen_root(_)),
      assert(u_gen_root(Desc))
   ;  true.

%--------------------------------------------------------------------------------
%g(+Cat:<desc>,-Words:<list>,+Root:<desc>,+Query:<atom>)
%--------------------------------------------------------------------------------
%Words is a list representing the sentence generated from Cat, corresponding to
%the description Root, with Query enabling to switch query_proceed on and off
%--------------------------------------------------------------------------------
g(Cat,Words,Root,Query):-
   gen_add_to(Cat,Tag,bot),
   residuate_term(Tag,Frozen),
   (gen_portray_fs('INITIAL CATEGORY',Tag,Frozen) -> true
   ; nl, write('INITIAL CATEGORY: '), nl, ttyflush,
     gen_pp_fs_res(Tag,bot,Frozen), nl
   ),
   % slgGen prints each completed result with its own PHON and daughters.
   % Tag is only the input specification, not a generated final category.
   slgGen(Tag,bot,Words,Root,Query).

%--------------------------------------------------------------------------------
%Other versions of g(Cat,Words,Root,Query)
%--------------------------------------------------------------------------------
g(Cat):-
        u_gen_root(Root),
        g(Cat,_Words,Root,query).

g_d(Cat,Root):-
        g(Cat,_Words,Root,query).

g_d(Cat,Words,Root):-
        g(Cat,Words,Root,query).

g(Cat,Words):-
        u_gen_root(Root),
        g(Cat,Words,Root,query).

%--------------------------------------------------------------------------------
%use_root(+R:<desc>)
%--------------------------------------------------------------------------------
%to select to what kind of description the generation output has to correspond to
%--------------------------------------------------------------------------------
use_root(R):-
        retractall(u_gen_root(_)),
        assert(u_gen_root(R)).

%--------------------------------------------------------------------------------
%to switch on and off the query_proceed during generation
%(useful for test suites)
%--------------------------------------------------------------------------------
output_query(yes).

no_query_act:-
        retractall(output_query(_)),
        assert(output_query(no)).

query_act:-
        retractall(output_query(_)),
        assert(output_query(yes)).

%--------------------------------------------------------------------------------
%slgGen(+Tag:<ref>,+SVs:<svs>,-Words:<list>,+Root:<desc>)
%--------------------------------------------------------------------------------
%Words is a phrase generated from Tag-SVs, and corresponding to description Root
%Query enables to switch proceed_query on and off
%--------------------------------------------------------------------------------
slgGen(Tag,SVs,Words,Root,Query) :-
        ( (var(Query) ; Query=query) -> query_act ; no_query_act),
        u_gen_root(R),
        (var(Root) -> true ; use_root(Root)),
        slgGen1(Tag,SVs,Words),
        use_root(R).

%--------------------------------------------------------------------------------
%Other versions of slgGen(Tag,SVs,Words,Root,Query)
%--------------------------------------------------------------------------------
slgGen(Tag,SVs,Words,Root):-
        slgGen(Tag,SVs,Words,Root,query).

slgGen(Tag,SVs,Words) :-
        query_act,
        gen_root_act,
        slgGen1(Tag,SVs,Words).

%--------------------------------------------------------------------------------
%slgGen1(+Tag:<ref>,+SVs:<svs>,-Words:<list>)
%--------------------------------------------------------------------------------
%Words is a sentence or phrase generated from Tag-SVs
%This predicate is called by slgGen predicates (they do some initialisation before)
%--------------------------------------------------------------------------------                
slgGen1(Tag,SVs,Words) :-
   statistics(runtime,[StartTime,_]),
   retractall(stopg),
   initGenWords,
   syntactic_object_act,
   st_mod_act,
   write('Initialising the bitstrings...'),nl,
   getEPsFromRef(Tag,SVs,Bag),
   gen_input_nodes(Bag,Nodes),
   makeAllBits(Bag,AllBits,EPsBits),
   write('Initialising the modification treatment...'),nl,
   initMod,
   write('Initialising the chart...'),nl,   
   initChart,
   write('Building the agenda...'),nl,
   initAgenda(EPsBits,Nodes),
   (seta(yes)->specialEdgesToAgenda(EPsBits,Nodes);true),
   write('Generating new edges...'),nl,
   ( slgGenProc(Words,AllBits,EPsBits,Tag,SVs)
   ; gen_report_statistics(StartTime), gen_words(Words)
   ).

% Count index records without copying FSs or waking delayed constraints.
% CPU time includes initialisation and output, but excludes parsing and
% waiting for the user at the next-result prompt.
gen_report_statistics(StartTime) :-
   statistics(runtime,[EndTime,_]),
   Seconds is (EndTime-StartTime)/1000,
   findall(State,gen_store_index(c_edge,edge(_,State,_),_),States),
   gen_count_chart(States,0,0,Active,Inactive),
   Total is Active+Inactive,
   format('~nGeneration: ~3f s CPU time.~n',[Seconds]),
   format('Chart: ~d edges (~d active, ~d inactive).~n',
          [Total,Active,Inactive]).

gen_count_chart([],Active,Inactive,Active,Inactive).
gen_count_chart([active|Rest],A,I,Active,Inactive) :-
   Next is A+1,gen_count_chart(Rest,Next,I,Active,Inactive).
gen_count_chart([complete|Rest],A,I,Active,Inactive) :-
   Next is I+1,gen_count_chart(Rest,A,Next,Active,Inactive).

% Preserve the distinct variable identities of an input MRS across copies.
% Each edge carries the same ordered reference nodes; aligning contexts and
% rejecting collapsed nodes keeps distinct input variables distinct without
% installing quadratic networks of delayed inequality constraints.
% Grammars with other semantic reference sorts may override the default names.
gen_input_nodes(Bag,Nodes) :-
   (current_predicate(generator_identity_types,generator_identity_types(_))
   -> generator_identity_types(Types) ; Types=[index,event,handle]),
   gen_input_references(Bag,Types,[],Nodes).
gen_input_references([],_,Nodes,Nodes).
gen_input_references([FS-_|Rest],Types,Seen,Nodes) :-
   deref(FS,_,Type,_),approps(Type,Features,_),
   gen_reference_features(Features,FS,Types,Seen,Next),
   gen_input_references(Rest,Types,Next,Nodes).
gen_reference_features([],_,_,Nodes,Nodes).
gen_reference_features([Feature:_|Rest],FS,Types,Seen,Nodes) :-
   gen_pathval([Feature],FS,bot,Value,bot),
   deref(Value,_,Type,_),
   (gen_reference_type(Type,Types),\+gen_list_seen(Value,Seen)
   -> Next=[Value|Seen] ; Next=Seen),
   gen_reference_features(Rest,FS,Types,Next,Nodes).
gen_reference_type(Type,Types) :-
   Type \== 0, member(Super,Types),type(Super),sub_type(Super,Type), !.
gen_bag_from_bits([],[]).
gen_bag_from_bits([bitPos(EP,_)|Bits],[EP|Bag]) :- gen_bag_from_bits(Bits,Bag).

gen_valid_vertex(_-bot).
gen_valid_vertex(_-gen_context(_,Nodes)) :-
   (var(Nodes) -> true ; gen_distinct_nodes(Nodes)).
gen_distinct_nodes([]).
gen_distinct_nodes([Node|Nodes]) :-
   \+gen_list_seen(Node,Nodes),gen_distinct_nodes(Nodes).
gen_valid_stored(edge(Vertex,_,_,_,_,_)) :- !,gen_valid_vertex(Vertex).
gen_valid_stored(_).

%--------------------------------------------------------------------------------
%slgGenProc(-S:<list>,+AllBits:<int>,+EPsBits:<list>,+Ref:<ref>,+SVs:<svs>)
%--------------------------------------------------------------------------------
%Processes one by one the edges in the agenda
%--------------------------------------------------------------------------------
slgGenProc(S,AllBits,EPsBits,Ref,SVs) :-
(stopg -> fail ; true),
   ( (getFromAgenda(Edge),
      Edge=edge(_,_W_B,_Words,_,_,_)
     )
   ->
     ( addToChart(Edge),
       (
         slgGenEdgeProc(Edge,AllBits,S,Ref,SVs)
       ;
         slgGenProc(S,AllBits,EPsBits,Ref,SVs)
       )
      )
;
( toggleModification(no)
     ->
( toggleModification,
slgGenProc(S,AllBits,EPsBits,Ref,SVs)
       )
     )
   ).

%--------------------------------------------------------------------------------
%slgGenEdgeProc(Edge:<edge>,-S:<list>,+AllBits:<int>,+Words:<list>,+Ref:<ref>,+SVs:<svs>)
%--------------------------------------------------------------------------------
%Generation succeeds if:
%- the edge spans the entire Bag
%- its Cat is a start symbol
%--------------------------------------------------------------------------------
slgGenEdgeProc(edge(Vertex,W_Bag,Words,Tag-SVs,_,[]),AllBits,Words,_Ref,_SVs2) :-
   sameBags(W_Bag,AllBits),
   startSymbol(Tag-SVs),
   gen_valid_vertex(Vertex),
   add_words(Words),
   residuate_term(Tag,Frozen),
   (gen_portray_result(Tag-SVs,Frozen) -> true
    ; nl, ttyflush,
      gen_pp_fs_res(Tag,SVs,Frozen), nl
   ),
   write(Words),nl,
   % In the grammar's no-questions mode, enumerate all realisations.
   (  (output_query(yes), ale_flag(another,Limit), Limit \== 0)
   -> query_proceed, assert(stopg)
   ;  true
   ),
fail.

%--------------------------------------------------------------------------------
%Invocate Grammar Rules on the inactive edge
%--------------------------------------------------------------------------------
slgGenEdgeProc(edge(V,W_B,Words,Cat,Found,[]),_AllBits,_S,_,_) :-
   ruleInvocation(edge(V,W_B,Words,Cat,Found,[])).

%--------------------------------------------------------------------------------
%Perform Dot Movement on the active edge
%--------------------------------------------------------------------------------
slgGenEdgeProc(edge(V,W_B,Words,Cat,Found,[X|Cats]),_AllBits,_S,_,_) :-
   dotMovement(edge(V,W_B,Words,Cat,Found,[X|Cats])).

%--------------------------------------------------------------------------------
%removeGoal(-L1:<list>,-L2:<list>).
%--------------------------------------------------------------------------------
%L1 is a list of elements like: cat>_, cats>_, sem_head>_, goal>_
%L2 is the same list, with the goals removed
%--------------------------------------------------------------------------------
removeGoal([],[]).

removeGoal([empty>FS|Rest],[empty>FS|Rest2]) :-
   removeGoal(Rest,Rest2).

removeGoal([cat>Cat|Rest],[cat>Cat|Rest2]):-
   removeGoal(Rest,Rest2).

removeGoal([sem_head>Cat|Rest],[sem_head>Cat|Rest2]):-
   removeGoal(Rest,Rest2).

removeGoal([cats>Cat|Rest],[cats>Cat|Rest2]):-
   removeGoal(Rest,Rest2).

removeGoal([goal>_Cat|Rest],Rest2):-
   removeGoal(Rest,Rest2).

%--------------------------------------------------------------------------------
%getVertex(+FS1:<fs>,-FS2:<fs>)
%--------------------------------------------------------------------------------
%FS2 it the vertex of FS1
%--------------------------------------------------------------------------------
getVertex(Tag-SVs,Tag2-gen_context(_,_)):-
   ind_path(L),
   gen_pathval(L,Tag,SVs,Tag2,bot).

%--------------------------------------------------------------------------------
%instanciate_dtrs(+N:<int>,+MRef:<ref>,+MSVs:<svs>,+Cat:<fs>)
%--------------------------------------------------------------------------------
%it unifies the Nth daughter of MRef-MSVs with Cat
%--------------------------------------------------------------------------------
instanciate_dtrs(N,MRef,MSVs,Cat) :-
   ( gen_dtrs_feature(MRef,Feat) ->
     gen_pathval([Feat],MRef,MSVs,DRef,DSVs),
     gen_daughter_at(N,DRef,DSVs,Cat)
   ; true
   ).

instanciate_dtrs(N,MRef-MSVs,Cat) :-
   instanciate_dtrs(N,MRef,MSVs,Cat).

gen_daughter_at(1,FS,SVs,Cat) :-
   gen_pathval([hd],FS,SVs,Daughter,DaughterSVs),
   gen_ud(Daughter-DaughterSVs,Cat).
gen_daughter_at(N,FS,SVs,Cat) :-
   N>1,
   gen_pathval([tl],FS,SVs,Tail,TailSVs),
   M is N-1,
   gen_daughter_at(M,Tail,TailSVs,Cat).

instanciate_dtrs_end(N,MRef,MSVs) :-
   ( gen_dtrs_feature(MRef,Feat) ->
     gen_pathval([Feat],MRef,MSVs,DRef,DSVs),
     gen_finish_dtrs(N,DRef,DSVs)
   ; true
   ).

% Rule descriptions can share values with daughters without introducing DTRS
% on the mother (e.g. inf_zu with a complex_word mother). The generator's
% gen_node metadata still records all children; do not force an AVM feature
% that the signature does not license. Existing DTRS constraints remain active.
gen_dtrs_feature(FS,Feat) :-
   dtrs_feat_(Feat),
   get_type(FS,Type),approps(Type,Features,_),memberchk(Feat:_,Features).

instanciate_dtrs_end(N,MRef-MSVs) :-
   instanciate_dtrs_end(N,MRef,MSVs).

% Close the existing daughter spine in place. Rebuilding and unifying another
% list can wake collect_rels/collect_hcons before its tail is identified, causing
% unbounded alternatives even when the original daughter list is already closed.
gen_finish_dtrs(0,FS,_) :-
   deref(FS,_,Type,_),
   (Type \== 0,sub_type(e_list,Type) -> true
   ;add_to(e_list,Empty),FS=Empty).
gen_finish_dtrs(N,FS,SVs) :-
   N>0,
   deref(FS,_,Type,_),
   (Type \== 0,sub_type(ne_list,Type) -> true
   ;add_to(ne_list,Cell),FS=Cell),
   gen_pathval([tl],FS,SVs,Tail,TailSVs),
   M is N-1,
   gen_finish_dtrs(M,Tail,TailSVs).

%--------------------------------------------------------------------------------
%Rule Invocation
%--------------------------------------------------------------------------------
%-
%--------------------------------------------------------------------------------
ruleInvocation(edge(V,W_B,Words,Cat,_Found,[])) :-
   isARule(MRef-MSVs,Cats,_Name),
   removeGoal(Cats,AllCats),
   gen_split_empty_prefix(AllCats,Prefix,[Kind>Cat1|Rest]),
   length(Prefix,Before), N is Before+1,
   append(Prefix,[Cat],Found),
   (  Rest=[]
   -> getVertex(MRef-MSVs,NewV)
   ; ( Rest=[_Kind2>Cat2|_],
       getVertex(Cat2,NewV))),
   gen_share_context(V,NewV),
   ((Kind=cats) -> copyFS(Cat1,CopyCat1) ; true),
   gen_ud(Cat,Cat1),
   gen_resolve_empty_prefix(Prefix,V),
   instanciate_dtrs(N,MRef-MSVs,Cat),
   gen_fully_deref(MRef,MSVs,MRefOut,MSVsOut),
   (   Kind=cats
   -> (
        copyFS(MRefOut-MSVsOut,MFS),
        addToAgenda(edge(NewV,W_B,Words,MFS,Found,[cats>CopyCat1|Rest])))
   ;   true),
   (   Rest=[]
   -> (
       instanciate_dtrs_end(N,MRefOut-MSVsOut))
   ;   true),
   addToAgenda(edge(NewV,W_B,Words,MRefOut-MSVsOut,Found,Rest)),
   fail.

%--------------------------------------------------------------------------------
%Dot Movement
%(more than one Cat left:
%in this case, the new vertex comes from the next Cat needed)
%--------------------------------------------------------------------------------
% An overt constituent may contribute no EPs (e.g. a personal pronoun).
% It must still be allowed to combine with an anchored empty daughter.
dotMovement(edge(V,W_B,Words,Cat,Found,[Kind>FS1,Kind2>FS2|Cats])) :-
   (  gen_disjoint_edge(c_edge,W_B,FS1,edge(V1,W_B1,Words1,Ref1-SVs1,_Found1,[]))
   ;  gen_disjoint_edge(a_edge,W_B,FS1,edge(V1,W_B1,Words1,Ref1-SVs1,_Found1,[]))
   ;  Words=[_|_], gen_empty_edge_for(FS1,V1,W_B1,Words1,Ref1-SVs1,_Found1,[])),
gen_ud(V,V1),
   ((Kind=cats) -> copyFS(FS1,CopyFS1) ; true),
   gen_ud(Ref1-SVs1,FS1),
length(Found,Length),
N is Length+1,
   bs_disjoint(W_B,W_B1),
   bs_union(W_B,W_B1,NewW_B),
   getVertex(FS2,NewV), gen_share_context(V,NewV),
instanciate_dtrs(N,Cat,Ref1-SVs1),
   append(Words,Words1,NewWords),
   gen_fully_deref(Ref1,SVs1,Ref1Out,SVs1Out),
   append(Found,[Ref1Out-SVs1Out],NewFound),
   addToAgenda(edge(NewV,NewW_B,NewWords,Cat,NewFound,[Kind2>FS2|Cats])),
   (  Kind=cats
   -> (
      getVertex(CopyFS1,NewV2), gen_share_context(V,NewV2),
      addToAgenda(edge(NewV2,NewW_B,NewWords,Cat,NewFound,[cats>CopyFS1,Kind2>FS2|Cats])))
   ),
   fail.

%--------------------------------------------------------------------------------
%Dot Movement
%(only one Cat left:
%in this case, the vertex comes from the cat of the new inactive edge created)
%--------------------------------------------------------------------------------
dotMovement(edge(V,W_B,Words,Cat,Found,[Kind>FS1])) :-
   (  gen_disjoint_edge(c_edge,W_B,FS1,edge(V1,W_B1,Words1,Ref1-SVs1,_Found1,[]))
   ;  gen_disjoint_edge(a_edge,W_B,FS1,edge(V1,W_B1,Words1,Ref1-SVs1,_Found1,[]))
   ;  Words=[_|_], gen_empty_edge_for(FS1,V1,W_B1,Words1,Ref1-SVs1,_Found1,[])),
   gen_ud(V,V1),
   ((Kind=cats) -> copyFS(FS1,CopyFS1) ; true),
   gen_ud(Ref1-SVs1,FS1),
   length(Found,Length),
   N is Length+1,
   bs_disjoint(W_B,W_B1),
   bs_union(W_B,W_B1,NewW_B),
   getVertex(Cat,NewV), gen_share_context(V,NewV),
   instanciate_dtrs(N,Cat,Ref1-SVs1),
   append(Words,Words1,NewWords),
      gen_fully_deref(Ref1,SVs1,Ref1Out,SVs1Out),
   append(Found,[Ref1Out-SVs1Out],NewFound),
   (  Kind=cats
   -> (
        getVertex(CopyFS1,NewV2), gen_share_context(V,NewV2),
        copyFS(Cat,CopyCat),
       addToAgenda(edge(NewV2,NewW_B,NewWords,CopyCat,NewFound,[cats>CopyFS1])))
   ; true
   ),
instanciate_dtrs_end(N,Cat),
   addToAgenda(edge(NewV,NewW_B,NewWords,Cat,NewFound,[])),
   fail.

%--------------------------------------------------------------------------------
%Dot Movement Check
%When a new inactive edge is created, then check dot movement for all old active
%edges (i.e. active edges that are in the chart)
%--------------------------------------------------------------------------------
dotMovementCheck(edge(V1,W_B1,Words1,Ref1-SVs1,_Found1,[])) :-
   gen_disjoint_edge(c_edge,W_B1,Ref1-SVs1,edge(V,W_B,Words,Cat,Found,[Kind>FS1,Kind2>FS2|Cats])),
   gen_ud(V,V1),
   ((Kind=cats) -> copyFS(FS1,CopyFS1) ; true),     
   gen_ud(FS1,Ref1-SVs1),
   length(Found,Length),
   N is Length+1,
   bs_disjoint(W_B,W_B1),
   bs_union(W_B,W_B1,NewW_B),
   getVertex(FS2,NewV), gen_share_context(V,NewV),
   append(Words,Words1,NewWords),
   gen_fully_deref(Ref1,SVs1,Ref1Out,SVs1Out),
   append(Found,[Ref1Out-SVs1Out],NewFound),
   instanciate_dtrs(N,Cat,Ref1Out-SVs1Out),
   addToAgenda(edge(NewV,NewW_B,NewWords,Cat,NewFound,[Kind2>FS2|Cats])),
   (  Kind=cats
   -> (getVertex(CopyFS1,NewV2), gen_share_context(V,NewV2),
       addToAgenda(edge(NewV2,NewW_B,NewWords,Cat,NewFound,[cats>CopyFS1,Kind2>FS2|Cats])))
   ; true
   ),   
   fail.

%--------------------------------------------------------------------------------
%Dot Movement Check
%When a new inactive edge is created, then check dot movement for all old active
%edges (i.e. active edges that are in the chart)
%--------------------------------------------------------------------------------
dotMovementCheck(edge(V1,W_B1,Words1,Ref1-SVs1,_Found1,[])) :-
   gen_disjoint_edge(c_edge,W_B1,Ref1-SVs1,edge(V,W_B,Words,Cat,Found,[Kind>FS1])),
   gen_ud(V,V1),
   ((Kind=cats) -> copyFS(FS1,CopyFS1) ; true),     
   gen_ud(FS1,Ref1-SVs1),
   length(Found,Length),
   N is Length+1,
   bs_disjoint(W_B,W_B1),
   bs_union(W_B,W_B1,NewW_B),
   getVertex(Cat,NewV), gen_share_context(V,NewV),
   append(Words,Words1,NewWords),
   gen_fully_deref(Ref1,SVs1,Ref1Out,SVs1Out),
   append(Found,[Ref1Out-SVs1Out],NewFound),
   instanciate_dtrs(N,Cat,Ref1Out-SVs1Out),
   (  Kind=cats
   -> (getVertex(CopyFS1,NewV2), gen_share_context(V,NewV2),
       copyFS(Cat,CopyCat),
       addToAgenda(edge(NewV2,NewW_B,NewWords,CopyCat,NewFound,[cats>CopyFS1])))
   ; true
   ),
   instanciate_dtrs_end(N,Cat),
   addToAgenda(edge(NewV,NewW_B,NewWords,Cat,NewFound,[])),
   fail.








%================================================================================
%Predicates for test suite handling
%================================================================================
%--------------------------------------------------------------------------------
%to get and write the date and time of a generation in the output file
%--------------------------------------------------------------------------------
write_current_date(Stream):-
        datime(datime(Y,M,D,H,Mi,S)),
        write_date(Stream,Y,M,D,H,Mi,S).

write_date(Stream,Y,M,D,H,Mi,S):-
        write(Stream,D),
        write(Stream,'.'),
        write(Stream,M),
        write(Stream,'.'),
        write(Stream,Y),
        write(Stream,', '),
        write(Stream,H),
        write(Stream,':'),
        write(Stream,Mi),
        write(Stream,':'),
        write(Stream,S).

%--------------------------------------------------------------------------------
%To write a heading in the output file
%--------------------------------------------------------------------------------
heading(File):-
        open(File,write,Stream),
        name(C,[37]),
        write(Stream,C),
        write(Stream,' Output from the test file for generation'),
        nl(Stream),
        close(Stream).

%--------------------------------------------------------------------------------
%To write a small heading with time and date before each item in the output file
%--------------------------------------------------------------------------------
heading2(File):-
        open(File,append,Stream),
        nl(Stream),
        name(C,[37]),
        write(Stream,C),
        write(Stream,' '),
        write_current_date(Stream),
        nl(Stream),
        close(Stream).



%--------------------------------------------------------------------------------
%To remember what words have been parsed and use it in the output file
%--------------------------------------------------------------------------------
parsed_words([]).

set_parsed_words(L):-
        retractall(parsed_words(_)),
        assert(parsed_words(L)).

%--------------------------------------------------------------------------------
%testgr(+N:<int>,+File:<path_to_file>,+Mode:<atom>).
%--------------------------------------------------------------------------------
%Mode takes for value append or write
%This predicate is used to test item number N and write or append the results in
%file File
%--------------------------------------------------------------------------------
testgr(N,File,Mode):-
        (  testg2(N,File,Mode)
        -> true
        ;  true).

%--------------------------------------------------------------------------------
%Other versions of testgr(N,File,Mode)
%--------------------------------------------------------------------------------
testg(all):- testgr(_,no_output_file,_).

testg(N):- testgr(N,no_output_file,_).


testgw(all,File):-
        heading(File),
        testgr(_,File,append).

testgw(N,File):-
        heading(File),
        testgr(N,File,append).


testga(all,File):-
        (   file_exists(File)
        ->  true
        ;   heading(File)),
        testgr(_,File,append).

testga(N,File):-
        (file_exists(File)
        ->  true
        ;   heading(File)),
        testgr(N,File,append).

%--------------------------------------------------------------------------------
%used by testgr and other versions
%--------------------------------------------------------------------------------
testg2(N,File,Mode):-
        call(
        (
         gen_legacy_test_item(N,Ws,R),
         set_parsed_words(Ws),
         p_and_g_no_query(Ws,N,R),
         gen_words(L),
         parsed_words(L2),
         (  File=no_output_file
         -> true
         ;  heading2(File),
            open(File,Mode,Stream),
            write(Stream,N),
            write(Stream,': '),
            write(Stream,L2),
            nl(Stream),
            write(Stream,L),
            nl(Stream),
            close(Stream)
         ),
         fail
        )).

%--------------------------------------------------------------------------------
%p_and_g_q(+Query:<atom>,Ws_or_Desc:<list or desc>,+N:<int>,+R:<desc>)
%--------------------------------------------------------------------------------
%Either generate from description Ws_or_desc or parse it and generate from the
%parse if it is a phrase.
%Query enables to switch query_proceed on and off
%R is a description with whom generated objects have to match
%--------------------------------------------------------------------------------
p_and_g_q(Query,Ws_or_Desc,N,R):-
        call(
         (
          (
            (   %****** Code taken from file test_suite_handling.pl from Detmar Meurers

                [H|_] = Ws_or_Desc 
            -> (integer(H) ->  
                Ws_or_Desc=String,
	        general_tokenize_sentence_string(String,WordList,_Desc)
                ;                    
	        Ws_or_Desc=WordList,
	        wordlist2string(WordList,String)),
                   
                %******

                init_parse_count,
                write('* parsing'),(N>=0 -> (write(' '),write(N));true),write(': '),write(WordList),nl,
                rec(WordList,Tag,R,_Residue),
                parse_count_incr,
                gen_project_semantics(Tag,TagOut),
                parse_count(M),
                write('* generating from parse '),write(M),write('...'),nl,
               slgGen(TagOut,bot,_Words,R,Query)
            ;  
               write('* generating from Desc=('),
               write(Ws_or_Desc),write(') ...'),nl,
               g(Ws_or_Desc,_Words,R,Query)),
            fail)
         ; true
         )).

% CONT need not contain RELS/HCONS (e.g. Kapitel-09). Project all declared
% semantic paths onto one target, sharing the original values across paths.
% Never copy each value independently: IND, relation arguments and handles
% can be reentrant even when they live in different parts of the sign.
gen_project_semantics(Source,Target) :-
   findall(Path,gen_semantic_path(Path),Paths0),
   sort(Paths0,Paths),
   gen_project_paths(Paths,Source,Target).

gen_semantic_path(Path) :- cont_path(Path).
gen_semantic_path(Path) :- liszt_path(Path).
gen_semantic_path(Path) :- ind_path(Path).
gen_semantic_path(Path) :-
   current_predicate(hcons_path,hcons_path(_)), hcons_path(Path).
gen_semantic_path(Path) :-
   current_predicate(ltop_path,ltop_path(_)), ltop_path(Path),
   (Path=[];Path=[_|_]).
gen_semantic_path(Path) :-
   current_predicate(gtop_path,gtop_path(_)), gtop_path(Path),
   (Path=[];Path=[_|_]).

gen_project_paths([],_,_).
gen_project_paths([Path|Paths],Source,Target) :-
   gen_pathval(Path,Source,bot,Value,bot),
   gen_pathval(Path,Target,bot,Value,bot),
   gen_project_paths(Paths,Source,Target).

%--------------------------------------------------------------------------------
%Other versions of p_and_g_q(Query,Ws_or_Desc,N,R)
%--------------------------------------------------------------------------------
p_and_g_no_query(Ws,N):-
        u_gen_root(R),
        p_and_g_q(no_query,Ws,N,R).

p_and_g_no_query(Ws,N,R):-
        p_and_g_q(no_query,Ws,N,R).

p_and_g(Ws):-
        u_gen_root(R),
        p_and_g_q(query,Ws,(-1),R).

p_and_g(Ws,R):-
        u_gen_root(Root),
        use_root(R),
        p_and_g_q(query,Ws,(-1),R),
        use_root(Root).

%--------------------------------------------------------------------------------
%To count the number of parses found
%--------------------------------------------------------------------------------
parse_count(0).

init_parse_count:-
        retractall(parse_count(_)),
        assert(parse_count(0)).

parse_count_incr:-
        parse_count(N),
        retractall(parse_count(_)),
        M is N+1,
        assert(parse_count(M)).


% SP4 interface.  Categories pair a native FS with generator derivation metadata.
% Description placeholders and semantic vertices use bot in the second slot.
% No compatibility predicates are installed in TRALE's own namespace.
gen_add_to(Desc,FS,bot) :- add_to(Desc,FS).
gen_deref(FS,_SVs,FS,bot).
gen_fully_deref(FS,Node,FS,Node).
gen_ud(FS1-Meta1,FS2-Meta2) :-
   gen_unify_context(Meta1,Meta2), FS1=FS2.

gen_share_context(_-Meta1,_-Meta2) :- gen_unify_context(Meta1,Meta2).
gen_unify_context(gen_context(First,Nodes1),gen_context(Second,Nodes2)) :-
   !, First=Second,Nodes1=Nodes2,gen_valid_vertex(_-gen_context(First,Nodes1)).
gen_unify_context(_,_).
gen_ud(FS1,_,FS2,_) :- FS1=FS2.
gen_pathval(Path,FS,_SVs,Value,bot) :-
   deref(FS,TFS,Type,Pos),
   pathval(Path,FS,Pos,Type,TFS,Value,bot).
gen_pp_fs_res(FS,_SVs,Residue) :- pp_fs_res(FS,Residue).

gen_wrap_dtrs([],[]).
gen_wrap_dtrs([Kind>FS|Rest],[Kind>Wrapped|WrappedRest]) :-
   ( (Kind=goal ; Kind=sem_goal) -> Wrapped=FS ; Wrapped=FS-bot ),
   gen_wrap_dtrs(Rest,WrappedRest).

% SP4 assertion and retraction do not preserve variable attributes.  Store
% the complete edge/rule together with its residue, including sharing between
% mother, daughters, semantic vertex, and delayed grammar constraints.
gen_save(Kind,Term) :-
   gen_valid_stored(Term),
   residuate_term(Term,Residue),
   gen_store_shape(Term,Shape),
   asserta(gen_store(Kind,Term,Residue),Ref),
   asserta(gen_store_index(Kind,Shape,Ref)).

gen_store_shape(edge(_,Bits,_,Cat,_,Rest),edge(Bits,State,QC)) :-
   !, (Rest==[] -> State=complete,Category=Cat
       ; State=active,Rest=[_>Category|_]),
   Category=FS-_,gen_quick_check(FS,6,QC).
gen_store_shape(_,other).

gen_query_shape(Term,_) :- var(Term), !.
gen_query_shape(edge(_,Bits,_,_,_,Rest),edge(Bits,State,_)) :-
   !, (var(Rest) -> true ; Rest==[] -> State=complete ; State=active).
gen_query_shape(_,other).

gen_load(Kind,Term) :-
   gen_query_shape(Term,Shape),
   gen_store_index(Kind,Shape,Ref),
   instance(Ref,(gen_store(Kind,Term,Residue):-true)),
   call(Residue).

% Scan small index records, not entire derivations. Reject overlapping
% coverage before copying any candidate FS or waking its delayed constraints.
gen_disjoint_edge(Kind,Used,Expected-_,Edge) :-
   gen_quick_check(Expected,6,ExpectedQC),
   gen_query_shape(Edge,edge(Bits,State,_)),
   gen_store_index(Kind,edge(Bits,State,QC),Ref),
   bs_disjoint(Used,Bits),
   gen_quick_compatible(ExpectedQC,QC),
   instance(Ref,(gen_store(Kind,Edge,Residue):-true)),
   call(Residue).

% A read-only necessary-condition check. Unknown values stay wildcards;
% lists retain only their type, and the fixed depth bounds cyclic structures.
% Six levels reach head features below SYNSEM.LOC.CAT and nested CASE values.
% Skip both morphological DTR and syntactic daughter trees in this precheck.
gen_quick_check(FS,Depth,q(Type,Features)) :-
   deref(FS,_TFS,Type,_),
   (Type==0 -> Features=[]
   ; Depth=:=0 -> Features=[]
   ; sub_type(list,Type) -> Features=[]
   ; (approps(Type,Approps,_) -> Next is Depth-1,
       gen_quick_features(Approps,FS,Next,Features)
      ; Features=[])).
gen_quick_features([],_,_,[]).
gen_quick_features([Feature:_|Rest],FS,Depth,Qs) :-
   memberchk(Feature,[dtr,dtrs,head_dtr,non_head_dtrs]), !,
   gen_quick_features(Rest,FS,Depth,Qs).
gen_quick_features([Feature:_|Rest],FS,Depth,[Feature-Q|Qs]) :-
   clause(fcolour(Feature,Position,_),true),
   (compound(FS),arg(Position,FS,Value)
   -> gen_quick_check(Value,Depth,Q)
   ; Q=q(0,[])),
   gen_quick_features(Rest,FS,Depth,Qs).

gen_quick_compatible(q(A,As),q(B,Bs)) :-
   (A==0 -> true ; B==0 -> true
   ; unify_type(A,B,_),gen_quick_common(As,Bs)).
gen_quick_common([],_).
gen_quick_common([Feature-Q|Rest],Other) :-
   (memberchk(Feature-R,Other) -> gen_quick_compatible(Q,R);true),
   gen_quick_common(Rest,Other).

gen_take(Kind,Term) :-
   gen_query_shape(Term,Shape),
   gen_store_index(Kind,Shape,Ref),
   instance(Ref,(gen_store(Kind,Term,Residue):-true)),
   retract(gen_store_index(Kind,Shape,Ref)),
   erase(Ref),
   call(Residue).
gen_clear(Kind) :-
   retractall(gen_store_index(Kind,_,_)),
   retractall(gen_store(Kind,_,_)).
a_edge(A,B,C,D,E,F) :- gen_load(a_edge,edge(A,B,C,D,E,F)).
c_edge(A,B,C,D,E,F) :- gen_load(c_edge,edge(A,B,C,D,E,F)).
cc_edge(A,B,C,D,E,F) :- gen_load(cc_edge,edge(A,B,C,D,E,F)).
mod_grRule(Name,Moth,Dtrs) :- gen_load(mod_grRule,rule(Name,Moth,Dtrs)).
non_mod_grRule(Name,Moth,Dtrs) :- gen_load(non_mod_grRule,rule(Name,Moth,Dtrs)).

% The initial specification has no derivation.  Display its AVM directly;
% completed results use gen_portray_result/2 and their recorded derivation.
gen_portray_fs(Title,FS,Residue) :-
   current_predicate(grale_flag,grale_flag),
   grale_flag,
   set_title(Title),
   grisu_pp_fs_res(FS,Residue,_,0),
   clear_title.

% Populate PHON only when the existing signature makes it list-valued on
% this FS's type.  A declaration on an unrelated type (e.g. affix) is not
% sufficient.  Never extend the signature or promote the FS to introduce PHON.
% Respect phon_feat/1 when the grammar uses a different feature name.
gen_set_phon(FS-_,Words) :-
   phon_feat_(Feat),
   deref(FS,_,Type,_),
   ( approp(Feat,Type,Restr), sub_type(list,Restr)
   -> gen_phon_description(Words,Phon),
      add_to(Feat:Phon,FS)
   ;  true
   ).

gen_phon_description([],[]).
gen_phon_description([Word|Words],[(a_ Word)|Phon]) :-
   gen_phon_description(Words,Phon).

% Derivation metadata belongs to generator edges, never to the grammar's FS.
% Retain it together with the FS through chart storage, copying and dot movement.
gen_complete_node(_FS-gen_node(_Rule,Words,Daughters),Words,Daughters).

gen_portray_result(_,_) :- gen_test_quiet, !.
gen_portray_result(Category,Residue) :-
   current_predicate(grale_flag,grale_flag),
   grale_flag,
   !,
   % Never fall back to pp_fs_res while Grale is active: its graphical hooks
   % would send bare AVM fragments, without !newdata framing or a tree.
   ( gen_display_tree(Category,Tree,TreeFSs,[]),
     Category=FS-_,
     gen_grale_derivation(Tree,TreeFSs,FS,Residue)
   -> true
   ; throw(error(generator_graphical_output_failed,gen_portray_result/2))
   ).

gen_display_tree(FS-gen_node(Rule,Words,Daughters),
                 tree(Label,Words,FS,_Reentrant,SubTrees),[FS|FSs],Rest) :-
   % Use the same rule:substring labels as the parser, even without PHON.
   name(Rule,RuleChars),
   list_to_double_quoted_string(Words,[34|WordChars]),
   append([34|RuleChars],[58|WordChars],Label),
   gen_display_daughters(Daughters,SubTrees,FSs,Rest).

gen_display_daughters([],[],FSs,FSs).
gen_display_daughters([Daughter|Daughters],[Tree|Trees],FSs,Rest) :-
   gen_display_tree(Daughter,Tree,FSs,Mid),
   gen_display_daughters(Daughters,Trees,Mid,Rest).


% Batch-test adapter: retain every generated derivation, including repeated
% word sequences, and collect results from every parse (gen_words is reset
% by each generation). No FS displays or interactive questions in this mode.
generator_test_results(Input,Root,Words,ParseCount) :-
   ale_flag(another,OldLimit),
   findall(R,u_gen_root(R),OldRoots),
   findall(Q,output_query(Q),OldQueries),
   (gen_test_quiet -> OldQuiet=yes ; OldQuiet=no),
   current_output(OldOutput),open_null_stream(QuietOutput),
   call_cleanup(
     once(( ale_flag(another,_,0),
       (OldQuiet=yes -> true ; assert(gen_test_quiet)),
       set_output(QuietOutput),
       gen_test_tokenize(Input,Tokens),
       findall(Generated,
         (rec(Tokens,Parsed,Root,_Residue),
          gen_project_semantics(Parsed,Semantics),
          once(slgGen(Semantics,bot,Generated,Root,no_query))),PerParse),
       length(PerParse,ParseCount),gen_test_append(PerParse,Words)
     )),
     ( set_output(OldOutput),close(QuietOutput),
       (OldQuiet=no -> retractall(gen_test_quiet) ; true),
       ale_flag(another,_,OldLimit),
       retractall(u_gen_root(_)),gen_test_restore_roots(OldRoots),
       retractall(output_query(_)),gen_test_restore_queries(OldQueries)
     )).

gen_test_tokenize(Input,Tokens) :-
   (atom(Input) -> atom_codes(Input,Codes),
                  general_tokenize_sentence_string(Codes,Tokens,_)
   ; Input=[First|_],integer(First)
   -> general_tokenize_sentence_string(Input,Tokens,_)
   ; Tokens=Input).
gen_test_append([],[]).
gen_test_append([First|Rest],All) :-
   append(First,Tail,All),gen_test_append(Rest,Tail).
gen_test_restore_roots([]).
gen_test_restore_roots([R|Rs]) :- assert(u_gen_root(R)),gen_test_restore_roots(Rs).
gen_test_restore_queries([]).
gen_test_restore_queries([Q|Qs]) :- assert(output_query(Q)),gen_test_restore_queries(Qs).

% Keep the older, verbose testg/testgw interface working with counted items.
gen_legacy_test_item(N,Words,Root) :- fail_if_undefined(tg(N,Words,Root)).
gen_legacy_test_item(N,Words,Root) :- fail_if_undefined(tg(N,Words,Root,_)).
gen_legacy_test_item(N,Words,Root) :- fail_if_undefined(tg(N,Words,Root,_,_)).
