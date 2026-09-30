% -*- coding:utf-8; mode:trale-prolog -*-
% Generated from signature by ../Gemeinsames/tdl_to_signature.py.
% Do not edit: regenerate after changes to signature.
% Load with ale_flag(subintro,_,grammar) and ale_flag(msl,_,off).

bot sub [case, head, list, none_or_sign, pform, vform].
  case sub [acc, dat, gen, nom].
    acc sub [].
    dat sub [].
    gen sub [].
    nom sub [].
  head sub [adj, intro_case_head, non_modifier, prep]
       intro [mod:none_or_sign].
    adj sub [attr_adj].
      attr_adj sub [].
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
  none_or_sign sub [none, sign].
    none sub [].
    sign sub [phrase, word]
         intro [phon:list,
                head:head,
                spr:list,
                comps:list].
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
  pform sub [an_pform].
    an_pform sub [].
  vform sub [fin].
    fin sub [].
