# Signaturen als ALE-Deklarationen

Die direkt im Grammatikverzeichnis liegenden Kapitel-Grammatiken laden
`signature.pl` statt der eingerückten Datei `signature`. Die Flags stehen in
`setup.pl`:

```prolog
:- ale_flag(subintro,_,grammar).
:- ale_flag(msl,_,off).
```

`theory.pl` lädt danach `:- ['signature.pl'].`. Die alten Dateien `signature`
bleiben erhalten. `Old`, `Bug-Report` und untergeordnete Beispielgrammatiken
werden nicht umgestellt.

## Neu erzeugen

Im jeweiligen Kapitelverzeichnis:

```sh
python3 ../Gemeinsames/tdl_to_signature.py lkb/types.tdl signature.pl
```

Kapitel 03, 03-ArgSt, 04, 04-ArgSt und 05 haben keine `types.tdl`. Für sie gilt:

```sh
python3 ../Gemeinsames/tdl_to_signature.py --format signature signature signature.pl
```

Der Konverter unterstützt benannte Obertypen, Mehrfachvererbung und flache
Merkmalsdeklarationen sowie die ältere TDL-Schreibweise `:<`. Nicht unterstützte
Konstrukte werden abgewiesen. Gewöhnliche Atome bleiben unquotiert. Untertypen
sind eingerückt; `intro` steht unter dem jeweiligen `sub`. Bei Mehrfachvererbung
wird jeder Typ einmal ausgeschrieben, aber in allen Obertyp-Listen aufgeführt.

TRALE ergänzt die fehlenden least upper bounds selbst. Dafür wird die unter
`~/Codex/new-trale-git` korrigierte Typvervollständigung benötigt (Commit
`c1c14ff`). Eine andere TRALE-Installation wurde nicht verändert.
Mit `ale_flag(debugmsl,_,on)` lassen sich die Diagnoseausgaben einschalten;
standardmäßig sind sie aus.

Bei Kapitel 18 wurde in `lkb/types.tdl` der nicht definierte Obertyp
`non_dls_head` im Typ `comp` zu `non_dsl_head` korrigiert.

## Prüfung der Umstellung (29.09.2026)

Die 15 direkt enthaltenen Grammatikvarianten von Kapitel 03 bis 14 wurden vor
und nach der Umstellung mit TRALE unter `~/Codex/new-trale-git` geprüft.
Alle 842 Parser-Testdurchläufe liefern dieselben Lösungszahlen, Kantenzahlen
und Residuen wie vorher. Die Ausgangsgrammatiken haben zwei Abweichungen von
ihren Testerwartungen, die unverändert bleiben: Kapitel 10, Test 70 (zwei
statt null Analysen), und Kapitel 13, Test 127 (eine statt null Analysen).
Die späteren Kapitel wurden konvertiert, aber nicht als lauffähig validiert.

Die Prüfungen liefen ohne Chartanzeige und ohne utool-Skopusberechnung;
Skopuslesarten wurden dabei nicht geprüft. Protokolle und Vorher-Nachher-Vergleich
liegen unter `~/Codex/.signature-migration/`.

In Kapitel 14 wurde außerdem die bereits zuvor entwickelte Generator-Konfiguration
für offene Verbalkomplex-Valenz in `setup.pl` übernommen: `generator_valence_path/1`
und der Anker für verbale Füller. Der gemeinsame Generatorcode war im Zielbestand
bereits vorhanden; ohne diese Konfiguration lief „Er muss lachen.“ in die
Testzeitgrenze. Die vorhandenen Änderungen an `le_macros.pl` wurden beibehalten.

Die Generatortests für Kapitel 05, 06, 08, 09, 10, 13 und 14 bestehen,
einschließlich Relativsätzen, Koordination und Verbalkomplexen.
