# Generierungstests im Batch-Modus

Die Tests stehen in der jeweiligen `test_items.pl`, getrennt von den
Parsingtests (`t` / `ts`):

```prolog
tg(5,"Lachen muss er.",@decl,2,'PVP mit Pronomen').
```

Die Argumente sind Nummer, Eingabe, Startsymbol, erwartete Anzahl generierter
Lösungen und Kommentar. Ohne Kommentar ist auch `tg/4` möglich.

**Gezählt wird jede vom Generator gelieferte Lösung, auch bei gleicher
Wortfolge.** Bei mehreren Eingabeanalysen werden die Generierungen aus allen
Analysen summiert. Die Ausgabe nennt zusätzlich die Anzahl der Eingabeanalysen.
Die Sollzahlen sind feste Regressionserwartungen für den geprüften Stand;
sie werden beim Testlauf nicht automatisch angepasst. Eine gleiche Anzahl
beweist allein noch nicht, dass dieselben Wortfolgen oder korrekte Bäume
entstanden sind. Die bisherigen Strukturtests bleiben daher zusätzlich nützlich.

## Aufrufe nach dem Laden der Grammatik

```prolog
testgt(all).                  % alle Generierungstests
testgt(5).                    % ein Test
testgt([2,5]).                % einschließlich 2 und 5
testgt(all,summary(OK,Fehler)). % Zusammenfassung für Programme
```

Beispielausgabe:

```text
 (g5) Lachen muss er.  % PVP mit Pronomen
 ==> 1.800 sec CPU time. 2 generated solutions from 1 parses (ok)

Generation tests: 7 passed, 0 failed.
```

Bei einer falschen Sollzahl erscheint etwa `(!!! 3 expected !!!)`. Fehlende
oder doppelte Nummern, Exceptions, fehlende Eingabeanalysen und Zeitüberschreitungen
zählen als fehlgeschlagene Tests. Auch bei Sollzahl null muss die Eingabe
mindestens eine Analyse haben; sonst wurde der Generator nicht geprüft.
Die CPU-Zeit umfasst das Parsen und alle zugehörigen Generierungen.

Der Testlauf stellt keine Rückfragen und zeigt keine AVMs/Bäume an. Veränderte
Ausgabe- und Generatoreinstellungen werden auch bei Fehlern zurückgesetzt.
Je Test gilt eine Zeitgrenze von 120000 Millisekunden, einschließlich Parsing.
Sie kann in `setup.pl` angepasst werden:

```prolog
generator_test_timeout(300000).
```

`testg` / `testgw` bleiben als ältere ausführliche Schnittstellen erhalten und
können ebenfalls die neuen `tg/4`- und `tg/5`-Einträge lesen. Alte `tg/3`-Einträge
haben keine Sollzahl und werden von `testgt` deshalb als unvollständig gemeldet.

## Auswertung in Prolog

`testgt(all)` läuft ohne Rückfragen über alle Testeinträge der geladenen
Grammatik. Für eine programmgesteuerte Auswertung:

```prolog
testgt(all, summary(Bestanden, Fehlgeschlagen)).
```

`testgt(all, summary(_, 0))` gibt ebenfalls den vollständigen Bericht aus,
schlägt als Prolog-Ziel aber fehl, wenn mindestens ein Test fehlschlägt.
Auch eine leere Testauswahl oder ein fehlender Eintrag zählt als Fehler.

Die Funktion `testgt` liegt in `test_suite_handling4.pl`; der gemeinsame
Generator liefert über `generator_test_results/4` die Ergebnisse aus sämtlichen
Analysen. Nach der Aktualisierung der TRALE-Installation TRALE neu starten
und die gewünschte Grammatik laden.

## Enthaltene Fälle

Die Generierungstests werden kumulativ in den `test_items.pl` der Kapitel
05, 06, 08, 09, 10, 11, 12, 13 und 14 aufgeführt: Jeder spätere Testbestand
enthält auch alle Eingaben und Startsymbole der früheren Kapitel.
Insgesamt sind es 68 Testeinträge, davon 17 in Kapitel 14.
Bestehende Testnummern und Erwartungen bleiben erhalten; Ergänzungen erhalten
neue Nummern. Ihr Kommentar nennt das Kapitel, aus dem die Sollzahl stammt.

Übernommene Eingaben, Startsymbole und Sollzahlen werden nicht an das aktuelle
Testergebnis angepasst. Hat ein Kapitel bereits einen eigenen Test für dieselbe
Eingabe und dasselbe Startsymbol, bleibt dessen Erwartung maßgeblich. Neue Tests
übernehmen die Erwartung des letzten früheren Kapitels mit einem eigenen Eintrag.
Unterschiede in der Ableitungszahl und fehlende Eingabeanalysen werden damit
sichtbar. Fehlende Lexikoneinträge müssen in der Grammatik ergänzt werden;
Testsätze werden dafür nicht umformuliert.

Die früheren Singular-Beispiele mit koordiniertem Subjekt bleiben auch ab
Kapitel 12 enthalten. Dort verlangen die Koordinationsregeln Pluralkongruenz;
diese Eingaben erhalten deshalb keine Analyse. Die bereits vorhandenen
Plural-Beispiele bleiben zusätzlich enthalten. Auch „Der Affe schläft.“ mit
`@decl` bleibt in Kapitel 08 unverändert enthalten, obwohl dieses Startsymbol
dort noch keine entsprechende Verbzweit-Analyse zulässt. Solche Fälle meldet
`testgt` ausdrücklich als fehlgeschlagen, auch wenn der Grund eine beabsichtigte
Entwicklung der Grammatik ist.
