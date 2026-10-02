Nach p_and_g(...) kannst Du die inaktiven, vollständig aufgebauten Kanten mit Regelname und Wortfolge ausgeben:

( c_edge(_,_,Words,_-gen_node(Rule,_,_),_,[]),
  format('~w: ~w~n',[Rule,Words]),
  fail
; true
).

Nur die durch cp_to_np erzeugten Kanten:

( c_edge(_,_,Words,_-gen_node(cp_to_np,_,_),_,[]),
  write(Words), nl,
  fail
; true
).

Das abschließende [] bedeutet, dass keine Töchter mehr erwartet werden. Für aktive Kanten ersetzt Du es durch [_|_].

Diese Abfragen zeigen auch Zwischenkandidaten, die zu keinem vollständigen Ergebnis führen. Die grafische TRALE-Chart-Anzeige ist bisher an die Parserchart angebunden; die Generatorchart wird darin noch nicht angezeigt.
