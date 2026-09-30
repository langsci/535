% -*- coding:utf-8; mode:trale-prolog -*-
% Generated from lkb/types.tdl by ../Gemeinsames/tdl_to_signature.py.
% Do not edit: regenerate after changes to lkb/types.tdl.
% Load with ale_flag(subintro,_,grammar) and ale_flag(msl,_,off).

bot sub [bool, cas, case, case_type, cat, cform, dtype, event_or_index, genus, head, hook, intro_gen_num, list, minus_or_extraction_or_vm, mode, none_or_local, none_or_synsem, nonloc, num, per, pform, qeq, relation, sign, string, vform].
  bool sub [minus, plus].
    minus sub [].
    plus sub [].
  cas sub []
      intro [case_type:case_type,
             morph_case:case].
  case sub [gen_or_dat_or_acc, nom_or_dat_or_acc, nom_or_gen_or_acc].
    gen_or_dat_or_acc sub [dat_or_acc, gen_or_dat].
      dat_or_acc sub [acc, dat].
        acc sub [].
        dat sub [].
      gen_or_dat sub [dat, gen].
        gen sub [].
    nom_or_dat_or_acc sub [dat_or_acc, nom_or_acc].
      nom_or_acc sub [acc, nom].
        nom sub [].
    nom_or_gen_or_acc sub [gen, nom_or_acc].
  case_type sub [lex, str].
    lex sub [].
    str sub [].
  cat sub []
      intro [head:head,
             spr:list,
             comps:list,
             arg_st:list].
  cform sub [dass].
    dass sub [].
  dtype sub [strong, weak].
    strong sub [].
    weak sub [].
  event_or_index sub [event, handle, index].
    event sub []
          intro [mode:mode].
    handle sub [].
    index sub []
          intro [per:per].
  genus sub [fem_or_mas, fem_or_neu, mas_or_neu].
    fem_or_mas sub [fem, mas].
      fem sub [].
      mas sub [].
    fem_or_neu sub [fem, neu].
      neu sub [].
    mas_or_neu sub [mas, neu].
  head sub [intro_case_head, non_dsl_head, non_modifier_head, non_spec_head, ref_head, verbal]
       intro [mod:none_or_synsem,
              spec:none_or_synsem,
              scopal:bool,
              initial:bool,
              dsl:none_or_local].
    intro_case_head sub [attr_adj, comp_prep, det, noun]
                    intro [case:cas].
      attr_adj sub [].
      comp_prep sub []
                intro [pform:pform].
      det sub []
          intro [dtype:dtype].
      noun sub [].
    non_dsl_head sub [adj, comp, coord, det, modifier_head, noun, prep]
                 intro [dsl:none].
      adj sub [attr_adj].
      comp sub []
           intro [cform:cform].
      coord sub []
            intro [initial:plus].
      modifier_head sub [adv, mod_prep, post_modifier_head, pre_modifier_head]
                    intro [mod:synsem,
                           pre_modifier:bool].
        adv sub [].
        mod_prep sub [].
        post_modifier_head sub [relativizer]
                           intro [pre_modifier:minus].
          relativizer sub [].
        pre_modifier_head sub [attr_adj]
                          intro [pre_modifier:plus].
      prep sub [comp_prep, mod_prep].
    non_modifier_head sub [comp, comp_prep, coord, det, noun, verb]
                      intro [mod:none].
      verb sub []
           intro [vform:vform].
    non_spec_head sub [adj_or_verb, comp, modifier_head, noun, prep]
                  intro [spec:none].
      adj_or_verb sub [adj, verb].
    ref_head sub [comp_prep, noun].
    verbal sub [comp, verb].
  hook sub []
       intro [ltop:handle,
              ind:event_or_index].
  intro_gen_num sub [det, index]
                intro [gen:genus,
                       num:num].
  list sub [e_list, ne_list].
    e_list sub [].
    ne_list sub []
            intro [hd:bot,
                   tl:list].
  minus_or_extraction_or_vm sub [extraction_or_minus, extraction_or_vm, minus_or_vm].
    extraction_or_minus sub [extraction, minus].
      extraction sub [].
    extraction_or_vm sub [extraction, vm].
      vm sub [].
    minus_or_vm sub [minus, vm].
  mode sub [assertion_or_imperative_or_interrogative].
    assertion_or_imperative_or_interrogative sub [assertion_or_imperative, assertion_or_interrogative, imperative_or_interrogative].
      assertion_or_imperative sub [assertion, imperative].
        assertion sub [].
        imperative sub [].
      assertion_or_interrogative sub [assertion, interrogative].
        interrogative sub [].
      imperative_or_interrogative sub [imperative, interrogative].
  none_or_local sub [local, none].
    local sub []
          intro [cat:cat,
                 cont:hook].
    none sub [].
  none_or_synsem sub [none, synsem].
    synsem sub []
           intro [loc:local,
                  nonloc:nonloc,
                  trace:minus_or_extraction_or_vm,
                  lex:bool,
                  phrase:bool,
                  max_:bool].
  nonloc sub []
         intro [rel:list,
                slash:list].
  num sub [pl, sg].
    pl sub [].
    sg sub [].
  per sub [first_or_third, second_or_third].
    first_or_third sub [first, third].
      first sub [].
      third sub [].
    second_or_third sub [second, third].
      second sub [].
  pform sub [an_pform, von_pform].
    an_pform sub [].
    von_pform sub [].
  qeq sub []
      intro [harg:handle,
             larg:handle].
  relation sub [arg0_relation, arg1_relation, arg2_relation, arg3_relation]
           intro [lbl:handle].
    arg0_relation sub [affe_rel, arg01_relation, arg02_relation, ball_rel, beamter_rel, beispiel_rel, buch_rel, conjunction_rel, einhorn_rel, ergebnis_rel, fahrrad_rel, film_rel, frau_rel, kind_rel, mann_rel, mitarbeiter_rel, mädchen_rel, mörder_rel, named_rel, pronoun_rel, quant_rel, roman_rel, speisekammer_rel, stock_rel, tofu_rel, wurst_rel]
                  intro [arg0:event_or_index].
      affe_rel sub [].
      arg01_relation sub [arg012_relation, bellen_rel, grauen_rel, lachen_rel, schlafen_rel, spielen_rel].
        arg012_relation sub [arg0123_relation, denken_an_rel, freuen_rel, glauben_rel, helfen_rel, jagen_rel, kennen_rel, lesen_rel, lieben_rel, nehmen_rel, poss_rel, singen_rel].
          arg0123_relation sub [geben_rel].
            geben_rel sub [].
          denken_an_rel sub [].
          freuen_rel sub [].
          glauben_rel sub [].
          helfen_rel sub [].
          jagen_rel sub [].
          kennen_rel sub [].
          lesen_rel sub [].
          lieben_rel sub [].
          nehmen_rel sub [].
          poss_rel sub [].
          singen_rel sub [].
        bellen_rel sub [].
        grauen_rel sub [].
        lachen_rel sub [].
        schlafen_rel sub [].
        spielen_rel sub [].
      arg02_relation sub [arg012_relation, arg023_relation, bild_rel, tochter_rel].
        arg023_relation sub [].
        bild_rel sub [].
        tochter_rel sub [].
      ball_rel sub [].
      beamter_rel sub [].
      beispiel_rel sub [].
      buch_rel sub [].
      conjunction_rel sub [conjunction_n_rel, conjunction_v_rel, und_rel]
                      intro [lindex:event_or_index,
                             rindex:event_or_index].
        conjunction_n_rel sub [und_n_rel]
                          intro [arg0:index].
          und_n_rel sub [].
        conjunction_v_rel sub [und_v_rel]
                          intro [arg0:event,
                                 lhandle:handle,
                                 rhandle:handle].
          und_v_rel sub [].
        und_rel sub [und_n_rel, und_v_rel].
      einhorn_rel sub [].
      ergebnis_rel sub [].
      fahrrad_rel sub [].
      film_rel sub [].
      frau_rel sub [].
      kind_rel sub [].
      mann_rel sub [].
      mitarbeiter_rel sub [].
      mädchen_rel sub [].
      mörder_rel sub [].
      named_rel sub []
                intro [name:(a_ _)].
      pronoun_rel sub [].
      quant_rel sub [def_q, every_q, exists_q, pronoun_q, proper_q, udef_q]
                intro [rstr:handle,
                       body:handle].
        def_q sub [].
        every_q sub [].
        exists_q sub [].
        pronoun_q sub [].
        proper_q sub [].
        udef_q sub [].
      roman_rel sub [].
      speisekammer_rel sub [].
      stock_rel sub [].
      tofu_rel sub [].
      wurst_rel sub [].
    arg1_relation sub [angeblich_rel, arg01_relation, arg12_relation, groß_rel, interessant_rel, klein_rel, klug_rel, morgen_rel, mutmaßlich_rel, nicht_rel, oft_rel, schwierig_rel, schön_rel, wahrscheinlich_rel]
                  intro [arg1:event_or_index].
      angeblich_rel sub [].
      arg12_relation sub [in_rel, treu_rel].
        in_rel sub [].
        treu_rel sub [].
      groß_rel sub [].
      interessant_rel sub [].
      klein_rel sub [].
      klug_rel sub [].
      morgen_rel sub [].
      mutmaßlich_rel sub [].
      nicht_rel sub [].
      oft_rel sub [].
      schwierig_rel sub [].
      schön_rel sub [].
      wahrscheinlich_rel sub [].
    arg2_relation sub [arg02_relation, arg12_relation]
                  intro [arg2:event_or_index].
    arg3_relation sub [arg0123_relation, arg023_relation]
                  intro [arg3:event_or_index].
  sign sub [empty_rel_sign, empty_slash_sign, isect_modifier, lexical_sign, n_modifier, overt_sign, phrase, spr_saturated_sign, v_modifier]
       intro [phon:list,
              synsem:synsem,
              v2:bool,
              rels:list,
              hcons:list].
    empty_rel_sign sub [complementizer_like_sign, empty_rel_word].
      complementizer_like_sign sub [complementizer_word, verb_initial_rule].
        complementizer_word sub [].
        verb_initial_rule sub [].
      empty_rel_word sub [conj_word, det_noun_word, determiner, n_modifier_word, non_overt_word, pers_pronoun, preposition_word, proper_noun, simple_possessive, v_modifier_word, verb_word].
        conj_word sub [].
        det_noun_word sub [relational_noun, simple_noun].
          relational_noun sub [].
          simple_noun sub [].
        determiner sub [empty_determiner, overt_determiner].
          empty_determiner sub [].
          overt_determiner sub [].
        n_modifier_word sub [attr_adjective_word, isect_n_modifier_word].
          attr_adjective_word sub [attr_np_adj, scopal_adj, simple_attr_adj].
            attr_np_adj sub [].
            scopal_adj sub [].
            simple_attr_adj sub [].
          isect_n_modifier_word sub [intersective_adj].
            intersective_adj sub [attr_np_adj, simple_attr_adj].
        non_overt_word sub [empty, trace].
          empty sub [empty_determiner].
          trace sub [].
        pers_pronoun sub [].
        preposition_word sub [comp_preposition, mod_preposition].
          comp_preposition sub [].
          mod_preposition sub [noun_mod_preposition, verb_mod_preposition].
            noun_mod_preposition sub [location_noun_mod_prep].
              location_noun_mod_prep sub [].
            verb_mod_preposition sub [location_verb_mod_prep].
              location_verb_mod_prep sub [].
        proper_noun sub [].
        simple_possessive sub [].
        v_modifier_word sub [adv_word, scopal_v_modifier_le].
          adv_word sub [isect_adv_word, scopal_adv_word].
            isect_adv_word sub [].
            scopal_adv_word sub [].
          scopal_v_modifier_le sub [scopal_adv_word].
        verb_word sub [arg1_verb, arg2_verb, arg3_verb, dobj_np_verb, scopal_arg2_verb].
          arg1_verb sub [arg12_verb, one_place_verb, subj_np_verb].
            arg12_verb sub [arg123_verb, two_place_verb].
              arg123_verb sub [three_place_verb].
                three_place_verb sub [np_np_np_verb].
                  np_np_np_verb sub [].
              two_place_verb sub [np_np_dat_verb, np_pp_verb, strict_trans_verb].
                np_np_dat_verb sub [].
                np_pp_verb sub [].
                strict_trans_verb sub [cp_np_verb, np_np_verb].
                  cp_np_verb sub [].
                  np_np_verb sub [].
            one_place_verb sub [cp_verb, np_verb, subjlos_np_verb].
              cp_verb sub [].
              np_verb sub [].
              subjlos_np_verb sub [].
            subj_np_verb sub [glauben_denken_verb, np_np_dat_verb, np_np_np_verb, np_np_verb, np_pp_verb, np_verb].
              glauben_denken_verb sub [].
          arg2_verb sub [arg12_verb].
          arg3_verb sub [arg123_verb].
          dobj_np_verb sub [np_np_np_verb, strict_trans_verb].
          scopal_arg2_verb sub [glauben_denken_verb].
    empty_slash_sign sub [empty_slash_word].
      empty_slash_word sub [empty].
    isect_modifier sub [isect_modifier_le, isect_n_modifier].
      isect_modifier_le sub [isect_n_modifier_le, isect_v_modifier_le].
        isect_n_modifier_le sub [isect_n_modifier_word, noun_mod_preposition].
        isect_v_modifier_le sub [isect_adv_word, verb_mod_preposition].
      isect_n_modifier sub [rc].
        rc sub [].
    lexical_sign sub [arg0_le, ltop_lbl_le, non_relational_le, non_scopal_le, transparent_head_le, word].
      arg0_le sub [arg0_ltop_lbl_le].
        arg0_ltop_lbl_le sub [relational_arg0_word].
          relational_arg0_word sub [conj_word, det_noun_word, verb_word].
      ltop_lbl_le sub [arg0_ltop_lbl_le, relational_word, scopal_modifier_le].
        relational_word sub [mod_preposition, n_modifier_word, relational_arg0_word, v_modifier_word].
        scopal_modifier_le sub [scopal_adj, scopal_v_modifier_le].
      non_relational_le sub [non_scopal_non_relational_le].
        non_scopal_non_relational_le sub [non_relational_rel_pronoun, pers_pronoun, trace, transparent_non_scopal_non_relational_le].
          non_relational_rel_pronoun sub [nominal_rel_pronoun].
            nominal_rel_pronoun sub [].
          transparent_non_scopal_non_relational_le sub [comp_preposition, complementizer_word].
      non_scopal_le sub [cp_np_verb, cp_verb, det_noun_word, isect_modifier_le, non_scopal_non_relational_le, np_np_dat_verb, np_np_np_verb, np_np_verb, np_pp_verb, np_verb, preposition_word, subjlos_np_verb].
      transparent_head_le sub [transparent_non_scopal_non_relational_le].
      word sub [empty_rel_word, empty_slash_word, overt_word, relational_word, saturated_word].
        overt_word sub [complementizer_word, conj_word, n_modifier_word, noun_word, overt_determiner, preposition_word, pronoun, v_modifier_word, verb_word].
          noun_word sub [det_noun_word, nominal_pronoun, proper_noun].
            nominal_pronoun sub [nominal_rel_pronoun, pers_pronoun].
          pronoun sub [nominal_pronoun, rel_pronoun].
            rel_pronoun sub [non_relational_rel_pronoun, possessive_rel_pronoun].
              possessive_rel_pronoun sub [].
        saturated_word sub [adv_word, determiner_word, pronoun, proper_noun, scopal_adj, simple_attr_adj].
          determiner_word sub [determiner, possessive].
            possessive sub [possessive_rel_pronoun, simple_possessive].
    n_modifier sub [isect_n_modifier, isect_n_modifier_le, n_modifier_word].
    overt_sign sub [complementizer_like_sign, overt_word].
    phrase sub [coord_phrase, cp_to_np, filler_phrase, headed_phrase, verb_initial_rule]
           intro [dtrs:list].
      coord_phrase sub [].
      cp_to_np sub [].
      filler_phrase sub [head_filler_phrase, rc].
        head_filler_phrase sub [].
      headed_phrase sub [head_non_adjunct_phrase, head_non_complement_phrase, head_non_filler_phrase, head_non_specifier_phrase, headed_flexible_order_phrase]
                    intro [head_dtr:sign].
        head_non_adjunct_phrase sub [head_complement_phrase, head_filler_phrase, head_specifier_phrase].
          head_complement_phrase sub [].
          head_specifier_phrase sub [].
        head_non_complement_phrase sub [head_adjunct_phrase, head_filler_phrase, head_specifier_phrase].
          head_adjunct_phrase sub [].
        head_non_filler_phrase sub [head_adjunct_phrase, head_complement_phrase, head_specifier_phrase].
        head_non_specifier_phrase sub [head_adjunct_phrase, head_complement_phrase, head_filler_phrase].
        headed_flexible_order_phrase sub [head_adjunct_phrase, head_complement_phrase, head_filler_phrase, head_specifier_phrase]
                                     intro [non_head_dtrs:list].
    spr_saturated_sign sub [complementizer_like_sign, saturated_word].
    v_modifier sub [isect_v_modifier_le, v_modifier_word].
  string sub [].
  vform sub [fin].
    fin sub [].
