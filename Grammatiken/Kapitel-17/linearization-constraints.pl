% -*- coding: utf-8; mode: trale-prolog -*-
% Local argument precedence for German, using spirits as the domain.
%
% NP < dass clause: complements combine to the left of verbs/adjectives.
% Verb-initial heads do not directly combine with NP or dass complements.
% The initial prototype rejected "Glaubt dass der Affe lacht er" (1 -> 0
% analyses, 44 -> 38 passive edges), preserving the NP-first counterpart.
% Input-word-restricted generation of "Er glaubt dass der Affe lacht"
% dropped the one violating output and reduced chart edges from 105 to 94.
% Existing parser filters were enabled; no whole-suite speed claim.

:- multifile '*>'/2.
:- discontiguous '*>'/2.
:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile if/2.
:- discontiguous if/2.
:- dynamic lp_rule/2.
:- multifile lp_rule/2.

% Surface precedence declarations; every applicable rule must hold.

% NP < dass-CP
lp_rule(loc:cat:head:noun,
        loc:cat:head:(comp,cform:dass)).

% PP < dass-CP
%
% PP-before-CP test: "Heute wird dass der Affe lacht von dem Mann geglaubt"
% goes from 3 analyses to 0 (83 -> 69 edges); PP-first retains all 3 (89 edges).
% Existing filters enabled; this is not a whole-suite benchmark.
lp_rule(loc:cat:head:prep,
        loc:cat:head:(comp,cform:dass)).

(head_complement_phrase,
 head_dtr:synsem:loc:cat:head:adj_or_participle_or_verb) *>
 (head_dtr:synsem:loc:cat:comps:Arguments,
  non_head_dtrs:[synsem:New]) goal spirit_lp_domain_check(Arguments,New).

% The following code may be ignored. It walks trough the COMPS list and checks whether the elements
% are just attracted although they are realized already with another head. This may happen in frontings like:
%
% Das Buch gegeben hat Aicke dem Kind.
%
% Without this check, it would seem as if "das Buch" is realized to the right of "Aicke" and "dem Kind".
%
% The check ensures that only "Aicke" and "dem Kind" are serialized with respect to each other.

% Collect arguments realized inside another argument before checking LP.
% Phrasal ARG-ST may be open; COMPS retains the realization spirits.
spirit_lp_domain_check(Arguments,New) if
 (spirit_lp_embedded(Arguments,Excluded),
  spirit_lp_domain_ready(Excluded,Arguments,New)).

spirit_lp_embedded(Arguments,Excluded) if
 when(Arguments=(e_list;ne_list),spirit_lp_embedded_list(Arguments,Excluded)).
spirit_lp_embedded_list([],[]) if true.
spirit_lp_embedded_list([arg:loc:cat:comps:Comps|Rest],append(Own,More)) if
 (spirit_lp_realized(Comps,Own),spirit_lp_embedded(Rest,More)).

spirit_lp_realized(Arguments,Realized) if
 when(Arguments=(e_list;ne_list),spirit_lp_realized_list(Arguments,Realized)).
spirit_lp_realized_list([],[]) if true.
spirit_lp_realized_list([(Arg,realized:Flag)|Rest],Result) if
 when(Flag=(plus;minus),spirit_lp_realized_arg(Flag,Arg,Rest,Result)).
spirit_lp_realized_arg(plus,arg:Synsem,Rest,[Synsem|More]) if
 spirit_lp_realized(Rest,More).
spirit_lp_realized_arg(minus,_,Rest,More) if
 spirit_lp_realized(Rest,More).

% Finish the whole exclusion list before testing non-membership.
spirit_lp_domain_ready(Excluded,Arguments,New) if
 spirit_lp_domain_ready_tail(Excluded,Excluded,Arguments,New).
spirit_lp_domain_ready_tail(Tail,Excluded,Arguments,New) if
 when(Tail=(e_list;ne_list),
      spirit_lp_domain_ready_list(Tail,Excluded,Arguments,New)).
spirit_lp_domain_ready_list([],Excluded,Arguments,New) if
 spirit_lp_check(Arguments,New,Excluded).
spirit_lp_domain_ready_list([_|Tail],Excluded,Arguments,New) if
 spirit_lp_domain_ready_tail(Tail,Excluded,Arguments,New).

spirit_lp_check(Arguments,New,Excluded) if
 when(Arguments=(e_list;ne_list),spirit_lp_list(Arguments,New,Excluded)).
spirit_lp_list([],_,_) if true.
spirit_lp_list([Old|Rest],New,Excluded) if
 (spirit_lp_local_pair(New,Old,Excluded),
  spirit_lp_check(Rest,New,Excluded)).
spirit_lp_local_pair(New,(Old,arg:OldSynsem),Excluded) if
 when((New=trace:minus,Old=(realized:plus,arg:trace:minus)),
      spirit_lp_domain_pair(New,OldSynsem,Excluded)).
spirit_lp_domain_pair(New,Old,Excluded) if
 (spirit_lp_member(New,Excluded) -> true
 ;spirit_lp_member(Old,Excluded) -> true
 ;lp_rules(New,Old)).

% Structure identity, not unifiability or just identical semantic indices.
spirit_lp_member(_,[]) if fail.
spirit_lp_member(S,[H|T]) if
 (S =@ H -> true ; spirit_lp_member(S,T)).
