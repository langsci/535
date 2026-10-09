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

## Redundante Rechenwege bei leeren Kategorien

Bei der Valenzverankerung kann ein Wort ebenso wie eine bereits aufgebaute
Phrase als Quelle dienen. Zum Beispiel liefern „geschlagen“ und „von dem
Affen geschlagen“ zwei Wege zum selben leeren Verbalkomplex. Die Wortquelle
spezifiziert dessen `ARG_ST` stärker, obwohl beide Wege dieselbe Ableitung
und dieselben Eingaberelationen verwenden.

Der Generator prüft abgeschlossene Kanten mit einer abgeleiteten leeren
Tochter bereits beim Einfügen in die Agenda. Deckt eine vorhandene Kante die
neue Kante vollständig ab, wird die neue nicht nochmals weiterverarbeitet.
Geprüft werden die vollständige Kante, der semantische Kontext und alle
residualen Constraints; Ableitungsbaum und Relationsabdeckung müssen
übereinstimmen. Gleiche Wortfolgen allein reichen nicht aus. Verschiedene
Bäume und unvergleichbare Merkmalsstrukturen bleiben erhalten. Die Prüfung
ist konservativ und entfernt nicht jede mögliche Doppelung.

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

## Speichergrenze und Bereinigung

Der gemeinsame Generator prüft standardmäßig eine Grenze von 1024 MiB
pro Prozess. Eine Grammatik kann sie in `setup.pl` konfigurieren:

```prolog
generator_memory_limit(512). % positive ganze Zahl in MiB
```

Gemessen wird der von SICStus allokierte Speicher einschließlich Stacks und
dynamischer Datenbank. Die Prüfung erfolgt beim Einstieg, beim Speichern von
Chartkanten, beim Abarbeiten der Agenda und beim Sammeln der Ergebnisse.
Die Grenze ist keine harte Betriebssystemgrenze: Eine einzelne große
Allokation kann sie überschreiten. Bei parallelen Tests gilt sie für jeden
Prozess einzeln; der Gesamtspeicher wächst weiterhin mit der Prozesszahl.

Ein Überschreiten löst `generator_memory_limit_exceeded(Belegt,Limit)` aus,
mit beiden Werten in Bytes. Der Testlauf meldet den Abbruch als Fehler und
zählt eine unvollständige Generierung nicht als Erfolg. Der Fehler beweist
keine Abweichung der Grammatik von ihren semantischen Erwartungen.

Batch-Tests entfernen nach Erfolg, Timeout oder Ausnahme Agenda, Chart,
Generatorregeln, Quick-Check-Cache und gespeicherte Wortlisten. Anschließend
fordert `trimcore` die Freigabe unbenutzten Speichers an. Bereits erfasste
Zeit- und Chartstatistiken bleiben erhalten. Erfolgreiche interaktive
Generierung behält ihre Chart zur Anzeige. Nach Installation TRALE neu
starten und die Grammatik neu kompilieren.

## Gemeinsame Testkonfiguration und Speicherbudget

Alle Kapitel laden `Gemeinsames/setup.pl` aus ihrem jeweiligen `setup.pl`.
Dort stehen die allgemeinen Parser-/Generatorflags, Anzeigeoptionen,
Tokenisierung, Parallelität und Zeitgrenzen. Signaturmodus, Merkmalsdarstellung,
Semantik-/Generatorpfade und grammatische Beschreibungen bleiben lokal.
Die gemeinsame Datei wird bei `c.` erneut konsultiert.

```prolog
use_cpus_parallel(10).          % Höchstens zehn Worker
test_total_memory_limit(16384). % 16 GiB in MiB, Elternprozess eingeschlossen
test_memory_reserve(1024).      % 1 GiB Reserve zwischen Kontrollpunkten
test_memory_messages(on).
generator_test_timeout(300000).
```

`testall` startet weitere Worker erst bei ausreichendem Budget. Laufende
Worker melden ihren SICStus-Speicherverbrauch und erhalten reservierte
Wachstumskontingente. Bei Druck warten sie an Parser-/Generatorprüfpunkten
und setzen mit erhaltenen Variablen und verzögerten Constraints fort.
Pausieren gibt keinen Speicher frei. Wenn alle verbleibenden Worker warten
und keiner fortfahren kann, bricht der größte betroffene Test als fehlerhaft
und unvollständig ab. Sein Zustand wird freigegeben; weitere Tests laufen
weiter. Ein abgebrochener Test wird nicht automatisch wiederholt.

Die Ereignismeldungen lassen sich mit `off` abschalten oder mit einer Liste
wie `[pause,resume,abort]` auswählen. Ereignisse: `start`, `defer`, `pause`,
`resume`, `abort`, `serial`. Fehlermeldungen bleiben sichtbar. Das gesamte
Budget lässt sich mit `test_total_memory_limit(off)` deaktivieren.

Innerhalb von `testall` darf ein Generator ohne explizites Einzellimit das
gemeinsame Budget abzüglich Reserve nutzen. Außerhalb bleibt der Standard
von 1024 MiB bestehen; ein explizites `generator_memory_limit/1` gilt weiter.

Gezählt wird allokierter SICStus-Engine-Speicher, kein hart begrenzter
OS-RSS-Verbrauch. Große Einzelallokationen können zwischen Prüfpunkten
überschießen; Utool, Fremdbibliotheken und andere TRALE-Sitzungen werden
nicht mitgezählt. Für dieses Update TRALE neu starten und die Grammatik
laden; `trale_make` allein liest den grammatikseitigen Generator nicht neu.

## Verfügbaren Systemspeicher nutzen

Das gemeinsame Setup verwendet jetzt statt des festen 16-GiB-Limits:

```prolog
test_total_memory_limit(system).
test_system_memory_reserve(4096). % 4 GiB Systempuffer
test_memory_reserve(1024).        % zusätzliche Wachstumsreserve
test_system_memory_wait(5000).   % Wartezeit bei Systemknappheit, Millisekunden
```

Während `testall` prüft der Elternprozess den verfügbaren Systemspeicher
regelmäßig (spätestens beim nächsten Prüfen nach 250 ms), sowie nach Start,
Testbereinigung und Beenden eines Workers. Damit beeinflussen andere
Programme die verfügbare Zuteilung. Zwischen Messungen werden bereits
zugesagte Wachstumskontingente und neu gemeldetes Wachstum abgezogen.
Es bleibt keine feste 16-GiB-Obergrenze. Ein numerisches Gesamtlimit kann
weiterhin zusätzlich zu einem Systempuffer gesetzt werden; dann gilt die
kleinere Zuteilung. Ohne expliziten Systempuffer bleibt ein numerisches
Gesamtlimit beim bisherigen Verhalten.

Sind alle Worker wegen Systemknappheit angehalten, prüft der Elternprozess
auch ohne neue Pipe-Nachrichten weiter. Wird Speicher frei, setzen sie mit
ihrem Berechnungszustand fort. Hält die Knappheit länger als die konfigurierte
Wartezeit an, folgt der saubere Abbruch eines betroffenen Tests. Serielle
Tests können ebenfalls an einem Prüfpunkt warten und fortsetzen. Die CPU-
Zeitgrenze zählt die Wartezeit nicht. Die bestehenden Meldungsfilter gelten
weiter; Meldungen nennen zusätzlich verfügbare Schätzung und Systempuffer.

Auf macOS stammt die Schätzung aus `vm_stat`: freie, inaktive und spekulative
Seiten. Inaktiv ist eine Schätzung der Rückgewinnbarkeit, keine Garantie,
dass alles ohne Kompression oder Auslagerung verfügbar wird. Purgeable-Seiten
werden wegen möglicher Überschneidung nicht zusätzlich addiert. Auf Linux
wird `MemAvailable` aus `/proc/meminfo` genutzt. Die Reserve bleibt kooperativ,
keine harte OS-Speicherreservierung. Kann der Systemcheck nicht gelesen
werden, stoppt die Suite mit einer lesbaren Meldung.

Dieses Core-Update mit `trale_make.` laden, danach die Grammatik mit `c.`
neu laden; alternativ TRALE neu starten und die Grammatik laden.

### Ausnahmen fuer semantisch leere Woerter

Kapitel 16 verwendet weiterhin `generator_input_lexicon=empty_only`. In
`setup.pl` erlaubt `generator_input_lexicon_exceptions([von,durch]).` diese
zusaetzlichen Woerter ohne eigene Semantikrelation. Die Liste kann erweitert
werden; mehrfache Eintraege werden zusammengefasst. Die Ausnahme gilt nur
fuer `empty_only`, nicht fuer die strikte Einstellung `on`. Die vorhandenen
Pronomenrelationen sichern weiterhin deren Abdeckung. Test `tg(18)` erwartet
fuer „Der Mann liest den Roman.“ zwei Aktiv- und drei Passivstellungen.
