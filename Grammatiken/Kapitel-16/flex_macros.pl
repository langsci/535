% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: flex_macros.pl,v $
%%  $Revision: 1.4 $
%%      $Date: 2006/08/18 13:07:25 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.

noun_infl(UmlautStem-(a_ _),FK-fk_n,GenE-bool,DatE-bool,EvorN-bool,KUmw-bool) :=
  (infl:(umlaut:UmlautStem,
         affix:(fk:FK,
                gen_e:GenE,
                dat_e:DatE,
                e_vor_n:EvorN),
         k_umw:KUmw)).

pl_stem(Stem-(a_ _)) :=
  (infl:umlaut:Stem).

noun_flex_fk(FK) :=
  (infl:affix:fk:FK).

noun_flex_gen_e(Gen) :=
  (infl:affix:gen_e:Gen).

noun_flex_dat_e(Dat) :=
  (infl:affix:dat_e:Dat).

noun_flex_e_vor_n(Dat) :=
  (infl:affix:e_vor_n:Dat).

noun_flex_kumw(KUmw) :=
  (infl:k_umw:KUmw).


conj_stem(Stem-(a_ _)) :=
  (infl:v_stems:conj:Stem).

pres2_stem(Stem-(a_ _)) :=
  (infl:v_stems:pres2:Stem).

part_stem(Stem-(a_ _)) :=
  (infl:v_stems:part:Stem).

past_stem(Stem-(a_ _)) :=
  (infl:v_stems:past:Stem).

imp2_stem :=
  (infl:v_stems:(pres2:Stem,
                 imp_st:Stem)).

vflex_fk(FK-fk_v) :=
  (infl:fk:FK).

vflex_ep(Val-bool) :=
  (infl:morphophon:ep:Val).

vflex_evp(Val-bool) :=
  (infl:morphophon:evp:Val).

vflex_epp(Val-bool) :=
  (infl:morphophon:epp:Val).

vflex_sm(Val-bool) :=
  (infl:morphophon:sm:Val).

vflex_pl_n(Val-bool) :=
  (infl:morphophon:pl_n:Val).

vflex_spe(Val-bool) :=
  (infl:morphophon:spe:Val).

vflex_tm(Val-bool_or_t) :=
  (infl:morphophon:tm:Val).

vflex_em(Val-bool) :=
  (infl:morphophon:em:Val).

vflex_bet1(Val-bool) :=
  (infl:bet1:Val).




a_infl_affix(Phon,Num,Gen,Case,DType) :=
 (phon:Phon,
  num:Num,
  gen:Gen,
  morph_case:Case,
  dtype:DType).



fin_v_infl_affix(Phon,FK,Sem,Per,Num) :=
 (phon:Phon,
  fk:FK,
  temo:Sem,
  per:Per,
  num:Num).

fin_v_infl_affix(Phon,FK,Sem,MorphoPhon,Per,Num) :=
 (@fin_v_infl_affix(Phon,FK,Sem,Per,Num),
  morphophon:MorphoPhon).
