
## Fragen 
a) Wie wird Input in das Spiel integriert? Welche Schritte sind notwendig?
	Um Tasten als Input zu definieren,benötigt es 4 Schritte
	1. Project > Project Settings > Input Map Tab öffnen
	2. Add-Button klicken und Namen der Aktion auswählen
	3. Plus-Icon auswählen und Taste auf Keyboard auswählen > Mit Ok bestätigen
	4. Im Script Input.is_action_pressed("<action_name>") mit Namen der Aktion als Parameter verwenden

b) Warum wird velocity normalisiert? Was passiert, wenn dies nicht vollzogen wird?
	Wenn beispielsweise die Right und Up-Taste gleichzeitig gedrückt wird, wäre 
	die velocity (1,1) und der Player würde sich diagonal schneller bewegen als 
	in eine einzelne Richtung. Wenn die velocity normalisiert wird, setzt man die 
	Länge auf 1 und multipliziert dann den Speed dazu.
	
c) Welche Schritte sind notwendig, um Kollisionen im Spiel zu implementieren?

## Drei visuelle Anpassungen:
a) Hintergrund ändert zu parallaxen Effect
b) Schriftart ändert zu Ekors (https://www.1001fonts.com/ekorsnoncommercial-font.html)
c) 

## Drei Gameplay-Anpassungen:
a) Sprint bei Tastendruck Shift
b) Bonis aufsammeln (x)
c) Verschiedene Geschwindigkeiten der Gegner (x)
