
## Fragen 
#### a) Wie wird Input in das Spiel integriert? Welche Schritte sind notwendig?
	Um Tasten als Input zu definieren,benötigt es 4 Schritte
	1. Project > Project Settings > Input Map Tab öffnen
	2. Add-Button klicken und Namen der Aktion auswählen
	3. Plus-Icon auswählen und Taste auf Keyboard auswählen > Mit Ok bestätigen
	4. Im Script Input.is_action_pressed("<action_name>") mit Namen der Aktion als Parameter verwenden

#### b) Warum wird velocity normalisiert? Was passiert, wenn dies nicht vollzogen wird?
	Wenn beispielsweise die Right und Up-Taste gleichzeitig gedrückt wird, wäre 
	die velocity (1,1) und der Player würde sich diagonal schneller bewegen als 
	in eine einzelne Richtung. Wenn die velocity normalisiert wird, setzt man die 
	Länge auf 1 und multipliziert dann den Speed dazu.
	
#### c) Welche Schritte sind notwendig, um Kollisionen im Spiel zu implementieren?

## Drei visuelle Anpassungen:
####  a) Hintergrund ändert zu parallaxen Effect
####  b) Schriftart ändert zu Ekors (https://www.1001fonts.com/ekorsnoncommercial-font.html)
		1. Ausgewählte Font in fonts-Ordner kopieren
		2. Im Insepctor (HUD) des Buttons und der Labels unter Layout > Fonts : Font ersetzen
		
####  c) 

## Drei Gameplay-Anpassungen:
####  a) Sprint bei Tastendruck Shift
			1. Neue Input definieren wie in Frage a)
			2. In player.gd if/else-statement hinzufügen: 
				solange SHIFt gehalten wird, beschleunigt sich die Speed auf knapp über das doppelte. 
				Wird SHIFT losgelassen, normalisiert sich der Speed.
			
####  b) Bonis für score +2 aufsammeln
			1. Neue Scene für Bonus erstellen und RigidBody2D namens Bonus erstellen.
			2. Child-Nodes AnimatedSprite2D und CollisionShape2D hinzufügen.
			3. Animationen herunterladen und in AnimatedSprite2D unter Sprite Frames einsetzen.
			4. Neues Script namens bonus erstellen, in welchem die AnimatedSprite2D abgespielt wird.
			5. Im Node tab von bonus eine neue Gruppe namens boni erstellen.
			6. In player.gd ein neues Signal boni_collected erstellen und _on_body_entered anpassen, um boni-collision einzubauen.
			7. boni_collected connecten zu _on_player_boni_collected in main.gd, bei welcher der score um 2 Punkte erhöht wird.
			8. Für das Spawnen der drei Bonis wird in main.gd die function spawn_initial_boni und generate_random_position erstellt.
			9. Bei Start des Spiels wird spawn_initial_boni aufgerufen und die Bonis erstellt und im BoniContainer gespeichert.
			10. Wie bei dem MobSpawning werden bei jedem neuen Spiel die Bonis aus dem alten Spiel gelöscht.
		
####  c) Pausieren des Spiels
			1. Neue Controll Node namens "Pause" erstellen.
			2. Neuen Input definieren wie in Frage a)
			3. Script an "Pause" Node hinzufügen und Logik umsetzten.
				3.1 Funktion *pause_game()* umsetzt in der *get_tree().paused* und *visible* getoggled werden.
				3.2 *pause_game* mit *_input(event)* aufrufen, wenn das Event den zuvor gestzten Input entspricht. 
				3.3 "Process Mode" der "Pause" Node im Inspector auf "Always" stezten.
			4. Pausierten Zustand visualisieren.
				4.1 ColorRect namens "Overlay", Label namens "PauseLabel" und Button namens "ContinueButton" als Child Nodes von "Pause" erstellen.
				4.2 Farbe des ColorRect wählen und Alpha-Wert so anpassen,das das Spiel im Hintergrund noch zu sehen ist.
				4.3 Anchor Preset "Full Rect" auswählen, damit der gesamte ViewPort abgedeckt ist.
				4.4 Label mit Text "Paused" versehen und zentrieren.
				4.5 Button Text auf "Continue" setzten und *pressed()* Signal mit dem Script verbinden.
				4.6 Beim Aufruf von *_on_continue_button_pressed()* *pause_game()* aufrufen. 
				4.7 Sichtbarkeit der "Pause" Node im Szenenbaum ausschalten, damit der die Sichtbarkeit beim Spielstart aus ist. 
