% -*- coding: utf-8; mode: trale-prolog -*-
% Compact version of Klaus Netter's inflection tables.
% The original is preserved in suffixes-netter.pl.
% suffix_table(Kind,Name,Fields,Description,Rows):
% Description specifies the ending, inflection class and phonological guards.
% Each row specifies an allowed combination in the order given by Fields.
% The same rows constrain the affix and select the stem; edit them only here.
% Kind fin participates in stem selection; adj describes adjective endings.
% Names are references only, not linguistic types.
:- multifile suffix_table/5, '*>'/2, generator_lexical_type_path/1.
:- discontiguous '*>'/2.

suffix_table(adj, adj_0, [num,gen,morph_case,dtype], @a_infl_affix([a_ e],  num,genus,case,dtype), [[sg, mas,        nom,        strong],
                                                                                                    [sg, fem,        nom_or_acc, dtype],
                                                                                                    [sg, neu,        nom_or_acc, strong],
                                                                                                    [pl, genus,      nom_or_acc, weak]]).
suffix_table(adj, adj_1, [num,gen,morph_case,dtype], @a_infl_affix([a_ em], num,genus,case,dtype), [[sg, mas_or_neu, dat,        weak]]).
suffix_table(adj, adj_2, [num,gen,morph_case,dtype], @a_infl_affix([a_ en], num,genus,case,dtype), [[sg, genus,      gen_or_dat, strong],
                                                                                                    [sg, mas_or_neu, gen,        weak],
                                                                                                    [sg, mas,        acc,        dtype],
                                                                                                    [pl, genus,      case,       strong],
                                                                                                    [pl, genus,      dat,        weak]]).
suffix_table(adj, adj_3, [num,gen,morph_case,dtype], @a_infl_affix([a_ er], num,genus,case,dtype), [[sg, mas,        nom,        weak],
                                                                                                    [sg, fem,        gen_or_dat, weak],
                                                                                                    [pl, genus,      gen,        weak]]).
suffix_table(adj, adj_4, [num,gen,morph_case,dtype], @a_infl_affix([a_ es], num,genus,case,dtype), [[sg, neu,        nom_or_acc, weak]]).

suffix_table(fin, fin_0,  [per,num,temo], @fin_v_infl_affix([a_ []],    v_strong,       temo,                               per,num), [[first_or_third, sg, past_ind],
                                                                                                                                       [second,         sg, pres_imp]]).
suffix_table(fin, fin_1,  [per,num,temo], @fin_v_infl_affix([a_ []],    modal,          temo, ep:minus,                     per,num), [[first_or_third, sg, pres_ind]]).
suffix_table(fin, fin_2,  [per,num,temo], @fin_v_infl_affix([a_ []],    v_strong,       temo, tm:plus,                      per,num), [[third,          sg, pres_ind]]).
suffix_table(fin, fin_3,  [per,num,temo], @fin_v_infl_affix([a_ e],     v_strong,       temo,                               per,num), [[first,          sg, pres_ind_conj],
                                                                                                                                       [third,          sg, pres_conj],
                                                                                                                                       [first_or_third, sg, past_conj]]).
suffix_table(fin, fin_4,  [per,num,temo], @fin_v_infl_affix([a_ e],     modal,          temo, ep:plus,                      per,num), [[first_or_third, sg, pres_ind]]).
suffix_table(fin, fin_5,  [per,num,temo], @fin_v_infl_affix([a_ e],     v_weak,         temo,                               per,num), [[first,          sg, pres_ind_conj],
                                                                                                                                       [second,         sg, pres_imp],
                                                                                                                                       [third,          sg, pres_conj]]).
suffix_table(fin, fin_6,  [per,num,temo], @fin_v_infl_affix([a_ e],     mixed,          temo,                               per,num), [[first,          sg, pres_ind_conj],
                                                                                                                                       [third,          sg, conj]]).
suffix_table(fin, fin_7,  [per,num,temo], @fin_v_infl_affix([a_ en],    v_strong,       temo,                               per,num), [[first_or_third, pl, pres_ind_conj]]).
suffix_table(fin, fin_8,  [per,num,temo], @fin_v_infl_affix([a_ en],    mixed_or_modal, temo,                               per,num), [[first_or_third, pl, pres_ind_conj]]).
suffix_table(fin, fin_9,  [per,num,temo], @fin_v_infl_affix([a_ en],    v_weak,         temo, pl_n:minus,                   per,num), [[first_or_third, pl, pres_ind_conj]]).
suffix_table(fin, fin_10, [per,num,temo], @fin_v_infl_affix([a_ n],     v_weak,         temo, pl_n:plus,                    per,num), [[first_or_third, pl, pres_ind_conj]]).
suffix_table(fin, fin_11, [per,num,temo], @fin_v_infl_affix([a_ et],    v_strong,       temo, (ep:plus, tm:minus),          per,num), [[third,          sg, pres_ind]]).
suffix_table(fin, fin_12, [per,num,temo], @fin_v_infl_affix([a_ et],    mixed,          temo, ep:plus,                      per,num), [[third,          sg, pres_ind]]).
suffix_table(fin, fin_13, [per,num,temo], @fin_v_infl_affix([a_ et],    v_weak,         temo, ep:plus,                      per,num), [[third,          sg, pres_ind],
                                                                                                                                       [second,         pl, pres_ind]]).
suffix_table(fin, fin_14, [per,num,temo], @fin_v_infl_affix([a_ ete],   v_weak,         temo, ep:plus,                      per,num), [[first_or_third, sg, past_ind_conj]]).
suffix_table(fin, fin_15, [per,num,temo], @fin_v_infl_affix([a_ etest], v_weak,         temo, ep:plus,                      per,num), [[second,         sg, past_ind_conj]]).
suffix_table(fin, fin_16, [per,num,temo], @fin_v_infl_affix([a_ est],   v_strong,       temo, (ep:plus, tm:minus),          per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_17, [per,num,temo], @fin_v_infl_affix([a_ est],   v_strong,       temo, evp:plus,                     per,num), [[second,         sg, past_ind]]).
suffix_table(fin, fin_18, [per,num,temo], @fin_v_infl_affix([a_ est],   v_strong,       temo, spe:plus,                     per,num), [[second,         sg, past_ind]]).
suffix_table(fin, fin_19, [per,num,temo], @fin_v_infl_affix([a_ est],   mixed,          temo, (ep:plus, sm:minus),          per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_20, [per,num,temo], @fin_v_infl_affix([a_ est],   v_weak,         temo, ep:plus,                      per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_21, [per,num,temo], @fin_v_infl_affix([a_ est],   modal,          temo, (ep:plus, sm:minus),          per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_22, [per,num,temo], @fin_v_infl_affix([a_ st],    v_strong,       temo, (ep:minus, sm:minus),         per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_23, [per,num,temo], @fin_v_infl_affix([a_ st],    v_strong,       temo, (ep:plus, sm:minus, tm:plus), per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_24, [per,num,temo], @fin_v_infl_affix([a_ st],    v_strong,       temo, (ep:plus, tm:t),              per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_25, [per,num,temo], @fin_v_infl_affix([a_ st],    v_strong,       temo, (evp:minus, sm:minus),        per,num), [[second,         sg, past_ind_conj]]).
suffix_table(fin, fin_26, [per,num,temo], @fin_v_infl_affix([a_ st],    mixed,          temo, (ep:minus, sm:minus),         per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_27, [per,num,temo], @fin_v_infl_affix([a_ st],    modal,          temo, (ep:minus, sm:minus),         per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_28, [per,num,temo], @fin_v_infl_affix([a_ st],    v_weak,         temo, (ep:minus, sm:minus),         per,num), [[second,         sg, pres_ind_conj]]).
suffix_table(fin, fin_29, [per,num,temo], @fin_v_infl_affix([a_ t],     v_strong,       temo, (ep:minus, sm:plus),          per,num), [[second,         sg, pres_ind_conj]]).
suffix_table(fin, fin_30, [per,num,temo], @fin_v_infl_affix([a_ t],     v_strong,       temo, (ep:minus, tm:minus),         per,num), [[third,          sg, pres_ind]]).
suffix_table(fin, fin_31, [per,num,temo], @fin_v_infl_affix([a_ t],     mixed,          temo, ep:minus,                     per,num), [[third,          sg, pres_ind]]).
suffix_table(fin, fin_32, [per,num,temo], @fin_v_infl_affix([a_ t],     v_strong,       temo, (ep:plus, tm:t),              per,num), [[third,          sg, pres_ind]]).
suffix_table(fin, fin_33, [per,num,temo], @fin_v_infl_affix([a_ t],     v_weak,         temo, (ep:minus, sm:plus),          per,num), [[second,         sg, pres_ind_conj]]).
suffix_table(fin, fin_34, [per,num,temo], @fin_v_infl_affix([a_ t],     v_weak,         temo, ep:minus,                     per,num), [[third,          sg, pres_ind],
                                                                                                                                       [second,         pl, pres_ind]]).
suffix_table(fin, fin_35, [per,num,temo], @fin_v_infl_affix([a_ t],     modal,          temo, sm:plus,                      per,num), [[second,         sg, pres_ind]]).
suffix_table(fin, fin_36, [per,num,temo], @fin_v_infl_affix([a_ t],     v_strong,       temo, ep:minus,                     per,num), [[second,         pl, pres_ind]]).
suffix_table(fin, fin_37, [per,num,temo], @fin_v_infl_affix([a_ te],    v_weak,         temo, ep:minus,                     per,num), [[first_or_third, sg, past_ind]]).
suffix_table(fin, fin_38, [per,num,temo], @fin_v_infl_affix([a_ te],    mixed,          temo, ep:minus,                     per,num), [[first_or_third, sg, past_ind_conj]]).
suffix_table(fin, fin_39, [per,num,temo], @fin_v_infl_affix([a_ te],    modal,          temo, ep:minus,                     per,num), [[first_or_third, sg, past_ind_conj]]).
suffix_table(fin, fin_40, [per,num,temo], @fin_v_infl_affix([a_ test],  non_strong,     temo, ep:minus,                     per,num), [[second,         sg, past_ind_conj]]).

attr_adj_i_suffix *>
(
  suffix_choices(a_ adj_0);
  suffix_choices(a_ adj_1);
  suffix_choices(a_ adj_2);
  suffix_choices(a_ adj_3);
  suffix_choices(a_ adj_4)
).

fin_verb_i_suffix *>
(
  suffix_choices(a_ fin_0);
  suffix_choices(a_ fin_1);
  suffix_choices(a_ fin_2);
  suffix_choices(a_ fin_3);
  suffix_choices(a_ fin_4);
  suffix_choices(a_ fin_5);
  suffix_choices(a_ fin_6);
  suffix_choices(a_ fin_7);
  suffix_choices(a_ fin_8);
  suffix_choices(a_ fin_9);
  suffix_choices(a_ fin_10);
  suffix_choices(a_ fin_11);
  suffix_choices(a_ fin_12);
  suffix_choices(a_ fin_13);
  suffix_choices(a_ fin_14);
  suffix_choices(a_ fin_15);
  suffix_choices(a_ fin_16);
  suffix_choices(a_ fin_17);
  suffix_choices(a_ fin_18);
  suffix_choices(a_ fin_19);
  suffix_choices(a_ fin_20);
  suffix_choices(a_ fin_21);
  suffix_choices(a_ fin_22);
  suffix_choices(a_ fin_23);
  suffix_choices(a_ fin_24);
  suffix_choices(a_ fin_25);
  suffix_choices(a_ fin_26);
  suffix_choices(a_ fin_27);
  suffix_choices(a_ fin_28);
  suffix_choices(a_ fin_29);
  suffix_choices(a_ fin_30);
  suffix_choices(a_ fin_31);
  suffix_choices(a_ fin_32);
  suffix_choices(a_ fin_33);
  suffix_choices(a_ fin_34);
  suffix_choices(a_ fin_35);
  suffix_choices(a_ fin_36);
  suffix_choices(a_ fin_37);
  suffix_choices(a_ fin_38);
  suffix_choices(a_ fin_39);
  suffix_choices(a_ fin_40)
).

ppp_verb_i_suffix *>
  (
    (phon:[(a_ [e,n])],
     fk:v_strong,
     morphophon:epp:plus);

    
    (phon:[(a_ [n])],
     fk:v_strong,
     morphophon:epp:minus);

    (phon:[(a_ [t])],
     fk:non_strong,
     morphophon:ep:minus);

    
    (phon:[(a_ [e,t])],
     fk:non_strong,
     morphophon:ep:plus)

  ).



    





% Transfer type restrictions, never input semantic bindings or identities.
generator_lexical_type_path([affix,per]).
generator_lexical_type_path([affix,num]).
generator_lexical_type_path([affix,temo]).
generator_lexical_type_path([affix,gen]).
generator_lexical_type_path([affix,morph_case]).
generator_lexical_type_path([affix,dtype]).
generator_lexical_type_path([affix,fk]).
