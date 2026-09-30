% -*- coding:utf-8; mode:trale-prolog -*-
% Generated from signature by ../Gemeinsames/tdl_to_signature.py.
% Do not edit: regenerate after changes to signature.
% Load with ale_flag(subintro,_,grammar) and ale_flag(msl,_,off).

bot sub [bool, case, cat, cform, event_or_index, gender, head, list, mrs, none_or_sign, num, per, pform, qeq, relation, vform].
  bool sub [minus, plus].
    minus sub [].
    plus sub [].
  case sub [acc, dat, gen, nom].
    acc sub [].
    dat sub [].
    gen sub [].
    nom sub [].
  cat sub []
      intro [head:head,
             spr:list,
             comps:list,
             arg_st:list].
  cform sub [dass].
    dass sub [].
  event_or_index sub [event, handle, index].
    event sub [].
    handle sub [].
    index sub []
          intro [per:per,
                 num:num,
                 gen:gender].
  gender sub [fem_or_mas, neu].
    fem_or_mas sub [fem, mas].
      fem sub [].
      mas sub [].
    neu sub [].
  head sub [adj, adv, comp, intro_case_head, non_modifier, prep]
       intro [mod:none_or_sign,
              spec:none_or_sign,
              scopal:bool].
    adj sub [attr_adj].
      attr_adj sub [].
    adv sub [].
    comp sub []
         intro [cform:cform].
    intro_case_head sub [attr_adj, glb_det_noun_comp_prep]
                    intro [case:case].
      glb_det_noun_comp_prep sub [comp_prep, det, noun].
        comp_prep sub []
                  intro [pform:pform].
        det sub [].
        noun sub [].
    non_modifier sub [glb_det_noun_comp_prep, verb]
                 intro [mod:none].
      verb sub []
           intro [vform:vform].
    prep sub [comp_prep, mod_prep].
      mod_prep sub [].
  list sub [e_list, ne_list].
    e_list sub [].
    ne_list sub []
            intro [hd:bot,
                   tl:list].
  mrs sub []
      intro [gtop:handle,
             ltop:handle,
             ind:event_or_index,
             rels:list,
             hcons:list].
  none_or_sign sub [none, sign].
    none sub [].
    sign sub [phrase, word]
         intro [phon:list,
                cat:cat,
                cont:mrs].
      phrase sub [headed_phrase, non_headed_phrase]
             intro [non_head_dtrs:list,
                    dtrs:list].
        headed_phrase sub [head_non_complement_phrase, head_non_specifier_phrase]
                      intro [head_dtr:sign].
          head_non_complement_phrase sub [head_adjunct_phrase, head_specifier_phrase].
            head_adjunct_phrase sub [].
            head_specifier_phrase sub [].
          head_non_specifier_phrase sub [head_adjunct_phrase, head_complement_phrase].
            head_complement_phrase sub [].
        non_headed_phrase sub [].
      word sub [].
  num sub [pl, sg].
    pl sub [].
    sg sub [].
  per sub [first, second, third].
    first sub [].
    second sub [].
    third sub [].
  pform sub [an_pform].
    an_pform sub [].
  qeq sub []
      intro [harg:handle,
             larg:handle].
  relation sub [arg0_relation, arg1_relation, arg2_relation]
           intro [lbl:handle].
    arg0_relation sub [affe_rel, arg01_relation, arg02_relation, beispiel_rel, buch_rel, einhorn_rel, frau_rel, kind_rel, mann_rel, mitarbeiter_rel, named_rel, quant_rel, speisekammer_rel, tofu_rel]
                  intro [arg0:event_or_index].
      affe_rel sub [].
      arg01_relation sub [arg012_relation, schlafen_rel].
        arg012_relation sub [arg0123_rel, denken_an_rel, glauben_rel, jagen_rel, kennen_rel, poss_rel].
          arg0123_rel sub [geben_rel]
                      intro [arg3:index].
            geben_rel sub [].
          denken_an_rel sub [].
          glauben_rel sub [].
          jagen_rel sub [].
          kennen_rel sub [].
          poss_rel sub [].
        schlafen_rel sub [].
      arg02_relation sub [arg012_relation, grauen_rel, tochter_rel].
        grauen_rel sub [].
        tochter_rel sub [].
      beispiel_rel sub [].
      buch_rel sub [].
      einhorn_rel sub [].
      frau_rel sub [].
      kind_rel sub [].
      mann_rel sub [].
      mitarbeiter_rel sub [].
      named_rel sub []
                intro [name:(a_ _)].
      quant_rel sub [def_q, every_q, exists_q, proper_q]
                intro [rstr:handle,
                       body:handle].
        def_q sub [].
        every_q sub [].
        exists_q sub [].
        proper_q sub [].
      speisekammer_rel sub [].
      tofu_rel sub [].
    arg1_relation sub [angeblich_rel, arg01_relation, arg12_relation, exist_dummy_rel, klein_rel, mutmaßlich_rel, schwierig_rel, wahrscheinlich_rel]
                  intro [arg1:event_or_index].
      angeblich_rel sub [].
      arg12_relation sub [arg012_relation, in_rel].
        in_rel sub [].
      exist_dummy_rel sub [].
      klein_rel sub [].
      mutmaßlich_rel sub [].
      schwierig_rel sub [].
      wahrscheinlich_rel sub [].
    arg2_relation sub [arg02_relation, arg12_relation]
                  intro [arg2:event_or_index].
  vform sub [fin].
    fin sub [].
