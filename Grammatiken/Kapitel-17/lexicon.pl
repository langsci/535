% -*- coding: utf-8; mode: trale-prolog -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.7 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile     '--->'/2.
:- discontiguous '--->'/2.
:- multifile '*>'/2.

das ---> @det(nom_or_acc,sg,neu,strong,def_q).

der ---> @det(nom,sg,mas,strong,def_q).

% wir gedenken der Frau
% wir helfen der Frau
der ---> @det(gen_or_dat,sg,fem,strong,def_q).


% dem Mann/Buch
dem --->  @det(dat,sg,mas_or_neu,strong,def_q).

% den Mann
den ---> @det(acc,sg,mas,strong,def_q).


des ---> @det(gen,sg,mas_or_neu,strong,def_q).

die ---> @det(nom_or_acc,sg,fem,strong,def_q).


die ---> @det(nom_or_acc,pl,strong,def_q).
den ---> @det(dat,       pl,strong,def_q).
der ---> @det(gen,       pl,strong,def_q).


ein   ---> @det(nom,       sg,mas,       weak,  exists_q).
ein   ---> @det(nom_or_acc,sg,neu,       weak,  exists_q).
eine  ---> @det(nom_or_acc,sg,fem,       strong,exists_q).
einen ---> @det(acc,       sg,mas,       strong,exists_q).
einem ---> @det(dat,       sg,mas_or_neu,strong,exists_q).

einer ---> @det(gen_or_dat,sg,fem,       strong,exists_q).
eines ---> @det(gen,       sg,mas_or_neu,strong,exists_q).


jede  ---> @det(nom_or_acc,sg,fem,       strong,every_q).
jedem ---> @det(dat,       sg,mas_or_neu,strong,every_q).
jeder ---> @det(gen_or_dat,sg,fem,       strong,every_q).
jeder ---> @det(nom,       sg,mas,       strong,every_q).
jedes ---> @det(nom_or_acc,sg,neu,       strong,every_q).


die    ---> @rel_pronoun(nom_or_acc,third,sg,fem).
der    ---> @rel_pronoun(gen_or_dat,third,sg,fem).

der    ---> @rel_pronoun(nom,third,sg,mas).

dessen ---> @rel_pronoun(gen,third,sg,mas_or_neu).
dem    ---> @rel_pronoun(dat,third,sg,mas_or_neu).

den    ---> @rel_pronoun(acc,third,sg,mas).

das    ---> @rel_pronoun(nom_or_acc,third,sg,neu).


dessen ---> @possessive_rel_pronoun(mas_or_neu,sg).
deren  ---> @possessive_rel_pronoun(fem,sg).


% Nomina neutr

buch    ---> @noun(nom_or_dat_or_acc,neu,sg,buch_rel,info_bearer).
buches  ---> @noun(gen,              neu,sg,buch_rel,info_bearer).
bücher  ---> @noun(nom_or_gen_or_acc,neu,pl,buch_rel,info_bearer).
büchern ---> @noun(dat,              neu,pl,buch_rel,info_bearer).

kind   ---> @noun(nom_or_dat_or_acc,neu,sg,kind_rel,human).
kindes ---> @noun(gen,              neu,sg,kind_rel,human).
kinder ---> @noun(nom_or_gen_or_acc,neu,pl,kind_rel,human).
kindern ---> @noun(dat,             neu,pl,kind_rel,human).


beispiel ---> @noun(nom_or_dat_or_acc,neu,sg,beispiel_rel,info_content).

bild     ---> @relational_noun(nom_or_dat_or_acc,neu,sg,bild_rel,info_bearer).

einhorn  ---> @noun(nom_or_dat_or_acc,neu,sg,einhorn_rel,animal).
einhorns ---> @noun(gen,              neu,sg,einhorn_rel,animal).

fahrrad  ---> @noun(nom_or_dat_or_acc,neu,sg,fahrrad_rel,vehicle).
fahrrads ---> @noun(gen,              neu,sg,fahrrad_rel,vehicle).

lied    ---> @noun(nom_or_dat_or_acc,neu,sg,lied_rel,info_content).
liedes  ---> @noun(gen,              neu,sg,lied_rel,info_content).
lieder  ---> @noun(nom_or_gen_or_acc,neu,pl,lied_rel,info_content).
liedern ---> @noun(dat,              neu,pl,lied_rel,info_content).


märchen  ---> @noun(nom_or_dat_or_acc,neu,sg,märchen_rel,info_content).
märchens ---> @noun(gen,              neu,sg,märchen_rel,info_content).
märchen  ---> @noun(case,             neu,pl,märchen_rel,info_content).

% Achtung! Mädchen hat das Genus Neutrum, für Pronomenbindung
% ist allerdings feminin oder neutrum möglich.
% Das Mädchen ... Sie/es ...

mädchen  ---> @noun(nom_or_dat_or_acc,neu,  fem_or_neu,sg,mädchen_rel,human).
mädchens ---> @noun(gen,              neu,  fem_or_neu,sg,mädchen_rel,human).
mädchen  ---> @noun(case,             genus,fem_or_neu,pl,mädchen_rel,human).


% Nomina mask

affe   ---> @noun(nom,              mas,sg,affe_rel,animal).
affen  ---> @noun(gen_or_dat_or_acc,mas,sg,affe_rel,animal).
affen  ---> @noun(case,             mas,pl,affe_rel,animal).

aufsatz   ---> @noun(nom_or_dat_or_acc,mas,sg,aufsatz_rel,info_bearer).
aufsatzes ---> @noun(gen,              mas,sg,aufsatz_rel,info_bearer).
aufsätze  ---> @noun(nom_or_gen_or_acc,mas,pl,aufsatz_rel,info_bearer).
aufsätzen ---> @noun(dat,              mas,pl,aufsatz_rel,info_bearer).

ball   ---> @noun(nom_or_dat_or_acc,mas,sg,ball_rel).
balls  ---> @noun(gen,              mas,sg,ball_rel).
bälle  ---> @noun(nom_or_gen_or_acc,mas,pl,ball_rel).
bällen ---> @noun(dat,              mas,pl,ball_rel).

film   ---> @noun(nom_or_dat_or_acc,mas,sg,film_rel).
films  ---> @noun(gen,              mas,sg,film_rel).
filme  ---> @noun(nom_or_gen_or_acc,mas,pl,film_rel).
filmen ---> @noun(dat,              mas,pl,film_rel).

kran    ---> @noun(nom_or_dat_or_acc,mas,sg,kran_rel,instrument).
kranes  ---> @noun(gen,              mas,sg,kran_rel,instrument).
kräne   ---> @noun(nom_or_gen_or_acc,mas,pl,kran_rel,instrument).
kränen  ---> @noun(dat,              neu,pl,kran_rel,instrument).

lügner  ---> @noun(nom_or_dat_or_acc,mas,sg,lügner_rel,human).
lügners ---> @noun(gen,              mas,sg,lügner_rel,human).
lügner  ---> @noun(nom_or_gen_or_acc,mas,pl,lügner_rel,human).
lügnern ---> @noun(dat,              neu,pl,lügner_rel,human).


mann    ---> @noun(nom_or_dat_or_acc,mas,sg,mann_rel,human).
mannes  ---> @noun(gen,              mas,sg,mann_rel,human).
männer  ---> @noun(nom_or_gen_or_acc,mas,pl,mann_rel,human).
männern ---> @noun(dat,              mas,pl,mann_rel,human).

mitarbeiter  ---> @noun(nom_or_dat_or_acc,mas,sg,mitarbeiter_rel,human).
mitarbeiters ---> @noun(gen,              mas,sg,mitarbeiter_rel,human).
mitarbeiter  ---> @noun(nom_or_gen_or_acc,mas,pl,mitarbeiter_rel,human).
mitarbeitern ---> @noun(dat,              mas,pl,mitarbeiter_rel,human).

mörder  ---> @noun(nom_or_dat_or_acc,mas,sg,mörder_rel,human).
mörders ---> @noun(gen,              mas,sg,mörder_rel,human).
mörder  ---> @noun(nom_or_gen_or_acc,mas,pl,mörder_rel,human).
mördern ---> @noun(dat,              neu,pl,mörder_rel,human).

roman   ---> @noun(nom_or_dat_or_acc,mas,sg,roman_rel,info_bearer).
romans  ---> @noun(gen,              mas,sg,roman_rel,info_bearer).
romane  ---> @noun(nom_or_gen_or_acc,mas,pl,roman_rel,info_bearer).
romanen ---> @noun(dat,              mas,pl,roman_rel,info_bearer).

sohn    ---> @noun(nom_or_dat_or_acc,mas,sg,sohn_rel).
sohnes  ---> @noun(gen,              mas,sg,sohn_rel).
söhne   ---> @noun(nom_or_gen_or_acc,mas,pl,sohn_rel).
söhnen  ---> @noun(dat,              neu,pl,sohn_rel).

stock    ---> @noun(nom_or_dat_or_acc,mas,sg,stock_rel,thing).
stockes  ---> @noun(gen,              mas,sg,stock_rel,thing).
stöcker  ---> @noun(nom_or_gen_or_acc,mas,pl,stock_rel,thing).
stöckern ---> @noun(dat,              mas,pl,stock_rel,thing).

eis   ---> @noun(nom_or_dat_or_acc,neu,sg,eis_rel,substance).
eises ---> @noun(gen,              neu,sg,eis_rel,substance).

wagen   ---> @noun(nom_or_dat_or_acc,mas,sg,wagen_rel,vehicle).
wagens  ---> @noun(gen,              mas,sg,wagen_rel,vehicle).
wagen   ---> @noun(case,             mas,pl,wagen_rel,vehicle).


% Nomina fem

frau   ---> @noun(case,fem,sg,frau_rel,human).
frauen ---> @noun(case,fem,pl,frau_rel,human).

speisekammer  ---> @noun(case,fem,sg,speisekammer_rel,nongeo_location).
speisekammern ---> @noun(case,fem,pl,speisekammer_rel,nongeo_location).

tochter  ---> @relational_noun(case,             fem,sg,tochter_rel,human).
töchter  ---> @relational_noun(nom_or_gen_or_acc,fem,pl,tochter_rel,human).
töchtern ---> @relational_noun(dat,              fem,pl,tochter_rel,human).

überraschung   ---> @noun(case,fem,sg,überraschung_rel,situation).
überraschungen ---> @noun(case,fem,pl,überraschung_rel,situation).

wurst   ---> @noun(case,             fem,sg,wurst_rel,food).
würste  ---> @noun(nom_or_gen_or_acc,fem,pl,wurst_rel,food).
würsten ---> @noun(dat,              fem,pl,wurst_rel,food).

zeitschrift   ---> @noun(case,fem,sg,zeitschrift_rel,info_bearer).
zeitschriften ---> @noun(case,fem,pl,zeitschrift_rel,info_bearer).


% adjektivisch flektierte Nomina
% Die Flexionsinformation ist identisch mit der der Adjektive,
% außer daß das Genus nie neutrum ist, da Beamte immer mas
% oder fem sind.
%
% Auskommentierte Formen werden nicht gebraucht. Bei Adjektiven sind
% sie notwendig, da der Artikel wegfallen kann:
%
% Er rechnet mit frischer Milch.
%
% Für den Nominativ & Akkusativ braucht man die Formen aber, da in Kopulakonstruktionen
% der Artikel wegfallen kann zulässig ist.
% 
% Er ist Beamter.
% Er ließ ihn Beamten werden.


beamte ---> @adj_noun(nom_or_acc,fem,        sg,dtype, beamter_rel,human).
beamte ---> @adj_noun(nom,       mas,        sg,strong,beamter_rel,human).
beamte ---> @adj_noun(nom_or_acc,fem_or_mas, pl,weak,  beamter_rel,human).

beamten ---> @adj_noun(gen_or_dat,fem_or_mas,sg,strong,beamter_rel,human).
%beamten ---> @adj_noun(gen,       mas,       sg,weak,  beamter_rel,human).  % nicht gebraucht
beamten ---> @adj_noun(case,      fem_or_mas,pl,strong,beamter_rel,human).
beamten ---> @adj_noun(acc,       mas,       sg,dtype, beamter_rel,human).
beamten ---> @adj_noun(gen,       mas,       pl,weak,  beamter_rel,human).
beamten ---> @adj_noun(dat,       fem_or_mas,pl,weak,  beamter_rel,human).

%beamtem ---> @adj_noun(dat,       mas,       sg,weak,  beamter_rel,human).  % nicht gebraucht


%
%beamter ---> @noun(gen_or_dat,fem,       sg,weak,  beamter_rel,human).      % nicht gebraucht

beamter ---> @adj_noun(nom,       mas,       sg,weak,  beamter_rel,human).
beamter ---> @adj_noun(gen,       fem_or_mas,pl,weak,  beamter_rel,human).




% Personalpronomina

ich    ---> @pers_pronoun(nom,first,sg).
meiner ---> @pers_pronoun(gen,first,sg).
mir    ---> @pers_pronoun(dat,first,sg).
mich   ---> @pers_pronoun(acc,first,sg).


du     ---> @pers_pronoun(nom,second,sg).
deiner ---> @pers_pronoun(gen,second,sg).
dir    ---> @pers_pronoun(dat,second,sg).
dich   ---> @pers_pronoun(acc,second,sg).


er     ---> @pers_pronoun(nom,third,sg,mas).
seiner ---> @pers_pronoun(gen,third,sg,mas_or_neu).
ihm    ---> @pers_pronoun(dat,third,sg,mas_or_neu).
ihn    ---> @pers_pronoun(acc,third,sg,mas).

sie   ---> @pers_pronoun(nom_or_acc,third,sg,fem).
ihrer ---> @pers_pronoun(gen,       third,sg,fem).
ihr   ---> @pers_pronoun(dat,       third,sg,fem).

es    ---> @pers_pronoun(nom_or_acc,third,sg,neu).


wir     ---> @pers_pronoun(nom,       first,pl).
unserer ---> @pers_pronoun(gen,       first,pl).
uns     ---> @pers_pronoun(dat_or_acc,first,pl).


ihr   ---> @pers_pronoun(nom,       second,pl).
eurer ---> @pers_pronoun(gen,       second,pl).
euch  ---> @pers_pronoun(dat_or_acc,second,pl).


sie   ---> @pers_pronoun(nom_or_acc,third,pl).
ihrer ---> @pers_pronoun(gen,       third,pl).
ihnen ---> @pers_pronoun(dat,       third,pl).

% Expletivum

es    ---> expl_pronoun.

% Possessivpronomina

% Syntaktische Eigenschaften erst, dann semantische sein = mas, ihr = fem

mein   ---> @possessive(nom,       first, sg,genus,     sg,mas,       weak).
mein   ---> @possessive(nom_or_acc,first, sg,genus,     sg,neu,       weak).
meine  ---> @possessive(nom_or_acc,first, sg,genus,     sg,fem,       strong).
meine  ---> @possessive(nom_or_acc,first, sg,genus,     pl,genus,     strong).

meinen ---> @possessive(acc,       first, sg,genus,     sg,mas,       strong).
meinen ---> @possessive(dat,       first, sg,genus,     pl,genus,     strong).

meinem ---> @possessive(dat,       first, sg,genus,     sg,mas_or_neu,strong).

meiner ---> @possessive(gen_or_dat,first, sg,genus,     sg,fem,       strong).
meiner ---> @possessive(gen,       first, sg,genus,     pl,genus,     strong).

meines ---> @possessive(gen,       first, sg,genus,     sg,mas_or_neu,strong).

dein   ---> @possessive(nom,       second,sg,genus,     sg,mas,       weak).
dein   ---> @possessive(nom_or_acc,second,sg,genus,     sg,neu,       weak).
deine  ---> @possessive(nom_or_acc,second,sg,genus,     sg,fem,       strong).
deine  ---> @possessive(nom_or_acc,second,sg,genus,     pl,genus,     strong).

deinen ---> @possessive(acc,       second,sg,genus,     sg,mas,       strong).
deinen ---> @possessive(dat,       second,sg,genus,     pl,genus,     strong).

deinem ---> @possessive(dat,       second,sg,genus,     sg,mas_or_neu,strong).

deiner ---> @possessive(gen_or_dat,second,sg,genus,     sg,fem,       strong).
deiner ---> @possessive(gen,       second,sg,genus,     pl,genus,     strong).

deines ---> @possessive(gen,       second, sg,genus,    sg,mas_or_neu,strong).

sein   ---> @possessive(nom,       third, sg,mas_or_neu,sg,mas,       weak).
sein   ---> @possessive(nom_or_acc,third, sg,mas_or_neu,sg,neu,       weak).
seine  ---> @possessive(nom_or_acc,third, sg,mas_or_neu,sg,fem,       strong).
seine  ---> @possessive(nom_or_acc,third, sg,mas_or_neu,pl,genus,     strong).

seinen ---> @possessive(acc,       third, sg,mas_or_neu,sg,mas,       strong).
seinen ---> @possessive(dat,       third, sg,mas_or_neu,pl,genus,     strong).

seinem ---> @possessive(dat,       third, sg,mas_or_neu,sg,mas_or_neu,strong).

seiner ---> @possessive(gen_or_dat,third, sg,mas_or_neu,sg,fem,       strong).
seiner ---> @possessive(gen,       third, sg,mas_or_neu,pl,genus,     strong).

seines ---> @possessive(gen,       third, sg,mas_or_neu,sg,mas_or_neu,strong).

ihr   ---> @possessive(nom,       third, sg,fem,sg,mas,       weak).
ihr   ---> @possessive(nom_or_acc,third, sg,fem,sg,neu,       weak).
ihre  ---> @possessive(nom_or_acc,third, sg,fem,sg,fem,       strong).
ihre  ---> @possessive(nom_or_acc,third, sg,fem,pl,genus,     strong).

ihren ---> @possessive(acc,       third, sg,fem,sg,mas,       strong).
ihren ---> @possessive(dat,       third, sg,fem,pl,genus,     strong).

ihrem ---> @possessive(dat,       third, sg,fem,sg,mas_or_neu,strong).

ihrer ---> @possessive(gen_or_dat,third, sg,fem,sg,fem,       strong).
ihrer ---> @possessive(gen,       third, sg,fem,pl,genus,     strong).

ihres ---> @possessive(gen,       third, sg,fem,sg,mas_or_neu,strong).


aicke ---> @proper_noun(fem_or_mas,'Aicke').

conny ---> @proper_noun(fem_or_mas,'Conny').

% Verben

% Menschen und Elefanten?
arbeit  ---> @intrans_verb(arbeiten_rel,activity,agentive),
            @vflex_fk(v_weak),

            @vflex_ep(plus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_em(minus),
            @vflex_bet1(plus).

% Hunde und auch Menschen
bell    ---> @intrans_verb(bellen_rel,activity,agentive),
            @vflex_fk(v_weak),
 
            @vflex_ep(minus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_em(minus),
            @vflex_bet1(plus).

lach    ---> @intrans_verb(lachen_rel,activity,agentive),
            @vflex_fk(v_weak),
 
            @vflex_ep(minus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_em(minus),
            @vflex_bet1(plus).


schlaf ---> @intrans_verb(schlafen_rel,activity,agentive),
           @pres2_stem(a_ schläf),
           @past_stem(a_ schlief),
            
           @vflex_fk(v_strong),
           @vflex_ep(minus),
           @vflex_evp(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

tanz   ---> @intrans_verb(tanzen_rel,activity,agentive),
           @vflex_fk(v_weak),
 
           @vflex_ep(minus),
           @vflex_sm(plus),
           @vflex_pl_n(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).


sterb  ---> @intrans_unacc_verb(sterben_rel,achievement,anything),
           @pres2_stem(a_ stirb),
           @past_stem(a_ starb),
           @part_stem(a_ storb),
           
           @conj_stem(a_ stürb),
           @imp2_stem,
           @vflex_fk(v_strong),
              
           @vflex_ep(minus),
           @vflex_evp(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

regn  --->  @expl_np_verb(regnen_rel),
           @vflex_fk(v_weak),
 
           @vflex_ep(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

% eigentlich würde man hier `auffallen' nehmen, aber das ist leider ein Partikelverb.
geling ---> @np_np_unacc_verb(dat,gelingen_rel,achievement,anything,agentive),
           @past_stem(a_ gelang),
           @part_stem(a_ gelung),
              
           @conj_stem(a_ geläng),
              
           @vflex_fk(v_strong),
              
           @vflex_ep(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
%          @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(minus).


% der Wind?
spiel  ---> @intrans_verb(spielen_rel,activity,agentive),
            @vflex_fk(v_weak),

            @vflex_ep(minus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_em(minus),
            @vflex_bet1(plus).


grau   ---> @subjlos_verb(dat,grauen_rel,state,human),
           @vflex_fk(v_weak),
 
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

% Die Tablette hilft. Das Buch hilft mir.
% ? Der Plan hilft mir. Erst mal Objekt
helf   ---> @np_np_dat_verb(helfen_rel,accomplishment_or_achievement_or_activity,object,agentive),

           @pres2_stem(a_ hilf),
           @past_stem(a_ half),
           @part_stem(a_ holf),
           @conj_stem(a_ hülf),
           @imp2_stem,
           
           @vflex_fk(v_strong),
           
           @vflex_ep(minus),
           @vflex_evp(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).


jag    ---> @trans_verb(jagen_rel,activity,agentive,agentive),
           @vflex_fk(v_weak),
 
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).


kenn  --->  @trans_verb(kennen_rel,state,agentive,anything),
           @past_stem(a_ kann),
           @part_stem(a_ kann),
            
           @vflex_fk(mixed),
           
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

les  ---> @trans_verb(lesen_rel,accomplishment_or_activity,agentive,info_bearer),
         @pres2_stem(a_ lies),

         @past_stem(a_ las),
         @part_stem(a_ les),
         @conj_stem(a_ läs),
         @imp2_stem,
         @vflex_fk(v_strong),
           
         @vflex_ep(minus),
         @vflex_evp(minus),
         @vflex_epp(plus),
         @vflex_sm(plus),
         @vflex_pl_n(minus),
         @vflex_spe(plus),
         @vflex_tm(minus),
         @vflex_em(minus),
         @vflex_bet1(plus).

schmelz ---> @intrans_unacc_verb(schmelzen_rel,accomplishment,thing_or_substance),
         @pres2_stem(a_ schmilz),

         @past_stem(a_ schmolz),
         @part_stem(a_ schmolz),
         @conj_stem(a_ schmölz),
         @imp2_stem,
         @vflex_fk(v_strong),
           
         @vflex_ep(minus),
         @vflex_evp(minus),
         @vflex_epp(plus),
         @vflex_sm(plus),
         @vflex_pl_n(minus),
         @vflex_spe(minus),
         @vflex_tm(minus),
         @vflex_em(minus),
         @vflex_bet1(plus).

lieb  ---> @trans_verb(lieben_rel,state,agentive,anything),
           @vflex_fk(v_weak),
            
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

mal   ---> @trans_verb(malen_rel,accomplishment_or_activity,agentive,anything),
           @vflex_fk(v_weak),
 
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

nehm  ---> @trans_verb(nehmen_rel,achievement,agentive,object),
           @pres2_stem(a_ nimm),

           @past_stem(a_ nahm),
           @part_stem(a_ nomm),
           @conj_stem(a_ nähm),
           @imp2_stem,
           @vflex_fk(v_strong),
            
           @vflex_ep(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).


reparier  ---> @trans_verb(reparieren_rel,accomplishment,human,thing),
              @vflex_fk(v_weak),
 
              @vflex_ep(minus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_em(minus),
              @vflex_bet1(minus).

% Menschen und Kängurus
schlag ---> @trans_verb(schlagen_rel,accomplishment_or_achievement_or_activity_or_semelfactive,agentive,agentive),
           @pres2_stem(a_ schläg),
           @past_stem(a_ schlug),
           @part_stem(a_ schlag),
           
           @vflex_fk(v_strong),
           
           @vflex_ep(minus),
           @vflex_evp(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

% Vögel und Menschen. Der Wind?
sing  ---> @trans_verb(singen_rel,accomplishment_or_activity,agentive,info_content),
           @past_stem(a_ sang),
           @part_stem(a_ sung),
              
           @conj_stem(a_ säng),
              
           @vflex_fk(v_strong),
              
           @vflex_ep(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
%          @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).


%vorschlagen
schlag ---> @trans_verb(vorschlagen_rel,accomplishment_or_achievement,a_ vor),
           @pres2_stem(a_ schläg),
           @past_stem(a_ schlug),
           @part_stem(a_ schlag),
           
           @vflex_fk(v_strong),
           
           @vflex_ep(minus),
           @vflex_evp(minus),
           @vflex_epp(plus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).


% Sind LLMs agentive? Darüber denken wir lieber nicht weiter nach.
% Ob Codex eingeschnappt ist, wenn er das hier liest?
% Er/sie/es kann ja Bescheid sagen, wenn es passiert ist.
widersprech  ---> @np_np_dat_verb(widersprechen_rel,achievement,agentive,agentive),
            @pres2_stem(a_ widersprich),
            @past_stem(a_ widersprach),
            @part_stem(a_ widersproch),
            @conj_stem(a_ widerspräch),
            @imp2_stem,
            @vflex_fk(v_strong),
            
            @vflex_ep(minus),
            @vflex_evp(minus),
            @vflex_epp(plus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
%            @vflex_spe(minus),
            @vflex_tm(minus),
            @vflex_em(minus),
            @vflex_bet1(minus).


% Ditransitive Verben
erzähl  ---> @ditrans_verb(erzählen_rel,accomplishment,agentive,agentive,info_content),
            @vflex_fk(v_weak),
            
            @vflex_ep(minus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_spe(minus),
            @vflex_tm(minus),
            @vflex_em(minus),
            @vflex_bet1(minus).

geb  ---> @ditrans_verb(geben_rel,achievement,agentive,agentive,object),
         @pres2_stem(a_ gib),
         @past_stem(a_ gab),
         @part_stem(a_ geb),
         @conj_stem(a_ gäb),
         @imp2_stem,
            
         @vflex_fk(v_strong),
            
         @vflex_ep(minus),
         @vflex_evp(minus),
         @vflex_epp(plus),
         @vflex_sm(minus),
         @vflex_pl_n(minus),
         @vflex_spe(minus),
         @vflex_tm(minus),
         @vflex_em(minus),
         @vflex_bet1(plus).

% Kann man Affen etwas schenken?
schenk ---> @ditrans_verb(schenken_rel,achievement,human,agentive,object),
            @vflex_fk(v_weak),

            @vflex_ep(minus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_spe(minus),
            @vflex_tm(minus),
            @vflex_em(minus),
            @vflex_bet1(plus).


denk  ---> @np_pp_verb(an_pform,acc,denken_an_rel,activity,agentive,anything),
          @past_stem(a_ dach),
          @part_stem(a_ dach),
          
          @vflex_fk(v_weak),
          @vflex_ep(minus),
          @vflex_sm(minus),
          @vflex_pl_n(minus),
          @vflex_spe(minus),
          @vflex_tm(minus),
          @vflex_em(minus),
          @vflex_bet1(plus).



fetz ---> @np_or_cp_verb(fetzen_rel,state,anything),
          @vflex_fk(v_weak),
          @vflex_ep(minus),
          @vflex_sm(plus),
          @vflex_pl_n(minus),
          @vflex_spe(minus),
          @vflex_tm(minus),
          @vflex_em(minus),
          @vflex_bet1(plus).

glaub ---> @glauben_denken_verb(glauben_rel,state,agentive),
          @vflex_fk(v_weak),
          @vflex_ep(minus),
          @vflex_sm(minus),
          @vflex_pl_n(minus),
          @vflex_spe(minus),
          @vflex_tm(minus),
          @vflex_em(minus),
          @vflex_bet1(plus).





% Modalverben

dürf   ---> @modal_verb(dürfen_rel),
           @pres2_stem(a_ darf),
 
           @past_stem(a_ durf),
           @part_stem(a_ durf),
           @conj_stem(a_ dürf),

           @vflex_fk(modal),
           
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

könn   ---> @modal_verb(können_rel),
           @pres2_stem(a_ kann),
 
           @past_stem(a_ konn),
           @part_stem(a_ konn),
           @conj_stem(a_ könn),
           
           @vflex_fk(modal),
           
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

müss   ---> @modal_verb(müssen_rel),
           @pres2_stem(a_ muss),
 
           @past_stem(a_ muss),
           @part_stem(a_ muss),
           
           @conj_stem(a_ müss),

           @vflex_fk(modal),
            
           @vflex_ep(minus),
           @vflex_sm(plus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

woll   ---> @modal_verb(wollen_rel),
           @pres2_stem(a_ will),
 
           @vflex_fk(modal),
            
           @vflex_ep(minus),
           @vflex_sm(minus),
           @vflex_pl_n(minus),
           @vflex_spe(minus),
           @vflex_tm(minus),
           @vflex_em(minus),
           @vflex_bet1(plus).

% Kann man Affen etwas versprechen?
versprech ---> ( @np_v_subj_control_verb(versprechen_rel,achievement,human)
               ; @np_np_v_subj_control_verb(dat,versprechen_rel,achievement,human,agentive)
               ),
              @pres2_stem(a_ versprich),

              @past_stem(a_ versprach),
              @part_stem(a_ versproch),
              
              @conj_stem(a_ verspräch),
              @imp2_stem,
              @vflex_fk(v_strong),
              
              @vflex_ep(minus),
              @vflex_evp(minus),
              @vflex_epp(plus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_spe(minus),
              @vflex_tm(minus),
              @vflex_em(minus),
              @vflex_bet1(minus).

versuch   ---> @np_v_subj_control_verb(versuchen_rel,_,human),
              @vflex_fk(v_weak),
 
              @vflex_ep(minus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_spe(minus),
              @vflex_tm(minus),
              @vflex_em(minus),
              @vflex_bet1(minus).


% Objektkontrollverben
erlaub    ---> @np_np_v_obj_control_verb(dat,erlauben_rel,achievement,human,human),
              @vflex_fk(v_weak),
              
              @vflex_ep(minus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_em(minus),
              @vflex_bet1(minus).

zwing     ---> @np_np_v_obj_control_verb(zwingen_rel,accomplishment,human,agentive),
              @past_stem(a_ zwang),
              @part_stem(a_ zwung),
              
              @conj_stem(a_ zwäng),
 
              @vflex_fk(v_strong),
              
              @vflex_ep(minus),
              @vflex_evp(minus),
              @vflex_epp(plus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_spe(minus),
              @vflex_tm(minus),
              @vflex_em(minus),
              @vflex_bet1(plus).


% Subjektanhebungsverben

% obligatorisch kohärent
schein --->   @coherent_subject_raising_verb(scheinen_rel),
              synsem:loc:cat:head:vform:fin,        % *Karl wird zu schlafen scheinen.
                                                    % *Karl hat zu schlafen geschienen.
              @past_stem(a_ schien),
 
              @vflex_fk(v_strong),
                
              @vflex_ep(minus),
              @vflex_evp(minus),
              @vflex_epp(plus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_spe(minus),
              @vflex_tm(minus),
              @vflex_em(minus),
              @vflex_bet1(plus).

% optional kohärent
beginn --->    @phase_verb(beginnen_rel),
              @past_stem(a_ begann),
              @part_stem(a_ begonnen),
              @conj_stem(a_ begänn),
              
              @vflex_fk(v_strong),
              
              @vflex_ep(minus),
              @vflex_evp(minus),
              @vflex_epp(plus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_spe(minus),
              @vflex_tm(minus),
              @vflex_em(minus),
              @vflex_bet1(minus).



% AcI-Verben

seh       ---> @aci_verb(sehen_rel,agentive),
              @pres2_stem(a_ sieh),

              @past_stem(a_ sah),
              @part_stem(a_ seh),
              
              @conj_stem(a_ säh),
              @imp2_stem,
              @vflex_fk(v_strong),
              
              @vflex_ep(minus),
              @vflex_evp(minus),
              @vflex_epp(plus),
              @vflex_sm(minus),
              @vflex_pl_n(minus),
              @vflex_spe(minus),
              @vflex_tm(minus),
              @vflex_em(minus),
              @vflex_bet1(plus).


lass    ---> ( @aci_verb(lassen_rel,agentive)
            ;
               @lassen_passive(agentive)
            ),
            @pres2_stem(a_ läss),

            @past_stem(a_ ließ),
            @part_stem(a_ lass),
            
            @vflex_fk(v_strong),
            
            @vflex_ep(minus),
            @vflex_evp(minus),
            @vflex_epp(plus),
            @vflex_sm(plus),
            @vflex_pl_n(minus),
            @vflex_spe(minus),
            @vflex_tm(minus),
            @vflex_em(minus),
            @vflex_bet1(plus).



% Hilfsverben
% Einträge für Futur-Hilfsverb und Passiv (kommt im nächsten Kapitel)

werde    ---> @werden(first,  sg, pres_ind_conj).
wirst    ---> @werden(second, sg, pres_ind).
wird     ---> @werden(third,  sg, pres_ind).

werden   ---> @werden(first_or_third, pl, pres_ind_conj).
werdet   ---> @werden(second,         pl, pres_ind_conj).

werde    ---> @werden(third,          sg, pres_conj).  % first person listed above, reduces ambiguity
werdest  ---> @werden(second,         sg, pres_conj).

wurde    ---> @werden(first_or_third, sg, past_ind).
wurdest  ---> @werden(second,         sg, past_ind).
wurden   ---> @werden(first_or_third, pl, past_ind).
wurdet   ---> @werden(second,         pl, past_ind).


würde    ---> @werden(first_or_third, sg, past_conj).
würdest  ---> @werden(second,         sg, past_conj).


% Es gibt keine infiniten Formen für das Futur-Hilfsverb.
% Die folgenden sind nur fürs Passiv:
%
werden   ---> @werden(bse_or_inf).
worden   ---> @werden_pas(ppp).


bin   ---> @sein(first, sg, pres_ind).
bist  ---> @sein(second,sg, pres_ind).
ist   ---> @sein(third, sg, pres_ind).

sind  ---> @sein(first_or_third, pl, pres_ind).
seid  ---> @sein(second,         pl, pres_ind).

sei   ---> @sein(first_or_third, sg, pres_conj).
seist ---> @sein(second,         sg, pres_conj).

seien ---> @sein(first_or_third, pl, pres_conj).
seiet ---> @sein(second,         pl, pres_conj).

war   ---> @sein(first_or_third, sg, past_ind).
warst ---> @sein(second,         sg, past_ind).

waren ---> @sein(first_or_third, pl, past_ind).
wart  ---> @sein(second,         pl, past_ind).

wäre   ---> @sein(first_or_third, sg, past_conj).
wärest ---> @sein(second,         sg, past_conj).

wären ---> @sein(first_or_third, pl, past_conj).
wärt  ---> @sein(second,         pl, past_conj).


gewesen  ---> @sein(ppp).

sein     ---> @sein(bse_or_inf).



% Dativpassiv-Hilfsverb


bekomm  ---> dative_passive_aux_verb,
            @past_stem(a_ bekam),
            @part_stem(a_ bekomm),
            @conj_stem(a_ bekäm),
            
            @vflex_fk(v_strong),
            
            @vflex_ep(minus),
            @vflex_evp(minus),
            @vflex_epp(plus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_spe(minus),
            @vflex_tm(minus),
            @vflex_em(minus),
            @vflex_bet1(minus).



% Perfekt-Hilfsverb

hab     ---> (haben_perfect;
             modal_haben),
            @pres2_stem(a_ ha),
            @past_stem(a_ hat),
            @part_stem(a_ hab),
            @conj_stem(a_ hät),
            
            @vflex_fk(mixed),
            
            @vflex_ep(minus),
            @vflex_sm(minus),
            @vflex_pl_n(minus),
            @vflex_spe(minus),
            @vflex_tm(minus),
            @vflex_em(minus),
            @vflex_bet1(plus).



an --->
(subj_isect_modifying_particle,
 rels:[gerichtet_auf]).
            
los --->
(subj_less_scopal_modifying_particle,
 rels:[beginnen_rel]).


vor ---> @non_trans_particle(a_ vor).



% Das ist ein Trick, der gebraucht wird,
% damit eine eigentlich syntaktische Regel im Lexikon angewendet werden
% kann. Ohne diesen Trick würde man in Trale die Partikelverben und entsprechende
% Derivationsformen nur mit einem Leerzeichen zwischen Partikel und Verb/Adjektiv/Nomen
% analysieren können.

% In den entsprechenden Lexikonregeln wird eine Tochter als `particle' spezifiziert,
% womit dann auch der phonologische Beitrag zugreifbar ist und mit
%
% morphs
%  X becomes (Y,X).
%
% in die orthographische Form des Wortes integriert werden kann.

particle *>
 ((phon:[a_ an],
   subj_isect_modifying_particle,
   rels:hd:gerichtet_auf)
 ;
  (phon:[a_ los],
   subj_less_scopal_modifying_particle,
   rels:hd:beginnen_rel)
 ;
   (phon:[a_ vor],
    @non_trans_particle(a_ vor))).

an  ---> @comp_prep(an_pform,acc).
auf ---> @comp_prep(auf_pform,acc).
für ---> @comp_prep(für_pform,acc).
von ---> @comp_prep(von_pform,dat).
zu  ---> @comp_prep(zu_pform,dat).

% von ---> passive_preposition.


in ---> @location_noun_mod_prep(in_rel).
in ---> @location_verb_mod_prep(in_rel).



interessant ---> @np_adj(interessant_rel).
klug        ---> @np_adj(klug_rel).
klein       ---> @np_adj(klein_rel).
schön       ---> @np_adj(schön_rel).

treu        ---> @np_np_adj(dat,treu_rel).

schwierig   ---> @np_adj(schwierig_rel).
stolz       ---> @np_pp_adj(auf_pform,acc,stolz_auf_rel).

mutmaßlich  ---> @scopal_adj(mutmaßlich_rel).



angeblich ---> @scopal_adv(angeblich_rel).

nicht ---> @scopal_adv(nicht_rel).

wahrscheinlich ---> @scopal_adv(wahrscheinlich_rel).

oft ---> @isect_adv(oft_rel).

gestern ---> @temp_adv(gestern_rel).
jetzt   ---> @temp_adv(jetzt_rel).
heute   ---> @temp_adv(heute_rel).
morgen  ---> @temp_adv(morgen_rel).

immer   ---> @temp_adv(immer_rel).

genug  ---> @isect_adv(genug_rel,accomplishment).
leicht ---> @isect_adv(leicht_rel). % sollte über Lexikonregel lizenziert werden


dass ---> @complementizer(dass).



empty
   v_trace.


empty 
   e_trace.


empty 
    (empty_determiner,
     @det(pl,weak,udef_q)).
