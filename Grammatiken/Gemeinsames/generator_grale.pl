% Grale output for generator derivations.  Loaded with the grammar, not with
% TRALE: installations/saved states need no additional ghooks.pl predicate.
% Use the native SP4 Grale tree and AVM-link representation used by parsing.

gen_grale_derivation(Tree,TreeFSs,FS,Residue) :-
  empty_avl(AssocIn),
  filter_iqs(Residue,Iqs,Residue0),
  DupsIn=AssocIn,
  NumIn=0,
  Tree = tree(_,SubWords,_,_,_),
  list_to_double_quoted_string(SubWords,DQWords),
  append("!newdata",DQWords,GraleCommandPrefix),  % (structure)
  grale_write_chars(GraleCommandPrefix),
  \+ \+ (( ale_flag(cllrs,on) -> build_sem_residue(Residue0,SemResidue,FSResidue) %, debug_semres(SemResidue)
	 ; SemResidue = [], FSResidue = Residue0
	 ),
     (ale_flag(residue,show) -> residue_args(FSResidue,ResArgs,TreeFSs) ; ResArgs = TreeFSs),
	 duplicates_list(ResArgs,DupsIn,Dups0,DupsIn,Vis0,NumIn,Num0), % start Vis thread with DupsIn, because every visited address
	 duplicates_iqs(Iqs,Dups0,Dups1,Vis0,Inf,Num0,Num1),          % in portray_tree_label/9 has been assigned a re-entrant tag
	 insert_duplicates(Tree,Dups1,Dups2,Num1,Num2),  % HACK: the re-entrancies list is the only place
	 avl_store(top_index,AssocIn,Num2,HD0),                           % in the present interface where I can provide these
	 avl_store(tree_struc,HD0,Tree,HD1),
         ( ale_flag(cllrs,on) -> store_sem_residue(HD1,SemResidue,HD2); HD2 = HD1),
%	 pp_fs(FS,0,Dups2,Dups3,AssocIn,Vis2,0,HD2,HD3),
	 pp_fs(FS,0,Dups2,Inf,AssocIn,Vis2,0,HD2,HD3),
%	 grale_pp_iqs(Iqs,Dups3,Dups4,Vis2,Vis3,HD3,HD4), 
	 grale_pp_iqs(Iqs,Dups2,Inf,Vis2,Vis3,HD3,HD4), 
         (  FSResidue \== [], ale_flag(residue,show) 
         -> grale_write_chars("/"),
%            pp_residue(FSResidue,Dups4,_,Vis3,_,HD4,_) 
            pp_residue(FSResidue,Dups2,Inf,Vis3,_,HD4,_) 
         ;  true
         )),
  grale_nl,grale_flush_output.
