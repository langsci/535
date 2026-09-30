% -*- coding:utf-8; mode:trale-prolog -*-
% Generated from signature by ../Gemeinsames/tdl_to_signature.py.
% Do not edit: regenerate after changes to signature.
% Load with ale_flag(subintro,_,grammar) and ale_flag(msl,_,off).

bot sub [case, list, none_or_sign, p_o_s, pform, vform].
  case sub [acc, dat, gen, nom].
    acc sub [].
    dat sub [].
    gen sub [].
    nom sub [].
  list sub [e_list, ne_list].
    e_list sub [].
    ne_list sub []
            intro [hd:bot,
                   tl:list].
  none_or_sign sub [none, sign].
    none sub [].
    sign sub [phrase, word]
         intro [phon:list,
                p_o_s:p_o_s,
                mod:none_or_sign,
                spr:list,
                comps:list,
                arg_st:list].
      phrase sub [headed_phrase, non_headed_phrase]
             intro [non_head_dtrs:list,
                    dtrs:list].
        headed_phrase sub [head_adjunct_phrase, head_complement_phrase, head_specifier_phrase]
                      intro [head_dtr:sign].
          head_adjunct_phrase sub [].
          head_complement_phrase sub [].
          head_specifier_phrase sub [].
        non_headed_phrase sub [].
      word sub [].
  p_o_s sub [adj, det, noun, prep, verb].
    adj sub [].
    det sub [].
    noun sub [].
    prep sub [].
    verb sub [].
  pform sub [an_pform].
    an_pform sub [].
  vform sub [fin].
    fin sub [].
