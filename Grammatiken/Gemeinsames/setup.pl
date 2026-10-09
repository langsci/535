% -*-trale-prolog-*-
% Gemeinsame Einstellungen aller Lehrbuchgrammatiken. Speicherwerte in MiB.
% Bei einer Grammatik-Neuladung erneut konsultieren (nicht ensure_loaded).

:- ale_flag(msl,_,off).
% Inkonsistente Regeln nicht vorab berechnen.
:- ale_flag(efdcheck,_,on).
% Verbspuren nur bei einem plausiblen Filler in die Chart aufnehmen.
:- ale_flag(head_movement_filter,_,on).
:- ale_flag(morphoutput,_,on).
% Zusätzliche Wörter ohne Eingaberelationen bei der Generierung ausschließen.
:- ale_flag(generator_input_lexicon,_,empty_only).

% Wenn Typ-Constraints inkonsistent sind, werden sie standardmäßig durch true ersetzt.
% Das ist gefährlich, weil dann das Laden des Lexikons verrückt werden kann.
% Mit diesem Flag kann man einen Abbruch erzwingen.
% Mit `warning` erhält man das bisherige Verhalten. 
:- ale_flag(unsatisfiable_when, _, error).

% Obergrenze; das gemeinsame Speicherbudget kann die Parallelität verringern.
use_cpus_parallel(10).
test_total_memory_limit(system). % verfügbaren Systemspeicher dynamisch nutzen
test_system_memory_reserve(4096). % 4 GiB Systempuffer

% Wenn nach 5 Sekunden weiterhin **alle Worker warten und keiner fortfahren kann**, bricht TRALE den größten wartenden Test ab. Dieser wird als **fehlgeschlagen und unvollständig** gemeldet; sein Speicher wird freigegeben.

% Die anderen Tests können anschließend weiterlaufen oder fortgesetzt werden. Der abgebrochene Test wird nicht automatisch wiederholt.

% Bei einem seriellen Lauf bricht entsprechend der aktuelle Test ab, danach folgt der nächste.

test_system_memory_wait(5000).    % bei Systemknappheit bis zu 5 Sekunden warten
test_memory_reserve(1024).     % 1 GiB für Wachstum zwischen Kontrollpunkten
% on, off oder eine Liste aus start, defer, pause, resume, abort, serial.
test_memory_messages(off).

% CPU-Zeit in Millisekunden für Generierung und Parsing/Skopus bei testall.
% Interaktives p_and_g wird dadurch nicht begrenzt.
generator_test_timeout(300000). % 5 Minuten

:- [tokenization].
% SVG in der auf dem Mac eingestellten Anwendung öffnen.
graphviz_option(svg,'sleep 0.5; open').
:- trale_milca_version('2.7.12') -> true; ['new-trale.pl'].
:- chart_display.
:- nochart_debug.
:- german.
:- notcl_warnings.
