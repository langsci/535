% -*-  coding:utf-8; mode:trale-prolog   -*-

% ts(Nummer,Phrase,RootMacro,Syntaktische Lesarten,[Scopings1,Scopings2,...],Beschreibung)

ts(1,"Der Affe schläft.",@decl,1,[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(2,"der Affe das Kind kennt",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(3,"der Affe an das Kind denkt",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(4,"Ihm graut.",@decl,1,[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(5,"Der Affe graut.",@decl,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(6,"Affe schläft.",@decl,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(7,"der Affe kennt",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(8,"an das Kind schläft",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(9,"an das Kind den Affe kennt",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(10,"die Tochter des Mannes schläft.",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(11,"die Tochter Mannes",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(12,"der kleine Affe",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(13,"der Tofu in der Speisekammer",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(14,"der Tofu in",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(15,"Jede Tochter eines Mitarbeiters schläft.",@root,1,[2],'Kapitel 5: Semantik, Skopus').
ts(16,"der mutmaßliche Affe",@root,1,[],'Kapitel 5: Semantik, Skopus').
ts(17,"Sein Affe schläft.",@root,1,[1],'Kapitel 5: Semantik, Skopus').
ts(18,"Der angeblich kleine Affe schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(19,"der Affe wahrscheinlich schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(20,"Jeder Affe glaubt, dass ein Einhorn schläft.",@decl,1,[3],'Kapitel 5: Semantik, Skopus').
ts(21,"Aicke schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(22,"Er schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

% examples for utool equivalence chart reduction
% 1 scoping
ts(23,"Aicke Conny kennt.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

% 1 scoping
ts(24,"Der Affe kennt das Kind.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

% 1 scoping
ts(25,"Der Affe kennt ein Kind.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

% 1 scoping
ts(26,"Jeder Affe kennt jedes Kind.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

% 1 scoping
ts(27,"Ein Kind kennt einen Mann.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

% 2 scopings?
ts(28,"Jeder Affe kennt ein Kind.",@decl,1,[2],'Kapitel 5: Semantik, Skopus').

ts(29,"Eine Tochter eines Mitarbeiters kennt einen Affen.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').


/*
ts(30,"Eine Tochter eines Mitarbeiters kennt einen Affen.","a daughter of.an employee knows a monkey.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

t(31,"Eine Tochter eines Mitarbeiters kennt einen Affen.",1).

% scopings only make sense if a description is given
% ts(32,"Eine Tochter eines Mitarbeiters kennt einen Affen.",1,[1]).

%t(33,"Eine Tochter eines Mitarbeiters kennt einen Affen.",@decl,1).

ts(34,"Eine Tochter eines Mitarbeiters kennt einen Affen.",@decl,1,[1]).

*/

% Generierungstests: tg(Nummer,Eingabe,Startsymbol,AnzahlAbleitungen,Kommentar).
% testgt(all). / testgt(Nummer). / testgt([Von,Bis]).
% Gleiche Wortfolgen werden je Ableitung gezaehlt, ueber alle Eingabeanalysen.
tg(1,"Der Affe schläft.",@decl,6,'Grundfall').
