% Experimental lexical look-ahead for the textbook grammar's verb traces.
% Enabled only by ale_flag(head_movement_filter,_,on); the default parser is unchanged.
% A DSL-local projection must be licensed by a preceding finite verb whose
% LOCAL value can unify with its DSL value. Test compatibility without binding
% the chart edge, and retain every compatible lexical alternative.
%
% Coordinated words can supply a LOCAL value absent from the lexical entries.
% Conservatively bypass this prototype for inputs with a possible coordinator.
% The filter deliberately does not constrain extraction traces or change
% argument-realisation constraints.
:- dynamic head_movement_filter_candidate/3, head_movement_filter_bypass/0.

parser_head_movement_filter_prepare(Words) :-
   retractall(head_movement_filter_candidate(_,_,_)),
   retractall(head_movement_filter_bypass),
   secret_noadderrs_toggle(OldMode),
   call_cleanup(head_movement_filter_words(Words,0),secret_adderrs_toggle(OldMode)).

head_movement_filter_words([], _).
head_movement_filter_words([Word|Words],Position) :-
   ( lex(Word,FS),
     ( \+ \+ add_to(synsem:loc:cat:head:coord,FS)
     -> (head_movement_filter_bypass -> true ; assertz(head_movement_filter_bypass))
     ; true),
     add_to(synsem:(loc:cat:head:(verb,initial:minus,vform:fin),
                    phrase:minus,trace:minus),FS),
     head_movement_filter_path(FS,[synsem,loc],Local),
     residuate_term(Local,Residue),
     assertz(head_movement_filter_candidate(Position,Local,Residue)),
     fail
   ; true),
   Next is Position+1,
   head_movement_filter_words(Words,Next).

parser_head_movement_filter_edge(Left,_Right,FS) :-
   ( head_movement_filter_bypass -> true
   ; head_movement_filter_path(FS,[synsem,loc,cat,head,dsl],DSL),
     get_type(DSL,Type), Type \== 0, sub_type(local,Type)
   -> head_movement_filter_candidate(Position,Local,Residue),
      Position < Left,
      call(Residue),
      DSL=Local
   ; true).

% Inspect only existing features. Do not introduce paths or wake constraints
% merely to decide whether an edge has a DSL-local head.
head_movement_filter_path(FS,[],FS).
head_movement_filter_path(FS,[Feature|Path],Value) :-
   get_type(FS,Type), Type \== 0,
   approp(Feature,Type,_),
   clause(fcolour(Feature,Position,_),true),
   compound(FS),arg(Position,FS,Next),
   head_movement_filter_path(Next,Path,Value).
