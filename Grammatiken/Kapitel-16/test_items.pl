% -*- coding: utf-8; mode: trale-prolog -*-

% ts(Nr, Satz, Root, Parses, Skopuslesarten, Generiert, Kommentar).
% Generiert: erwartete Anzahl pro Parsing-Lesart, z.B. [7] oder [7,7].
% _Generated: noch keine genaue Erwartung festgelegt.

% ts(Nr, Satz, Root, Parses, Skopuslesarten, Generiert, Kommentar),var(Generiert),write(Nr),p_and_g(Satz,Root),order,fail,nl,nl. 

% Beispiele, die Permutationen voneinander sind, muss man nicht erneut testen.
% skip_generator_test([34,40,44,50,51,52,123,124,125,127,129,130]).

% Diese Wortform darf auch durch Lexikonregeln nicht erzeugt werden.
unknown_words([geschlafene,geholfene,gegraute,geregnete,gedurft]).

% Bei Beispielen mit mehreren Analysen kann man nur von einer bestimmten generieren lassen.
% generate_only([[248,1]]).

% Im Skopusfeld kann stehen
% [utool_error(distinct_quantifiers)]
% ts(123, "Beispielsatz.", @decl, 1, [utool_error(distinct_quantifiers)], _Generated, '').
%
% Damit wird genau dieser Utool-Fehler erwartet; der Variablenname `x4` darf abweichen. Andere Fehler, eine falsche Parse-Anzahl oder das Ausbleiben des erwarteten Fehlers bleiben Abweichungen.

% Für mehrere Analysen geht etwa:

% [1, utool_error(distinct_quantifiers)]



ts(1,"Der Affe schläft.",@decl,1,[1],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(2,"der Affe das Kind kennt",@root,1,[],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(3,"der Affe an das Kind denkt",@root,1,[],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(4,"Ihm graut.",@decl,1,[1],[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(5,"Der Affe graut",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(6,"Affe schläft",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen').
ts(7,"der Affe kennt",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(8,"an das Kind schläft",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(9,"an das Kind den Affe kennt",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(10,"Die Tochter des Mannes schläft.",@decl,1,[1],[8],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(11,"die Tochter Mannes",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Komplement-Strukturen, Kopf-Spezifikator-Strukturen').
ts(12,"der kleine Affe",@root,1,[],[4],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(13,"kleine der Affe",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(14,"kleine Affe der",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(15,"Das Eis in der Speisekammer schmilzt.",@decl,1,[1],[1],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').
ts(16,"das Eis in schmilzt",@root,0,[],[],'Kapitel 4: Valenz, Kopfmerkmale, Kopfmerkmalsprinzip, Kopf-Spezifikator-Strukturen, Kopf-Adjunkt-Strukturen').

ts(17,"Jede Tochter eines Mitarbeiters schläft.",@decl,1,[2],[8],'Kapitel 5: Semantik, Skopus').
ts(18,"der mutmaßliche Affe",@root,1,[],[4],'Kapitel 5: Semantik, Skopus').
ts(19,"Sein Affe schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').
ts(20,"Der angeblich kleine Affe schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').
ts(21,"Der Affe schläft wahrscheinlich.",@decl,1,[2],[4],'Kapitel 5: Semantik, Skopus').
ts(22,"Jeder Affe glaubt, dass ein Einhorn schläft.",@decl,1,[3],[30],'Kapitel 5: Semantik, Skopus').
ts(23,"Aicke schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').
ts(24,"Er schläft.",@decl,1,[1],[4],'Kapitel 5: Semantik, Skopus').

ts(25,"Aicke kennt Conny.",@decl,2,[1,1],[10,10],'Kapitel 5: Semantik, Skopus').
ts(26,"Der Affe kennt das Kind.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(27,"Der Affe kennt ein Kind.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(28,"Jeder Affe kennt jedes Kind.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(29,"Ein Kind kennt einen Mann.",@decl,1,[1],[10],'Kapitel 5: Semantik, Skopus').
ts(30,"Jeder Affe kennt ein Kind.",@decl,1,[2],[10],'Kapitel 5: Semantik, Skopus').
ts(31,"Eine Tochter eines Mitarbeiters kennt einen Affen.",@decl,1,[1],[14],'Kapitel 5: Semantik, Skopus').

ts(32,"das Eis der Speisekammer in",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(33,"dass das Kind dem Affen den Stock gibt",@root,1,[],[15],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(34,"dass das Kind den Stock dem Affen gibt",@root,1,[],[15],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(35,"Schläft er?",@interrog,1,[1],[6],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(36,"Lacht das Kind oft?",@interrog,1,[1],[11],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(37,"Lacht das Kind oft nicht?",@interrog,1,[2],[12],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(38,"Lacht das Kind nicht oft?",@interrog,1,[2],[12],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(39,"Kennt ein Kind den Roman?",@interrog,1,[1],[11],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(40,"Kennt den Roman ein Kind?",@interrog,1,[1],[11],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(41,"Aicke schläft schläft.",@decl,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(42,"Den Roman kennt und schläft er",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(43,"Kennt und liebt das Kind den Roman?",@interrog,1,[1],[13],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(44,"Kennt und liebt den Roman das Kind?",@interrog,1,[1],[13],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(45,"Kennt sie den Film und den Roman?",@interrog,1,[1],[11],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
% Grammatiken mit zyklischer Spur lassen Folgendes zu:
% Koordination eines Verbletztverbs als Verbspur mit [den Stock _]
% Valenz der beiden Konjunkte muss gleich sein. Verb muss lexikalisch sein, weil sonst DSL zu none werden würde.
ts(46,"Kennt der Affe lacht und den Stock?",@interrog,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
% parallel
ts(47,"Gibt der Affe lacht und dem Kind den Stock?",@interrog,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').

% Spielt das Kind [spielt und lacht]. mit [spielt und lacht] statt Spur.
ts(48,"Spielt das Kind spielt und lacht",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').

% 12.10.2026
% Generation: 3432.569 s CPU time.
% Chart: 19876 edges (4790 active, 15086 inactive).
ts(49,"dass das Kind dem Affen den Stock morgen gibt",@root,1,[],[44],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(50,"dass das Kind dem Affen morgen den Stock gibt",@root,1,[],[44],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(51,"dass das Kind morgen dem Affen den Stock gibt",@root,1,[],[44],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(52,"dass morgen das Kind dem Affen den Stock gibt",@root,1,[],[44],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(53,"Mann der",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(54,"der Speisekammer in",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(55,"das Kind kluge",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(56,"die in der Speisekammer Wurst",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(57,"dass Aicke den Stock gibt ihm",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').
ts(58,"dass das Kind den Roman",@root,0,[],[],'Kapitel 8: Argument- und Adjunktstellung im Mittelfeld und Verbbewegung').

ts(59,"Den Roman kennt er.",@decl,1,[1],[7],'Kapitel 9: Vorfeldbesetzung').
ts(60,"Er lacht oft.",@decl,1,[1],[4],'Kapitel 9: Vorfeldbesetzung').
ts(61,"Oft lacht er.",@decl,1,[1],[6],'Kapitel 9: Vorfeldbesetzung').
ts(62,"Oft lacht er nicht.",@decl,2,[1,1],_Generated,'Kapitel 9: Vorfeldbesetzung').

% 
% Generated phrases: 191.
% Generation: 2007.529 s CPU time.
% Chart: 95476 edges (21599 active, 73877 inactive).

ts(63,"Oft gibt er nicht dem Affen den Stock.",@decl,2,[4,4],[191,191],'Kapitel 9: Vorfeldbesetzung').
% Vorfeld kann nur einmal besetzt werden
ts(64,"Er den Stock gibt dem Affen.",@decl,0,[],[],'Kapitel 9: Vorfeldbesetzung').
% Nur eine Lesart: [den Stock _i und lacht] muss ausgeschlossen werden.
ts(65,"Der Affe nimmt den Stock und lacht.",@decl,1,[1],_Generated,'Kapitel 9: Vorfeldbesetzung').
% Satztyp:
ts(66,"Ein Affe nimmt einen Stock und das Kind lacht.",@decl,1,[1],_Generated,'Kapitel 9: Vorfeldbesetzung').
% Klaus ist ein Idiot und warum merkt das außer mir niemand?


ts(67,"Der Affe, der schläft, kennt das Kind.",@decl,1,[1],[14],'Kapitel 10: Relativsätze').
ts(68,"die Speisekammer, in der er schläft",@root,1,[],[4],'Kapitel 10: Relativsätze').
% Relativsatz als Prämodifier
ts(69,"der, der schläft, Affe",@root,0,[],[],'Kapitel 10: Relativsätze').
% Relativphrase nach dem finiten Satz
ts(70,"Der Affe, schläft der, kennt das Kind.",@decl,0,[],[],'Kapitel 10: Relativsätze').
% komplexe Relativphrase mit Relativwort in der postnominalen PP.
ts(71,"die Speisekammer, der Affe in der schläft",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(72,"Ein Affe, dessen Kind schläft, lacht.",@decl,1,[1],_Generated,'Kapitel 10: Relativsätze').
% Wenn REL nicht nach oben gereicht wird, kann "der Affe" einfach als Relativphrase verwendet werden.
ts(73,"Der Affe, der Affe schläft, lacht",@root,0,[],[],'Kapitel 10: Relativsätze').
% Relativsatz mit Verbspur statt mit overtem Verb
ts(74,"Der Affe, der den Stock, lacht",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(75,"Der Affe, dessen Stock und dessen Roman ich kenne, schläft.",@decl,1,[1],_Generated,'Kapitel 10: Relativsätze').
ts(76,"Der Affe, von dessen Kind er ein Bild malt, lacht.",@decl,1,[2],[8],'Kapitel 10: Relativsätze').

ts(77,"Der Affe, ein Bild von dessen Kind er malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(78,"Der Affe, ein Bild dessen Kindes er malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(79,"Der Affe, dessen Kind er ein Bild von malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').
ts(80,"Der Affe, dessen Kindes er ein Bild malt, lacht.",@root,0,[],[],'Kapitel 10: Relativsätze').


ts(81,"Ich schlafe.",@decl,1,[1],[3],'Kapitel 12: Kongruenz').
ts(82,"Du schläfst.",@decl,1,[1],[2],'Kapitel 12: Kongruenz').
% Ist schon oben bei 24 dabei.
%ts(83,"Er schläft.",@decl,1,[1],_Generated,'Kapitel 12: Kongruenz').
ts(84,"Er schläfst.",@decl,0,[],[],'Kapitel 12: Kongruenz').
ts(85,"die Männern",@root,0,[],[],'Kapitel 12: Kongruenz').

ts(86,"der kluge  Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(87,"des klugen Mannes",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(88,"dem klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(89,"den klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').

ts(90,"die klugen Männer", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(91,"der klugen Männer", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(92,"den klugen Männern",@root,1,[],[3],'Kapitel 12: Kongruenz').

ts(93,"das kluge  Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(94,"des klugen Kindes",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(95,"dem klugen Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').

ts(96,"die klugen Kinder", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(97,"der klugen Kinder", @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(98,"den klugen Kindern",@root,1,[],[3],'Kapitel 12: Kongruenz').

ts(99,"die kluge  Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').
ts(100,"der klugen Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(101,"die klugen Frauen",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(102,"der klugen Frauen",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(103,"den klugen Frauen",@root,1,[],[3],'Kapitel 12: Kongruenz').

ts(104,"ein   kluger Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(105,"eines klugen Mannes",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(106,"einem klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(107,"einen klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').

ts(108,"ein   kluges Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(109,"eines klugen Kindes",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(110,"einem klugen Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').

ts(111,"eine  kluge  Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').
ts(112,"einer klugen Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(113,"seine  kluge  Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').
ts(114,"seiner klugen Frau",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(115,"sein   kluger Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(116,"seines klugen Mannes",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(117,"seinem klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(118,"seinen klugen Mann",  @root,1,[],[4],'Kapitel 12: Kongruenz').

ts(119,"sein   kluges Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').
ts(120,"seines klugen Kindes",@root,1,[],[3],'Kapitel 12: Kongruenz').
ts(121,"seinem klugen Kind",  @root,1,[],[3],'Kapitel 12: Kongruenz').

ts(122,"ein   kluger Beamter",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(123,"eines klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(124,"einem klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(125,"einen klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').

ts(126,"eine  kluge  Beamte", @root,1,[],[2],'Kapitel 12: Kongruenz').
ts(127,"einer klugen Beamten",@root,1,[],[2],'Kapitel 12: Kongruenz').

ts(128,"der kluge  Beamte", @root,1,[],[4],'Kapitel 12: Kongruenz').
ts(129,"des klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(130,"dem klugen Beamten",@root,1,[],[4],'Kapitel 12: Kongruenz').
ts(131,"den klugen Beamten",@root,2,[],[3,4],'Kapitel 12: Kongruenz').

ts(132,"die kluge  Beamte", @root,1,[],[2],'Kapitel 12: Kongruenz').
ts(133,"der klugen Beamten",@root,2,[],[3,2],'Kapitel 12: Kongruenz').

ts(134,"Die kleinen Kinder schlafen.",@decl,1,[1],_Generated,'Kapitel 12: Kongruenz').
ts(135,"Kleine Kinder schlafen.",@decl,1,[1],[3],'Kapitel 12: Kongruenz').
ts(136,"Die kleine Kinder schlafen.",@decl,0,[],[],'Kapitel 12: Kongruenz').
ts(137,"Kleinen Kinder schlafen.",@decl,0,[],[],'Kapitel 12: Kongruenz').

%t(125,"Er arbeitet der ganze Tag.", @decl,0,'Kapitel 13: Kasus').
%t(126,"weil der ganze Tag gearbeitet wurde."@decl,0,'Kapitel 13: Kasus').

%ts(138,"Dass Aicke lacht, freut mich.",@decl,1,[],'Kapitel 13: Kasus').
%ts(139,"Dass Aicke lacht, freut er.",  @root,0,[],'Kapitel 13: Kasus').



% Verbalkomplexe
ts(140,"dass er lachen wird",@root,1,[],[1],'Kapitel 14: Verbalkomplex').
ts(141,"dass lachen er wird",@root,0,[],[],'Kapitel 14: Verbalkomplex').
ts(142,"dass er den Aufsatz lesen wird",@root,1,[],[2],'Kapitel 14: Verbalkomplex').
ts(143,"dass lesen er den Aufsatz wird",@root,0,[],[],'Kapitel 14: Verbalkomplex').
ts(144,"dass er lesen den Aufsatz wird",@root,0,[],[],'Kapitel 14: Verbalkomplex').
ts(145,"Er wird das Lied singen dürfen.",@decl,1,[1],[6],'Kapitel 14: Verbalkomplex').
ts(146,"Er wird lachen können wollen.",@decl,1,[1],_Generated,'Kapitel 14: Verbalkomplex').

% Partial Verb Phrase Fronting
ts(147,"Lachen muss er.",@decl,1,[1],[2],'Kapitel 14: Verbalkomplex + PVP').

ts(148,"Dem Kind erzählen muss er das Märchen.",  @decl,1,[1],[13],'Kapitel 14: Verbalkomplex + PVP').
ts(149,"Ein Märchen erzählen muss er dem Kind.",  @decl,1,[1],[13],'Kapitel 14: Verbalkomplex + PVP').

ts(150,"Ein Märchen erzählen wird er ihm müssen.",@decl,1,[1],[20],'Kapitel 14: Verbalkomplex + PVP').
ts(151,"Müssen wird er ihm ein Märchen erzählen.",@decl,0,[], [],'Kapitel 14: Verbalkomplex + PVP').

% Oberfeldumstellung z.T. mit Ersatzinfinitiv
ts(152,"dass Aicke den Roman wird lesen dürfen",@root,1,[],[4],'Kapitel 14: Verbalkomplex + PVP').
ts(153,"dass Aicke den Roman lesen dürfen wird",@root,1,[],[4],'Kapitel 14: Verbalkomplex + PVP').

ts(154,"dass Aicke den Roman hat lesen dürfen",@root,1,[],[2],'Kapitel 14: Verbalkomplex + PVP').
ts(155,"dass Aicke den Roman lesen dürfen hat",@root,0,[],[],'Kapitel 14: Verbalkomplex + PVP').
ts(156,"dass Aicke den Roman hat lesen gedurft",@root,0,[],[],'Kapitel 14: Verbalkomplex + PVP').

ts(157,"dass Aicke den Roman wird haben lesen dürfen",@root,1,[],[2],'Kapitel 14: Verbalkomplex + PVP').

ts(158,"Aicke wird haben schlafen wollen.",@decl,1,[1],[2],'Kapitel 14: Verbalkomplex + Oberfeldumstellung').

% Das hat zwei Lesarten, wenn man eine FLIP+-Spur erlaubt. Dann kann wird vor der Extraktionsspur stehen.
ts(159,"Einen Aufsatz lesen müssen, glaube ich, dass er wird.",@decl,1,[2],_Generated,'Kapitel 14: Verbalkomplex + Oberfeldumstellung').

% scheinbar mehrfache Vorfeldbesetzung uncomment loding :- ['mehrfache-vorfeldbesetzung']. in theory.pl
% t(143,"Der Frau das Buch gibt er nicht.",@decl,1,'Kapitel 14: Merhfache Vorfeldbesetzung').
% t(144,"Der Frau den Aufsatz will er geben.",@decl,1,'Kapitel 14: Merhfache Vorfeldbesetzung').
% t(145,"Der Frau der Aufsatz gibt er.",@root,0,'Kapitel 14: Merhfache Vorfeldbesetzung').
% t(146,"Der Frau der Aufsatz will er geben.",@root,0,'Kapitel 14: Merhfache Vorfeldbesetzung').

ts(160,"dass er ihn zu lesen scheint",@root,1,[],[2],'Kapitel 15: Anhebung und Kontrolle').
ts(161,"dass ihm zu grauen scheint",@root,1,[],[1],'Kapitel 15: Anhebung und Kontrolle').
ts(162,"dass den Aufsatz zu lesen der Mann beginnt",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').

% nur eine Lesart
ts(163,"dass der Mann den Aufsatz zu lesen beginnt",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(164,"dass der Mann den Aufsatz zu lesen morgen beginnt",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(165,"Er sieht es schlafen.",@decl,1,[1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(166,"Er versucht, das Lied zu singen.",@decl,1,[1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(167,"Er verspricht ihm, das Lied zu singen.",@decl,1,[1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(168,"Er zwingt ihn, das Lied zu singen.",@decl,2,[1,1],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(169,"dass ihn der Mann zu lesen versucht",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(170,"dass ihn zu lesen der Mann versucht",@root,1,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').
ts(171,"dass er ihn den Aufsatz lesen sah",@root,2,[],_Generated,'Kapitel 15: Anhebung und Kontrolle').

% Langer Satz
% der mann, der den affen, der lacht, kennt, gibt der tochter eines mitarbeiters ein Buch, das jeder mitarbeiter einer frau, die den roman lesen wird, geben wird.

ts(172,"Der Mann wurde geschlagen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(173,"Der Mann wurde von der Frau geschlagen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(174,"Mir wird geholfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(175,"Mir wird von der Frau geholfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(176,"Der Aufsatz wird mir geschenkt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(177,"Der Aufsatz wird mir von ihm geschenkt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv').
ts(178,"Er wird geschlafen.",@root,0,[],[],'Kapitel 16: Passiv').
ts(179,"Mich wird geholfen.",@root,0,[],[],'Kapitel 16: Passiv').
ts(180,"Dir wirst geholfen.",@root,0,[],[],'Kapitel 16: Passiv').
ts(181,"Heute wurde geregnet.",@root,0,[],[],'Kapitel 16: Passiv').
ts(182,"Wird gearbeitet?",@interrog,1,[1],_Generated,'Kapitel 16: Passiv').
ts(183,"Wird geregnet?",@interrog,0,[],[],'Kapitel 16: Passiv').
ts(184,"Er wurde schlafen.",@decl,0,[],[],'Kapitel 16: Passiv').
ts(185,"Wird gestorben gewesen?",@interrog,0,[],[],'Kapitel 16: Passiv').
ts(186,"dass der Aufsatz zu lesen gezwungen worden wird.",@decl,0,[],[],'Kapitel 16: Passiv').
ts(187,"Mir wird geschlagen.",@decl,0,[],[],'Kapitel 16: Passiv + Kasus').
ts(188,"Mir werde geschlagen.",@decl,0,[],[],'Kapitel 16: Passiv + Kasus').
ts(189,"Der Frau wird gegraut.",@decl,0,[],[],'Kapitel 16: Passiv + subjektloses Prädikat').
ts(190,"Heute wird gegraut.",@decl,0,[],[],'Kapitel 16: Passiv + subjektloses Prädikat').
ts(191,"Gelacht wurde.",@decl,1,[1],[1],'Kapitel 16: Passiv + subjektloses Prädikat').
ts(192,"Gearbeitet wird von dem Affen.",@decl,1,[1],[1],'Kapitel 16: Passiv + subjektloses Prädikat').


ts(193,"der geliebte Mann",@root,1,[],_Generated,'Partizip + Passiv + attributiv').
ts(194,"die von ihrem Mann geliebte Frau",@root,1,[],_Generated,'Partizip + Passiv + attributiv').
ts(195,"der geschlafene Mann",@root,0,[],[],'Partizip + Passiv + attributiv').

ts(197,"der geholfene Mann",@root,0,[],[],'Partizip + Passiv + attributiv').
ts(198,"der gegraute Mann",@root,0,[],[],'Partizip + Passiv + attributiv + subjektloses Prädikat').
ts(199,"der gestorbene Mann",@root,1,[],_Generated,'Partizip + Passiv + attributiv + unakkusativ').
ts(200,"der geregnete Mann",@root,0,[],[],'Partizip + Passiv + attributiv + Wetterverb').
ts(201,"der ihm gelungene Aufsatz",@root,1,[],_Generated,'Partizip + Passiv + attributiv + unakkusativ').
ts(202,"der von ihm gestorbene Mann",@root,0,[],[],'Partizip + Passiv + attributiv + unakkusativ').
ts(203,"der von ihm ihm gelungene Aufsatz",@root,0,[],[],'Partizip + Passiv + attributiv + unakkusativ').

%ts(196,"Der arbeitende Mann lacht.",@decl,1,[1],_Gen,'Partizip + Passiv + attributiv').
%ts(196,"der von dem Mann arbeitende Mann",@root,0,[],[],'Partizip + Passiv + attributiv').

ts(204,"dass er dem Mann haben wird",@root,0,[],[],'Partizip + Passiv + attributiv + unakkusativ').
ts(205,"Der Affe lässt den Mann den Kran reparieren.",@decl,2,[1,1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(206,"Der Affe lässt den Kran reparieren.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(207,"Der Affe lässt den Kran von einem Mann reparieren.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(208,"Der Affe lässt dem Mann helfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(209,"Der Affe lässt arbeiten.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + lassen-Passiv').
ts(210,"Er lässt von ihm dem Mann gelingen.",@decl,0,[],[],'Kapitel 16: Passiv + lassen-Passiv').
ts(211,"Er lässt sterben.",@decl,0,[],[],'Kapitel 16: Passiv + lassen-Passiv').
ts(212,"Er lässt von ihm sterben.",@decl,0,[],[],'Kapitel 16: Passiv + lassen-Passiv').
ts(213,"Der Affe bekommt den Aufsatz geschenkt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + bekommen-Passiv').
ts(214,"Der Affe bekommt von mir den Aufsatz geschenkt.",@decl,1,[1],[25],'Kapitel 16: Passiv + bekommen-Passiv').
ts(215,"Der Affe hat den Aufsatz geschenkt bekommen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + bekommen-Passiv').
ts(216,"Der Affe wird den Aufsatz geschenkt bekommen haben.",@decl,1,[1],[7],'Kapitel 16: Passiv + bekommen-Passiv').
ts(217,"Das Buch ist ihm geschenkt bekommen worden.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(218,"Das Buch ist er geschenkt bekommen worden.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(219,"Das Buch wird geschenkt bekommen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(220,"Er ist das Buch geschenkt bekommen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(221,"Du bekommst gelungen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(222,"Du bekommst von ihm gelungen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(223,"Er bekommt ein Buch geschenkt bekommen.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').
ts(224,"dass widersprochen bekam.",@decl,0,[],[],'Kapitel 16: Passiv + bekommen-Passiv').

ts(225,"Er ist geschlagen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(226,"Ist genug gearbeitet?",@interrog,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(227,"Dem Mann ist geholfen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(228,"Der Kran wird repariert sein.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(229,"Der Kran ist repariert gewesen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Zustandspassiv').
ts(230,"Ist heute geregnet?",@interrog,0,[],[],'Kapitel 16: Passiv + Zustandspassiv').
ts(231,"Ich bin geholfen.",@decl,0,[],[],'Kapitel 16: Passiv + Zustandspassiv').
ts(232,"Der Kran hat repariert zu sein.",@decl,1,[1],[2],'Kapitel 16: Passiv + Zustandspassiv + modaler Infinitiv').
ts(233,"dass der Kran zu reparieren versucht wurde",@root,1,[],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(234,"Zu reparieren versucht wurde der Kran.",@decl,1,[1],[6],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(235,"Den Kran zu reparieren wurde versucht.",@decl,1,[1],[6],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(236,"dass den Kran zu reparieren versucht wurde",@root,1,[],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(237,"Der Kran wurde zu reparieren versucht.",@decl,1,[1],[6],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(238,"Den Kran wurde zu reparieren versucht.",@decl,1,[1],[6],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(239,"Ist der Kran zu reparieren versucht worden?",@interrog,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(240,"Ein Aufsatz wurde ihm zu lesen erlaubt.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus').
ts(241,"Zu reparieren versucht wurde der Kran.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(242,"Zu reparieren versucht wurde den Kran.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(243,"Der Aufsatz gelesen wurde.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(244,"Den Aufsatz gelesen hat er.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(245,"Den Aufsatz gelesen wurde.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(246,"Der Aufsatz gelesen hat er.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kasus + PVP').
ts(247,"Die Aufsätze gelesen wurden.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(248,"Die Aufsätze gelesen wurde.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(249,"Den Aufsatz lesen sieht er ihn müssen.",@decl,1,[1],_Generated,'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(250,"Der Aufsatz lesen sieht er ihn müssen.",@decl,0,[],[],'Kapitel 16: Passiv + Fernpassiv + Kohärenz + Kongruenz + PVP').
ts(251,"Das Buch ist zu lesen.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + sein').
ts(252,"Dem Mann ist zu helfen.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + sein').
ts(253,"Dem Mann scheint nicht zu helfen zu sein.",@decl,3,[2,2,2],[6,6,7],'Kapitel 17: modaler Infinitiv + sein').
ts(254,"Die Frau ist ihm zu helfen.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + sein').
ts(255,"Die Frau ist das Buch zu lesen.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + sein').
ts(256,"Aicke kennt den zu lesenden Aufsatz.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + attributiv').
ts(257,"Aicke kennt den von ihm zu lesenden Aufsatz.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + attributiv').
ts(258,"der das Buch zu lesende Mann",@root,0,[],_Generated,'Kapitel 17: modaler Infinitiv + attributiv').
ts(259,"Der den Aufsatz lesende Affe lacht.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + attributiv').
ts(260,"Er hat den Aufsatz zu lesen.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + haben').
ts(261,"Der Mann hat ihm zu helfen.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + haben').
ts(262,"Der Frau hat zu helfen.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + haben').
ts(263,"Dem Mann hat zu grauen.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + haben + subjektloses Prädikat').
ts(264,"Der Aufsatz hat gelesen zu werden.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + haben + Passiv').
ts(265,"Das Buch wird zu lesen gehabt.",@decl,0,[],[],'Kapitel 17: modaler Infinitiv + haben + Passiv').
ts(266,"Ihm hat geholfen zu werden.",@decl,1,[1],_Generated,'Kapitel 17: modaler Infinitiv + haben + Passiv + subjektloses Prädikat').
ts(267,"dass ihm nicht geholfen zu werden ist",@root,0,[],[],'Kapitel 17: modaler Infinitiv + haben + Passiv + subjektloses Prädikat').
ts(268,"Dem Mann gelungen wurde nicht.",@decl,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% Passiv-von-Phrase verlangt, dass DA ein Pronomen ist, aber "er" ist kompatibel.
% Finite Verben haben leeres DA. -> Modifikation durch von-PP ist ausgeschlossen.
%ts(269,"dass er von dem Mann schläft",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').



% Perfekt mit haben
ts(270,"Das Kind ist gelacht",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% gelacht ist. Angezapft ist, aber da ist das Objekt implizit
ts(271,"Gelacht ist",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').



% von-PP modifiziert Adjektiv
ts(272,"von dem Affen kleinen",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').
ts(273,"kleinen von dem Affen",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

ts(274,"Er hat gestorben.",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').
ts(275,"Er ist das Buch gelesen.",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

ts(276,"Des Romans wird gekannt und von dem Kind geliebt",@root,0,[],[],'Kapitel 16: Passiv + Voranstellung + PVP').

% Extraktion von Adjunkten aus Adjunkten in der NP left-branch condition
ts(277,"Oft schläft der lachende Affe.",@decl,1,[1],_Gen,'Kapitel 16: Passiv + Voranstellung + PVP').



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
