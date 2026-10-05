% -*-  coding:utf-8; mode:trale-prolog   -*-

ts(1,"Der Affe schläft.",@decl,1,[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(2,"der Affe das Kind kennt",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(3,"der Affe an das Kind denkt",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(4,"Ihm graut.",@decl,1,[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(5,"Der Affe graut",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(6,"Affe schläft",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(7,"der Affe kennt",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(8,"an das Kind schläft",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(9,"an das Kind den Affe kennt",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(10,"die Tochter des Mannes schläft.",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(11,"die Tochter Mannes",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(12,"der kleine Affe",@root,1,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(13,"kleine der Affe",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(14,"kleine Affe der",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(15,"Der Tofu in der Speisekammer stinkt.",@decl,1,[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(16,"der Tofu in stinkt",@root,0,[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').

ts(17,"Jede Tochter eines Mitarbeiters schläft.",@root,1,[2],'Kapitel 5: Semantik, Skopus').
ts(18,"der mutmaßliche Affe",@root,1,[],'Kapitel 5: Semantik, Skopus').
ts(19,"Sein Affe schläft.",@root,1,[1],'Kapitel 5: Semantik, Skopus').
ts(20,"Der angeblich kleine Affe schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(21,"der Affe wahrscheinlich schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(22,"Jeder Affe glaubt, dass ein Einhorn schläft.",@decl,1,[3],'Kapitel 5: Semantik, Skopus').
ts(23,"Aicke schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(24,"Er schläft.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').

ts(25,"Aicke Conny kennt.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(26,"Der Affe kennt das Kind.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(27,"Der Affe kennt ein Kind.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(28,"Jeder Affe kennt jedes Kind.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(29,"Ein Kind kennt einen Mann.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').
ts(30,"Jeder Affe kennt ein Kind.",@decl,1,[2],'Kapitel 5: Semantik, Skopus').
ts(31,"Eine Tochter eines Mitarbeiters kennt einen Affen.",@decl,1,[1],'Kapitel 5: Semantik, Skopus').


% Generierungstests: tg(Nummer,Eingabe,Startsymbol,AnzahlAbleitungen,Kommentar).
% testgt(all). / testgt(Nummer). / testgt([Von,Bis]).
% Gleiche Wortfolgen werden je Ableitung gezaehlt, ueber alle Eingabeanalysen.
tg(1,"Der Affe schläft.",@decl,2,'Grundfall').
