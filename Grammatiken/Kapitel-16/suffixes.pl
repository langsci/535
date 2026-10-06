% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: suffixes.pl,v $
%%  $Revision: 2.15 $
%%      $Date: 2004/05/04 16:31:25 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: noun endings taken over from Babel (Version 04.04.95)
%%             original classification due to Dorothee Reimann
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile '*>'/2. 



%%
%    Adjektive

% a_infl_affix(Phon,Num,Gen,Case,DType)


attr_adj_i_suffix *>
  (
    @a_infl_affix([a_ e], sg,mas,       nom,       strong);
    @a_infl_affix([a_ e], sg,fem,       nom_or_acc,dtype );
    @a_infl_affix([a_ e], sg,neu,       nom_or_acc,strong);
    @a_infl_affix([a_ e], pl,genus,     nom_or_acc,weak  );
    @a_infl_affix([a_ em],sg,mas_or_neu,dat,       weak  );
    @a_infl_affix([a_ en],sg,genus,     gen_or_dat,strong);
    @a_infl_affix([a_ en],sg,mas_or_neu,gen,       weak  );
    @a_infl_affix([a_ en],sg,mas,       acc,       dtype );
    @a_infl_affix([a_ en],pl,genus,     case,      strong);  
    @a_infl_affix([a_ en],pl,genus,     dat,       weak  );
    @a_infl_affix([a_ er],sg,mas,       nom,       weak  );
    @a_infl_affix([a_ er],sg,fem,       gen_or_dat,weak  );   % wegen frischer Milch  
    @a_infl_affix([a_ er],pl,genus,     gen,       weak  );
    @a_infl_affix([a_ es],sg,neu,       nom_or_acc,weak  )
  ).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  Verben


fin_verb_i_suffix *>
(
  @fin_v_infl_affix([a_ []],v_strong,      past_ind,           first_or_third,sg);

  @fin_v_infl_affix([a_ []],modal,         pres_ind,ep:minus,  first_or_third,sg);

  @fin_v_infl_affix([a_ []],v_strong,      pres_ind,tm:plus,   third,         sg);

  @fin_v_infl_affix([a_ []],v_strong,      pres_imp,           second,        sg);

 
 /*
 other grouping avoids ambiguity in readings
  @fin_v_infl_affix([a_ e]],v_strong,pres_ind,           first,         sg);

  @fin_v_infl_affix([a_ e]],v_strong,conj,               first_or_third,sg);  % pres_or_past + conjunctive
*/

  @fin_v_infl_affix([a_ e], v_strong,      pres_ind_conj,       first,         sg);

  @fin_v_infl_affix([a_ e], v_strong,      pres_conj,           third,         sg);

  @fin_v_infl_affix([a_ e], v_strong,      past_conj,           first_or_third,sg);            % pres_or_past + conjunctive
 
  % möchte
  @fin_v_infl_affix([a_ e], modal,         pres_ind,ep:plus,    first_or_third,sg);

  % rede = Ind oder Conj
  @fin_v_infl_affix([a_ e], v_weak,        pres_ind_conj,       first,         sg);

  % rede du jetzt!
  @fin_v_infl_affix([a_ e], v_weak,        pres_imp,            second,        sg);

  % er lache zu laut.
  @fin_v_infl_affix([a_ e], v_weak,        pres_conj,           third,         sg);
                                  
  @fin_v_infl_affix([a_ e], mixed,         pres_ind_conj,       first,         sg);

  @fin_v_infl_affix([a_ e], mixed,         conj,                    third,         sg);

  @fin_v_infl_affix([a_ en],v_strong,      pres_ind_conj,           first_or_third,pl);

  @fin_v_infl_affix([a_ en],mixed_or_modal,pres_ind_conj,           first_or_third,pl);

  @fin_v_infl_affix([a_ en],v_weak,        pres_ind_conj,pl_n:minus,first_or_third,pl);

  @fin_v_infl_affix([a_ n], v_weak,        pres_ind_conj,pl_n:plus, first_or_third,pl);

  @fin_v_infl_affix([a_ et],v_strong,      pres_ind,     (ep:plus,tm:minus),third, sg);

  @fin_v_infl_affix([a_ et],mixed,         pres_ind,     ep:plus,   third,         sg);
 
  @fin_v_infl_affix([a_ et],v_weak,        pres_ind,     ep:plus,   third,         sg);

  @fin_v_infl_affix([a_ et],v_weak,        pres_ind,     ep:plus,   second,        pl);

  @fin_v_infl_affix([a_ ete],v_weak,       past_ind_conj,ep:plus,   first_or_third,sg);

  @fin_v_infl_affix([a_ etest],v_weak,     past_ind_conj,ep:plus,   second,        sg);
 
  @fin_v_infl_affix([a_ est],v_strong,     pres_ind, (ep:plus,tm:minus),second,    sg);

  @fin_v_infl_affix([a_ est],v_strong,     past_ind, evp:plus,      second,        sg);

  @fin_v_infl_affix([a_ est],v_strong,     past_ind, spe:plus,      second,        sg);

  @fin_v_infl_affix([a_ est],mixed,        pres_ind, (ep:plus,sm:minus),second,    sg);
 
  @fin_v_infl_affix([a_ est],v_weak,       pres_ind, ep:plus,           second,    sg);

  @fin_v_infl_affix([a_ est],modal,        pres_ind, (ep:plus,sm:minus),second,    sg);

  @fin_v_infl_affix([a_ st],v_strong,      pres_ind, (ep:minus,sm:minus),second,   sg);   %rels:hd:pres_ind_conj,

  @fin_v_infl_affix([a_ st],v_strong,      pres_ind, (ep:plus, sm:minus,tm:plus),second,sg);

% neu für 'lädst'
  @fin_v_infl_affix([a_ st],v_strong,      pres_ind,     (ep:plus,tm:t),      second,sg);

  @fin_v_infl_affix([a_ st],v_strong,      past_ind_conj,(evp:minus,sm:minus),second,sg);
 
  @fin_v_infl_affix([a_ st],mixed,         pres_ind,     (ep:minus,sm:minus), second,sg);

  @fin_v_infl_affix([a_ st],modal,         pres_ind,     (ep:minus,sm:minus), second,sg);
 
  @fin_v_infl_affix([a_ st],v_weak,        pres_ind_conj,(ep:minus,sm:minus), second,sg);
 
  @fin_v_infl_affix([a_ t], v_strong,      pres_ind_conj,(ep:minus,sm:plus),  second,sg);
 
  @fin_v_infl_affix([a_ t], v_strong,      pres_ind,     (ep:minus,tm:minus), third, sg);

  @fin_v_infl_affix([a_ t], mixed,         pres_ind,     ep:minus,            third, sg);

 % für lädt
  @fin_v_infl_affix([a_ t], v_strong,      pres_ind,     (ep:plus,tm:t),      third, sg);

% wird                                  
%  @fin_v_infl_affix([a_ d],v_strong,pres_ind, (ep:minus,tm:werden),third,sg);

  @fin_v_infl_affix([a_ t], v_weak,        pres_ind_conj,(ep:minus,sm:plus),  second,sg);

  @fin_v_infl_affix([a_ t], v_weak,        pres_ind,     ep:minus,            third, sg);

 
  @fin_v_infl_affix([a_ t], modal,         pres_ind,     sm:plus,             second,sg);
 
  @fin_v_infl_affix([a_ t], v_weak,        pres_ind,     ep:minus,            second,pl);

  % added 05.10.2026 schmelzen -> ihr schmelzt
  @fin_v_infl_affix([a_ t], v_strong,      pres_ind,     ep:minus,            second,pl);

  @fin_v_infl_affix([a_ te],v_weak,        past_ind,     ep:minus,            first_or_third,sg);

 
  @fin_v_infl_affix([a_ te],mixed,         past_ind_conj,ep:minus,            first_or_third,sg);

  @fin_v_infl_affix([a_ te],modal,         past_ind_conj,ep:minus,            first_or_third,sg);

  @fin_v_infl_affix([a_ test],non_strong,  past_ind_conj,ep:minus,            second,        sg)

).



ppp_verb_i_suffix *>
  (
    (phon:[(a_ [e,n])],
     fk:v_strong,
     morphophon:epp:plus);

    % only for `getan'
    (phon:[(a_ [n])],
     fk:v_strong,
     morphophon:epp:minus);

    (phon:[(a_ [t])],
     fk:non_strong,
     morphophon:ep:minus);

    % there may be a bug here regarding mixed ? are they always ep:minus?
    (phon:[(a_ [e,t])],
     fk:non_strong,
     morphophon:ep:plus)

  ).



    




