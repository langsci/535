% -*- coding: utf-8; mode: trale-prolog -*-

% ts(Nr, Satz, Root, Parses, Skopuslesarten, Generiert, Kommentar).
% Generiert: erwartete Anzahl pro Parsing-Lesart, z.B. [7] oder [7,7].
% _Generated: noch keine genaue Erwartung festgelegt.

% ts(Nr, Satz, Root, Parses, Skopuslesarten, Generiert, Kommentar),var(Generiert),write(Nr),p_and_g(Satz,Root),order,fail,nl,nl. 

% Beispiele, die Permutationen voneinander sind, muss man nicht erneut testen.
% skip_generator_test([37,43,47,53,54,55,126,127,128,130,132,133]).

% Diese Wortform darf auch durch Lexikonregeln nicht erzeugt werden.
unknown_words([geschlafene,geholfene,gegraute,geregnete,gedurft,gehabte,gewesene,seiende]).

% Bei Beispielen mit mehreren Analysen kann man nur von einer bestimmten generieren lassen.
% generate_only([[268,1]]).

% Im Skopusfeld kann stehen
% [utool_error(distinct_quantifiers)]
% ts(1, "Beispielsatz.", @decl, 1, [utool_error(distinct_quantifiers)], _Generated, '').
%
% Damit wird genau dieser Utool-Fehler erwartet; der Variablenname `x4` darf abweichen. Andere Fehler, eine falsche Parse-Anzahl oder das Ausbleiben des erwarteten Fehlers bleiben Abweichungen.

% Für mehrere Analysen geht etwa:

% [1, utool_error(distinct_quantifiers)]



ts(2,"Der Affe schläft.",@decl,1,[1],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(3,"der Affe das Kind kennt",@root,1,[],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(4,"der Affe an das Kind denkt",@root,1,[],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(5,"Ihm graut.",@decl,1,[1],[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(6,"Der Affe graut",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(7,"Affe schläft",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(8,"der Affe kennt",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(9,"an das Kind schläft",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(10,"an das Kind den Affe kennt",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(11,"Die Tochter des Mannes schläft.",@decl,1,[1],[8],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(12,"die Tochter Mannes",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(13,"der kleine Affe",@root,1,[],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(14,"kleine der Affe",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(15,"kleine Affe der",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(16,"Das Eis in der Speisekammer schmilzt.",@decl,1,[1],[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(17,"das Eis in schmilzt",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').

ts(18,"Jede Tochter eines Mitarbeiters schläft.",@decl,1,[2],[8],'Kapitel 5: Semantik, Skopus').
ts(19,"der mutmaßliche Affe",@root,1,[],[4],'Kapitel 5: Semantik, Skopus').
ts(20,"Sein Affe schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').
ts(21,"Der angeblich kleine Affe schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').
ts(22,"Der Affe schläft wahrscheinlich.",@decl,1,[2],[7],'Kapitel 5: Semantik, Skopus').
ts(23,"Jeder Affe glaubt, dass ein Einhorn schläft.",@decl,1,[3],[36],'Kapitel 5: Semantik, Skopus').
ts(24,"Aicke schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').
ts(25,"Er schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').

ts(26,"Aicke kennt Conny.",@decl,2,[1,1],[10,10],'Kapitel 5: Semantik, Skopus').
ts(27,"Der Affe kennt das Kind.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(28,"Der Affe kennt ein Kind.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(29,"Jeder Affe kennt jedes Kind.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(30,"Ein Kind kennt einen Mann.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(31,"Jeder Affe kennt ein Kind.",@decl,1,[2],[10],'Kapitel 5: Semantik, Skopus').
ts(32,"Eine Tochter eines Mitarbeiters kennt einen Affen.",@decl,1,[1],[20],'Kapitel 5: Semantik, Skopus').

% Unterspezifikation des Linkings für Satzargument und NP-Argument
ts(33,"Dass der Affe lacht, fetzt.",@decl,1,[1],[6],'Kapitel 5: Semantik, Skopus').
ts(34,"Der Affe fetzt.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').

ts(35,"das Eis der Speisekammer in",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(36,"dass das Kind dem Affen den Stock gibt",@root,1,[],[18],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(37,"dass das Kind den Stock dem Affen gibt",@root,1,[],[18],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(38,"Schläft er?",@interrog,1,[1],[6],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(39,"Lacht das Kind oft?",@interrog,1,[1],[11],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(40,"Lacht das Kind oft nicht?",@interrog,1,[2],[20],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(41,"Lacht das Kind nicht oft?",@interrog,1,[2],[20],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(42,"Kennt ein Kind den Roman?",@interrog,1,[1],[14],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(43,"Kennt den Roman ein Kind?",@interrog,1,[1],[14],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(44,"Aicke schläft schläft.",@decl,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(45,"Den Roman kennt und schläft er",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(46,"Kennt und liebt das Kind den Roman?",@interrog,1,[1],[13],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(47,"Kennt und liebt den Roman das Kind?",@interrog,1,[1],[13],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(48,"Kennt sie den Film und den Roman?",@interrog,1,[1],[14],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
% Grammatiken mit zyklischer Spur lassen Folgendes zu:
% Koordination eines Verbletztverbs als Verbspur mit [den Stock _]
% Valenz der beiden Konjunkte muss gleich sein. Verb muss lexikalisch sein, weil sonst DSL zu none werden würde.
ts(49,"Kennt der Affe lacht und den Stock?",@interrog,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
% parallel
ts(50,"Gibt der Affe lacht und dem Kind den Stock?",@interrog,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').

% Spielt das Kind [spielt und lacht]. mit [spielt und lacht] statt Spur.
ts(51,"Spielt das Kind spielt und lacht",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').

% 12.10.2026
% Generation: 3432.569 s CPU time.
% Chart: 19876 edges (4790 active, 15086 inactive).
ts(52,"dass das Kind dem Affen den Stock morgen gibt",@root,1,[],[72],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(53,"dass das Kind dem Affen morgen den Stock gibt",@root,1,[],[72],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(54,"dass das Kind morgen dem Affen den Stock gibt",@root,1,[],[72],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(55,"dass morgen das Kind dem Affen den Stock gibt",@root,1,[],[72],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(56,"Mann der",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(57,"der Speisekammer in",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(58,"das Kind kluge",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(59,"die in der Speisekammer Wurst",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(60,"dass Aicke den Stock gibt ihm",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(61,"dass das Kind den Roman",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').

ts(62,"Den Roman kennt er.",@decl,1,[1],[10],'Kapitel 9: Vorfeldbesetzung').
ts(63,"Er lacht oft.",@decl,1,[1],[7],'Kapitel 9: Vorfeldbesetzung').
ts(64,"Oft lacht er.",@decl,1,[1],[7],'Kapitel 9: Vorfeldbesetzung').
ts(65,"Oft lacht er nicht.",@decl,2,[1,1],_Generated,'Kapitel 9: Vorfeldbesetzung').

% 
% Generated phrases: 191.
% Generation: 2007.529 s CPU time.
% Chart: 95476 edges (21599 active, 73877 inactive).

ts(66,"Oft gibt er nicht dem Affen den Stock.",@decl,2,[4,4],[191,191],'Kapitel 9: Vorfeldbesetzung').
% Vorfeld kann nur einmal besetzt werden
ts(67,"Er den Stock gibt dem Affen.",@decl,0,[],[],'Kapitel 9: Vorfeldbesetzung').
% Nur eine Lesart: [den Stock _i und lacht] muss ausgeschlossen werden.
ts(68,"Der Affe nimmt den Stock und lacht.",@decl,1,[1],_Generated,'Kapitel 9: Vorfeldbesetzung').
% Satztyp:
ts(69,"Ein Affe nimmt einen Stock und das Kind lacht.",@decl,1,[1],_Generated,'Kapitel 9: Vorfeldbesetzung').
% Klaus ist ein Idiot und warum merkt das außer mir niemand?


ts(70,"Der Affe, der schläft, kennt das Kind.",@decl,1,[1],[20],'Kapitel 10: Relativsätze').
ts(71,"die Speisekammer, in der er schläft",@root,1,[],[4],'Kapitel 10: Relativsätze').
% Relativsatz als Prämodifier
ts(72,"der, der schläft, Affe",@root,0,[],[],'Kapitel 10: Relativsätze').
% Relativphrase nach dem finiten Satz
ts(73,"Der Affe, schläft der, kennt das Kind.",@decl,0,[],[],'Kapitel 10: Relativsätze').
% komplexe Relativphrase mit Relativwort in der postnominalen PP.
ts(74,"die Speisekammer, der Affe in der schläft",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(75,"Ein Affe, dessen Kind schläft, lacht.",@decl,1,[1],_Generated,'Kapitel 10: Relativsätze').
% Wenn REL nicht nach oben gereicht wird, kann "der Affe" einfach als Relativphrase verwendet werden.
ts(76,"Der Affe, der Affe schläft, lacht",@root,0,[],[],'Kapitel 10: Relativsätze').
% Relativsatz mit Verbspur statt mit overtem Verb
ts(77,"Der Affe, der den Stock, lacht",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(78,"Der Affe, dessen Stock und dessen Roman ich kenne, schläft.",@decl,1,[1],_Generated,'Kapitel 10: Relativsätze').
ts(79,"Der Affe, von dessen Kind er ein Bild malt, lacht.",@decl,1,[1],[16],'Kapitel 10: Relativsätze').

ts(80,"Der Affe, ein Bild von dessen Kind er malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(81,"Der Affe, ein Bild dessen Kindes er malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(82,"Der Affe, dessen Kind er ein Bild von malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(83,"Der Affe, dessen Kindes er ein Bild malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').


ts(84,"Ich schlafe.",@decl,1,[1],[7],'Kapitel 12: Kongruenz').
ts(85,"Du schläfst.",@decl,1,[1],[4],'Kapitel 12: Kongruenz').
% Ist schon oben bei 24 dabei.
%ts(86,"Er schläft.",@decl,1,[1],_Generated,'Kapitel 12: Kongruenz').
ts(87,"Er schläfst.",@decl,0,[],[],'Kapitel 12: Kongruenz').
ts(88,"die Männern",@root,0,[],[],'Kapitel 12: Kongruenz').

ts(89,"der kluge  Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(90,"des klugen Mannes",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(91,"dem klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(92,"den klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').

ts(93,"die klugen Männer", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(94,"der klugen Männer", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(95,"den klugen Männern",@root,1,[],[3],'Kapitel 12: Kongruenz').

ts(96,"das kluge  Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(97,"des klugen Kindes",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(98,"dem klugen Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').

ts(99,"die klugen Kinder", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(100,"der klugen Kinder", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(101,"den klugen Kindern",@root,1,[],[3],'Kapitel 12: Kongruenz').

ts(102,"die kluge  Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').
ts(103,"der klugen Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(104,"die klugen Frauen",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(105,"der klugen Frauen",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(106,"den klugen Frauen",@root,1,[],[3],'Kapitel 12: Kongruenz').

ts(107,"ein   kluger Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(108,"eines klugen Mannes",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(109,"einem klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(110,"einen klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').

ts(111,"ein   kluges Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(112,"eines klugen Kindes",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(113,"einem klugen Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').

ts(114,"eine  kluge  Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').
ts(115,"einer klugen Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(116,"seine  kluge  Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').
ts(117,"seiner klugen Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(118,"sein   kluger Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(119,"seines klugen Mannes",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(120,"seinem klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(121,"seinen klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').

ts(122,"sein   kluges Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(123,"seines klugen Kindes",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(124,"seinem klugen Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').

ts(125,"ein   kluger Beamter",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(126,"eines klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(127,"einem klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(128,"einen klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').

ts(129,"eine  kluge  Beamte", @root,1,[],[2],'Kapitel 12: Kongruenz').
ts(130,"einer klugen Beamten",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(131,"der kluge  Beamte", @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(132,"des klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(133,"dem klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(134,"den klugen Beamten",@root,2,[],[3,4],'Kapitel 12: Kongruenz').

ts(135,"die kluge  Beamte", @root,1,[],[2],'Kapitel 12: Kongruenz').
ts(136,"der klugen Beamten",@root,2,[],[3,2],'Kapitel 12: Kongruenz').

ts(137,"Die kleinen Kinder schlafen.",@decl,1,[1],_Generated,'Kapitel 12: Kongruenz').
ts(138,"Kleine Kinder schlafen.",@decl,1,[1],[7],'Kapitel 12: Kongruenz').
ts(139,"Die kleine Kinder schlafen.",@decl,0,[],[],'Kapitel 12: Kongruenz').
ts(140,"Kleinen Kinder schlafen.",@decl,0,[],[],'Kapitel 12: Kongruenz').

% Kongruenz bei nominalem Argument von fetzen.
ts(141,"Ich fetze.",@decl,1,[1],[7],'Kapitel 12: Kongruenz').
ts(142,"Du  fetzt.",@decl,1,[1],[7],'Kapitel 12: Kongruenz').

%t(125,"Er arbeitet der ganze Tag.", @decl,0,'Kapitel 13: Kasus').
%t(126,"weil der ganze Tag gearbeitet wurde."@decl,0,'Kapitel 13: Kasus').

%ts(141,"Dass Aicke lacht, freut mich.",@decl,1,[],'Kapitel 13: Kasus').
%ts(142,"Dass Aicke lacht, freut er.",  @root,0,[],'Kapitel 13: Kasus').



% Verbalkomplexe
ts(143,"dass er lachen wird",@root,1,[],[1],'Kapitel 14: Verbalkomplex').
ts(144,"dass lachen er wird",@root,0,[],[],'Kapitel 14: Verbalkomplex').
ts(145,"dass er den Aufsatz lesen wird",@root,1,[],[2],'Kapitel 14: Verbalkomplex').
ts(146,"dass lesen er den Aufsatz wird",@root,0,[],[],'Kapitel 14: Verbalkomplex').
ts(147,"dass er lesen den Aufsatz wird",@root,0,[],[],'Kapitel 14: Verbalkomplex').
ts(148,"Er wird das Lied singen dürfen.",@decl,1,[1],[15],'Kapitel 14: Verbalkomplex').
ts(149,"Er wird lachen können wollen.",@decl,1,[1],_Generated,'Kapitel 14: Verbalkomplex').

% Partial Verb Phrase Fronting
ts(150,"Lachen muss er.",@decl,1,[1],[7],'Kapitel 14: Verbalkomplex + PVP').

ts(151,"Dem Kind erzählen muss er das Märchen.",  @decl,1,[1],[66],'Kapitel 14: Verbalkomplex + PVP').
ts(152,"Ein Märchen erzählen muss er dem Kind.",  @decl,1,[1],[66],'Kapitel 14: Verbalkomplex + PVP').

% 30 Minuten 21.10.2026 Chart: 10491 edges (2963 active, 7528 inactive).
% mit modalen Infinitiven.
ts(153,"Ein Märchen erzählen wird er ihm müssen.",@decl,1,[1],[86],'Kapitel 14: Verbalkomplex + PVP').
ts(154,"Müssen wird er ihm ein Märchen erzählen.",@decl,0,[], [],'Kapitel 14: Verbalkomplex + PVP').

% Oberfeldumstellung z.T. mit Ersatzinfinitiv
ts(155,"dass Aicke den Roman wird lesen dürfen",@root,1,[],[6],'Kapitel 14: Verbalkomplex + PVP').
ts(156,"dass Aicke den Roman lesen dürfen wird",@root,1,[],[6],'Kapitel 14: Verbalkomplex + PVP').

ts(157,"dass Aicke den Roman hat lesen dürfen",@root,1,[],[4],'Kapitel 14: Verbalkomplex + PVP').
ts(158,"dass Aicke den Roman lesen dürfen hat",@root,0,[],[],'Kapitel 14: Verbalkomplex + PVP').
ts(159,"dass Aicke den Roman hat lesen gedurft",@root,0,[],[],'Kapitel 14: Verbalkomplex + PVP').

ts(160,"dass Aicke den Roman wird haben lesen dürfen",@root,1,[],[4],'Kapitel 14: Verbalkomplex + PVP').

ts(161,"Aicke wird haben schlafen wollen.",@decl,1,[1],[2],'Kapitel 14: Verbalkomplex + Oberfeldumstellung').

ts(162,"Schlafen wollen wird Aicke haben.",@decl,1,[1],[3],'Kapitel 14: Verbalkomplex + Oberfeldumstellung').

% Das hat zwei Lesarten, wenn man eine FLIP+-Spur erlaubt. Dann kann wird vor der Extraktionsspur stehen.
ts(163,"Einen Aufsatz lesen müssen, glaube ich, dass er wird.",@decl,1,[2],_Generated,'Kapitel 14: Verbalkomplex + Oberfeldumstellung').

% scheinbar mehrfache Vorfeldbesetzung uncomment loding :- ['mehrfache-vorfeldbesetzung']. in theory.pl
% t(143,"Der Frau das Buch gibt er nicht.",@decl,1,'Kapitel 14: Merhfache Vorfeldbesetzung').
% t(144,"Der Frau den Aufsatz will er geben.",@decl,1,'Kapitel 14: Merhfache Vorfeldbesetzung').
% t(145,"Der Frau der Aufsatz gibt er.",@root,0,'Kapitel 14: Merhfache Vorfeldbesetzung').
% t(146,"Der Frau der Aufsatz will er geben.",@root,0,'Kapitel 14: Merhfache Vorfeldbesetzung').

ts(164,"dass er ihn zu lesen scheint",@root,1,[],[2],'Kapitel 15: Anhebung und Kontrolle').
ts(165,"dass ihm zu grauen scheint",@root,1,[],[1],'Kapitel 15: Anhebung und Kontrolle').

% inkohärente Konstruktion
ts(166,"dass den Aufsatz zu lesen der Mann beginnt",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(167,"dass den Aufsatz zu lesen der Mann versuchte",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(168,"dass den Aufsatz zu lesen der Mann dem Affen versprach",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(169,"dass den Aufsatz zu lesen der Mann den Affen zwingt",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').


% nur eine Lesart
ts(170,"dass der Mann den Aufsatz zu lesen beginnt",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(171,"dass der Mann den Aufsatz zu lesen morgen beginnt",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(172,"Er sieht es schlafen.",@decl,1,[1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(173,"Er versucht, das Lied zu singen.",@decl,1,[1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(174,"Er verspricht ihm, das Lied zu singen.",@decl,1,[1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(175,"Er zwingt ihn, das Lied zu singen.",@decl,2,[1,1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(176,"dass ihn der Mann zu lesen versucht",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(177,"dass ihn zu lesen der Mann versucht",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(178,"dass er ihn den Aufsatz lesen sah",@root,2,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').

% Langer Satz
% der mann, der den affen, der lacht, kennt, gibt der tochter eines mitarbeiters ein Buch, das jeder mitarbeiter einer frau, die den roman lesen wird, geben wird.

ts(179,"Der Affe wurde gemalt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(180,"Der Affe wurde von dem Kind gemalt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(181,"Der Affe ist von dem Kind gemalt worden.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(182,"Der Affe hat von dem Kind gemalt worden.",@root,0,[],[],'Kapitel 16: Passiv').
ts(183,"Mir wird geholfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(184,"Mir wird von der Frau geholfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(185,"Der Aufsatz wird mir geschenkt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(186,"Der Aufsatz wird mir von ihm geschenkt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(187,"Er wird geschlafen.",@root,0,[],[],'Kapitel 16: Passiv').
ts(188,"Mich wird geholfen.",@root,0,[],[],'Kapitel 16: Passiv').
ts(189,"Dir wirst geholfen.",@root,0,[],[],'Kapitel 16: Passiv').
ts(190,"Heute wurde geregnet.",@root,0,[],[],'Kapitel 16: Passiv').
ts(191,"Wird gearbeitet?",@interrog,1,[1],_Generated,'Kapitel 16: Passiv').
ts(192,"Wird geregnet?",@interrog,0,[],[],'Kapitel 16: Passiv').
ts(193,"Er wurde schlafen.",@decl,0,[],[],'Kapitel 16: Passiv').
ts(194,"Wird gestorben gewesen?",@interrog,0,[],[],'Kapitel 16: Passiv').
ts(195,"dass der Aufsatz zu lesen gezwungen worden wird.",@decl,0,[],[],'Kapitel 16: Passiv').
ts(196,"Mir wird geschlagen.",@decl,0,[],[],'Kapitel 16: Passiv + Kasus').
ts(197,"Mir werde geschlagen.",@decl,0,[],[],'Kapitel 16: Passiv + Kasus').
ts(198,"Der Frau wird gegraut.",@decl,0,[],[],'Kapitel 16: Passiv + subjektloses Prädikat').
ts(199,"Heute wird gegraut.",@decl,0,[],[],'Kapitel 16: Passiv + subjektloses Prädikat').
ts(200,"Gelacht wurde.",@decl,1,[1],[2],'Kapitel 16: Passiv + subjektloses Prädikat').
ts(201,"Gearbeitet wird von dem Affen.",@decl,1,[1],[4],'Kapitel 16: Passiv + subjektloses Prädikat').


ts(202,"der geliebte Mann",@root,1,[],_Generated,'Partizip + Passiv + attributiv').
ts(203,"die von ihrem Mann geliebte Frau",@root,1,[],_Generated,'Partizip + Passiv + attributiv').
ts(204,"der geschlafene Mann",@root,0,[],[],'Partizip + Passiv + attributiv').

ts(205,"der geholfene Mann",@root,0,[],[],'Partizip + Passiv + attributiv').
ts(206,"der gegraute Mann",@root,0,[],[],'Partizip + Passiv + attributiv + subjektloses Prädikat').
ts(207,"der gestorbene Mann",@root,1,[],_Generated,'Partizip + Passiv + attributiv + unakkusativ').
ts(208,"der geregnete Mann",@root,0,[],[],'Partizip + Passiv + attributiv + Wetterverb').
ts(209,"der ihm gelungene Aufsatz",@root,1,[],_Generated,'Partizip + Passiv + attributiv + unakkusativ').
ts(210,"der von ihm gestorbene Mann",@root,0,[],[],'Partizip + Passiv + attributiv + unakkusativ').
ts(211,"der von ihm ihm gelungene Aufsatz",@root,0,[],[],'Partizip + Passiv + attributiv + unakkusativ').

ts(212,"Der arbeitende Mann lacht.",@decl,1,[1],_Gen,'Partizip + Passiv + attributiv').
ts(213,"der von dem Mann arbeitende Mann",@root,0,[],[],'Partizip + Passiv + attributiv').

ts(214,"der das Buch gelesen gehabte Mann",@root,0,[],[],'Partizip + Passiv + attributiv').

% Nur dialektal
ts(215,"Der Mann hat das Buch gelesen gehabt.",@root,0,[],[],'Partizip + Perfekt').

ts(216,"das das Buch zu lesen gehabte Kind",@root,0,[],[],'Partizip + Perfekt').

ts(217,"Der Affe ist gestorben gewesen.",@root,0,[],[],'Partizip + Perfekt').
ts(218,"der gestorben gewesene Affe",@root,0,[],[],'Partizip + Perfekt').

ts(219,"Der Affe hat geschlafen gehabt",@root,0,[],[],'Partizip + Perfekt').

ts(220,"der das Buch gelesen gehabte Affe",@root,0,[],[],'Partizip + Perfekt').

ts(221,"Das den Roman zu lesen den Mann zu zwingen versprechende Kind lacht.",@decl,1,[1],_Gen,'Partizip + Perfekt').

% Hierfür muss die Lexikonregel für die Partizipbildung so gemacht werden, dass auch NP[str], die
% nicht vorn stehen, als Subjekt fungieren können, denn der Dativ von versprechen steht vor dem Akkusativ von "lesen".

%ts(222,"Der von mir dem Mann zu lesen versprochene Aufsatz fetzt.",@decl,1,[1],_Gen,'Partizip + Perfekt').

ts(223,"Er bekommt den Aufsatz zu lesen versprochen.",@decl,1,[1],_Gen,'Partizip + Perfekt').



ts(224,"dass er dem Mann haben wird",@root,0,[],[],'Partizip + Passiv + attributiv + unakkusativ').
ts(225,"Der Affe lässt den Mann den Kran reparieren.",@decl,2,[1,1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(226,"Der Affe lässt den Kran reparieren.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(227,"Der Affe lässt den Kran von einem Mann reparieren.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(228,"Der Affe lässt dem Mann helfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(229,"Der Affe lässt arbeiten.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(230,"Er lässt von ihm dem Mann gelingen.",@decl,0,[],[],'Kapitel 16: Passiv + lassen-Passiv').
ts(231,"Er lässt sterben.",@decl,0,[],[],'Kapitel 16: Passiv + lassen-Passiv').
ts(232,"Er lässt von ihm sterben.",@decl,0,[],[],'Kapitel 16: Passiv + lassen-Passiv').
ts(233,"Der Affe bekommt den Aufsatz geschenkt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + bekommen-Passiv').
ts(234,"Der Affe bekommt von mir den Aufsatz geschenkt.",@decl,1,[1],[54],'Kapitel 16: Passiv + bekommen-Passiv').
ts(235,"Der Affe hat den Aufsatz geschenkt bekommen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + bekommen-Passiv').
ts(236,"Der Affe wird den Aufsatz geschenkt bekommen haben.",@decl,1,[1],[31],'Kapitel 16: Passiv + bekommen-Passiv').
ts(237,"Das Buch ist ihm geschenkt bekommen worden.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(238,"Das Buch ist er geschenkt bekommen worden.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(239,"Das Buch wird geschenkt bekommen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(240,"Er ist das Buch geschenkt bekommen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(241,"Du bekommst gelungen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(242,"Du bekommst von ihm gelungen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(243,"Er bekommt ein Buch geschenkt bekommen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(244,"dass widersprochen bekam.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').

ts(245,"Er ist geschlagen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(246,"Ist genug gearbeitet?",@interrog,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(247,"Dem Mann ist geholfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(248,"Der Kran wird repariert sein.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(249,"Der Kran ist repariert gewesen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(250,"Ist heute geregnet?",@interrog,0,[],[],'Kapitel 16: Passiv + Zustandspassiv').
ts(251,"Ich bin geholfen.",@decl,0,[],[],'Kapitel 16: Passiv + Zustandspassiv').
ts(252,"Der Kran hat repariert zu sein.",@decl,1,[1],[3],'Kapitel 16: Passiv + Zustandspassiv + modaler Infinitiv').
ts(253,"dass der Kran zu reparieren versucht wurde",@root,1,[],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(254,"Zu reparieren versucht wurde der Kran.",@decl,1,[1],[10],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(255,"Den Kran zu reparieren wurde versucht.",@decl,1,[1],[10],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(256,"dass den Kran zu reparieren versucht wurde",@root,1,[],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(257,"Der Kran wurde zu reparieren versucht.",@decl,1,[1],[10],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(258,"Den Kran wurde zu reparieren versucht.",@decl,1,[1],[10],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(259,"Ist der Kran zu reparieren versucht worden?",@interrog,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(260,"Ein Aufsatz wurde ihm zu lesen erlaubt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(261,"Zu reparieren versucht wurde der Kran.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(262,"Zu reparieren versucht wurde den Kran.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(263,"Der Aufsatz gelesen wurde.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(264,"Den Aufsatz gelesen hat er.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(265,"Den Aufsatz gelesen wurde.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(266,"Der Aufsatz gelesen hat er.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(267,"Die Aufsätze gelesen wurden.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(268,"Die Aufsätze gelesen wurde.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(269,"Den Aufsatz lesen sieht er ihn müssen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(270,"Der Aufsatz lesen sieht er ihn müssen.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(271,"Das Buch ist zu lesen.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + sein').
ts(272,"Dem Mann ist zu helfen.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + sein').
ts(273,"Dem Mann scheint nicht zu helfen zu sein.",@decl,3,[4,4,4],[5,7,7],'Kapitel 17: modaler Infinitiv + sein').
ts(274,"Die Frau ist ihm zu helfen.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + sein').
ts(275,"Die Frau ist das Buch zu lesen.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + sein').
ts(276,"Aicke kennt den zu lesenden Aufsatz.",@decl,1,[1],[40],'Kapitel 17: modaler Infinitiv + attributiv').
ts(277,"Aicke kennt den von ihm zu lesenden Aufsatz.",@decl,1,[1],[20],'Kapitel 17: modaler Infinitiv + attributiv').
ts(278,"der das Buch zu lesende Mann",@root,0,[],[],'Kapitel 17: modaler Infinitiv + attributiv').
ts(279,"der zu lesen zu habende Roman",@root,0,[],[],'Kapitel 17: modaler Infinitiv + attributiv').
ts(280,"der erzählt zu bekommende Roman",@root,0,[],[],'Kapitel 17: modaler Infinitiv + attributiv').
ts(281,"Der den Aufsatz lesende Affe lacht.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + attributiv').
ts(282,"Er hat den Aufsatz zu lesen.",@decl,1,[1],[13],'Kapitel 17: modaler Infinitiv + haben').
ts(283,"Der Mann hat ihm zu helfen.",@decl,1,[1],[13],'Kapitel 17: modaler Infinitiv + haben').
ts(284,"Der Frau hat zu helfen.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + haben').
ts(285,"Dem Mann hat zu grauen.",@decl,1,[1],[3],'Kapitel 17: modaler Infinitiv + haben + subjektloses Prädikat').
ts(286,"Der Aufsatz hat gelesen zu werden.",@decl,1,[1],[27],'Kapitel 17: modaler Infinitiv + haben + Passiv').
ts(287,"Das Buch wird zu lesen gehabt.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + haben + Passiv').
ts(288,"Ihm hat geholfen zu werden.",@decl,1,[1],[7],'Kapitel 17: modaler Infinitiv + haben + Passiv + subjektloses Prädikat').
ts(289,"dass ihm nicht geholfen zu werden ist",@root,0,[],[],'Kapitel 17: modaler Infinitiv + haben + Passiv + subjektloses Prädikat').
ts(290,"Dem Mann gelungen wurde nicht.",@decl,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% der zu lesende Aufsatz
ts(291,"der zu lesen seiende Aufsatz",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').


%       1A99/MAR.22425 	wir nicht um einen globalen Konsens über die in dieser Ordnung verbindlich zu 	gelten habenden Grundwerte und Prioritäten herum, dem sich alle Staaten verpflichtet fühlen
%	2 	WPD/NNN.04104 	Sie ist aus der aus einem pazifistischen und einem nationalistischen Flügel 	bestehen habenden Volksunie hervorgegangen.
%	3 	WPD/ZZZ.01930 	einverstanden, nichts 	auszusetzen habend.
%	4 	M06/JAN.00578 	und geschirrspülenden Robotern ausgestattet, aber wenn all die nichts mehr zu 	tun habenden Bewohner an den Strand vor ihrer Haustür streben ... Christel Heybrock 
ts(292,"der den Aufsatz zu lesen habende Mann",@root,1,[],[8],'Kapitel 16: Passiv + Voranstellung + PVP').

% scheint es nicht im COSMAS zu geben.
% ? der zu diesem Zeitpunkt bereits gestorben gewesene Mann
ts(293,"der gestorben gewesene Mann",@root,1,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% NON09/APR.17659 	Aus dem Tank eines in der Anton-Scheiblin-Gasse 	abgestellt gewesenen Lkw sind 50 Liter Dieseltreibstoff gestohlen worden.
% SOZ09/APR.04976 	Auch wenn der im Spätherbst 	angekündigt gewesene Lance Armstrong (USA) und der Tour-de-France-Sieger Carlos Sastre (Sp)
ts(294,"der gelesen gewesene Aufsatz",@root,1,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').


% gibt es in COSMAS nur einen false positive
ts(295,"der gestorben seiende Mann",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% keine Belege in COSMAS
ts(296,"der geschlagen seiende Mann",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

ts(297,"der geschlagen werdende Mann",@root,1,[],[16],'Kapitel 16: Passiv + Voranstellung + PVP').

% belegt in COSMAS
ts(298,"der das Buch gelesen habende Affe",@root,1,[],[8],'Kapitel 16: Passiv + Voranstellung + PVP').




% Passiv-von-Phrase verlangt, dass DA ein Pronomen ist, aber "er" ist kompatibel.
% Finite Verben haben leeres DA. -> Modifikation durch von-PP ist ausgeschlossen.
ts(299,"dass er von dem Mann schläft",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').



% Perfekt mit haben
ts(300,"Das Kind ist gelacht",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% gelacht ist. Angezapft ist, aber da ist das Objekt implizit
ts(301,"Gelacht ist",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').



% von-PP modifiziert Adjektiv
ts(302,"von dem Affen kleinen",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').
ts(303,"kleinen von dem Affen",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

ts(304,"Er hat gestorben.",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').
ts(305,"Er ist das Buch gelesen.",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

ts(306,"Des Romans wird gekannt und von dem Kind geliebt",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% Extraktion von Adjunkten aus Adjunkten in der NP left-branch condition
ts(307,"Oft schläft der lachende Affe.",@decl,1,[1],_Gen,'Kapitel 16: Passiv + Voranstellung + PVP').

ts(308,"Der das Buch zu lesen gezwungene Mann lacht.",@decl,1,[1],[1],'Kapitel 16: Passiv + Voranstellung + PVP').
ts(309,"der das Buch zu lesen versprochene Mann",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').
ts(310,"Das zu lesen versprochene Buch hilft mir.",@decl,1,[1],[1],'Kapitel 16: Passiv + Voranstellung + PVP').




tg(1,"Der Affe schläft.",@decl,1,'Aus Kapitel-09: Grundfall').

tg(2,"Lacht der Affe?",@interrog,2,'Aus Kapitel-12: Generierung').
tg(3,"Kennt jede Frau und jeder Mann ein Buch?",@interrog,16,'Aus Kapitel-11: Generierung').
tg(4,"Schläft der Affe und das Kind?",@root,3,'Aus Kapitel-08: Nominale Koordination mit delayed constraints').
tg(5,"Kennt und liebt das Kind den Roman?",@interrog,2,'Aus Kapitel-08: Verbale Koordination').

tg(6,"Jede Frau und jeder Mann kennt ein Buch.",@decl,8,'Aus Kapitel-11: Generierung').
tg(7,"Den Roman kennt er.",@decl,2,'Aus Kapitel-09: RELS/HCONS-Pfade').

tg(8,"Der Affe, von dessen Kind er ein Bild kennt, lacht.",@decl,2,'Relativsatz').

tg(9,"Kennen jede Frau und jeder Mann ein Buch?",@interrog,16,'Aus Kapitel-12: Generierung').
tg(10,"Jede Frau und jeder Mann kennen ein Buch.",@decl,8,'Aus Kapitel-12: Generierung').

tg(11,"Dass Aicke lacht, freut mich.",@decl,2,'Aus Kapitel-13: Nominalisierter Satz').

tg(12,"Er denkt an das Kind.",@decl,2,'PP-Komplement').
tg(13,"Er muss lachen.",@decl,2,'Verbalkomplex').
tg(14,"Er muss an das Kind denken.",@decl,6,'Verbalkomplex mit PP').
tg(15,"Er wird lachen wollen.",@decl,2,'Mehrere Verben').
tg(16,"Lachen muss er.",@decl,2,'PVP: Pronomen ohne eigene Relation').
tg(17,"Lesen muss er das Buch.",@decl,5,'PVP mit Objekt').

% Aktiv-Passiv-Paraphrase mit zusaetzlichem von aus der Ausnahmeliste.
tg(18,"Der Mann liest den Roman.",@decl,5,'Aktiv und Passiv mit semantisch leerem von').
