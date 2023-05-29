
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
		Alle Objekte die Kollidieren sollen müssen eine CollisionShape Node besitzen. 
		Zudem muss noch eine Shape im Inspector zugewiesen werden welche die Form des Objekts beschreibt.
		Die Gegner in diesem Projekt sind RigidBody2D Nodes, daher kann für die Erkennung von Kollisionen mit dem Player das Signal *body_entered(body: Node2D)* verwendet werden.
		Mit der Integration dieses Signals im Player Skript kann dann die Kollision weiter verarbeitet werden indem z.B ein hit Signal gesendet wird.
		 
## Drei visuelle Anpassungen:
#### a) Hintergrund zu parallaxem Effekt geändert
		1. ParallaxBackground Node erstellen mit ParallaxLayer Child Nodes für jede Ebene des Hintergrunds 
		2. Für die ParallaxLayers jeweils die Sprites des Hintergrunds in Sprite2D Nodes einbinden und auf eine angemessene Größe skalieren (4x).
		3. Die "Motion Scale" im Inspector für jede ParallaxLayer setzten. Geringere Werte ensprechen langsameren Bewegungen (größere Entfernung zum Betrachter). 
		4. In *_process()* die Position des Spielers mit dem *scroll_offset* der ParallaxBackground Node gleichsetzen.
		
#### b) Schriftart zu Ekors geändert (https://www.1001fonts.com/ekorsnoncommercial-font.html)
		1. Ausgewählte Font in fonts-Ordner kopieren
		2. Im Insepctor (HUD) des Buttons und der Labels unter Layout > Fonts : Font ersetzen
		
#### c) Änderung des AnimatedSprite2D vom Player
		1. Für jedes vorhandene Sprite der Animation muss eine neues Sprite erstellt bzw. besorgt werden.
		2. In der  in der AnimatedSprite2D Node der Player Scene jeden Frame der Animation mit einem neuen Frame austauschen.  

## Drei Gameplay-Anpassungen:
#### a) Sprint bei Tastendruck Shift
		1. Neue Input definieren wie in Frage a)
		2. In player.gd if/else-statement hinzufügen: 
			solange SHIFT gehalten wird, beschleunigt sich der Speed auf knapp über das doppelte. 
			Wird SHIFT losgelassen, normalisiert sich der Speed.
			
#### b) Boni für score +2 aufsammeln
		1. Neue Scene für Bonus erstellen und RigidBody2D namens Bonus erstellen.
		2. Child-Nodes AnimatedSprite2D und CollisionShape2D hinzufügen.
		3. Animationen herunterladen und in AnimatedSprite2D unter Sprite Frames einsetzen.
		4. Neues Script namens Bonus erstellen, in welchem die AnimatedSprite2D abgespielt wird.
		5. Im Node tab von Bonus eine neue Gruppe namens Boni erstellen.
		6. In player.gd ein neues Signal *boni_collected* erstellen und _on_body_entered anpassen, um boni-collision einzubauen.
		7. boni_collected connecten zu *_on_player_boni_collected* in main.gd, bei welcher der score um 2 Punkte erhöht wird.
		8. Für das Spawnen der drei Boni wird in main.gd die function *spawn_initial_boni* und *generate_random_position* erstellt.
		9. Bei Start des Spiels wird *spawn_initial_boni* aufgerufen und die Boni erstellt und im BoniContainer gespeichert.
		10. Wie bei dem MobSpawning werden bei jedem neuen Spiel die Boni aus dem alten Spiel gelöscht.
		
#### c) Pausieren des Spiels
		1. Neue Controll Node namens "Pause" erstellen.
		2. Neuen Input definieren wie in Frage a)
		3. Script an "Pause" Node hinzufügen und Logik umsetzen.
			3.1 Funktion *pause_game()* setzt Boolean-Werte *get_tree().paused* und *visible* true oder false.
			3.2 *pause_game* mit *_input(event)* aufrufen, wenn das Event dem zuvor gesetzten Input entspricht.
			3.3 "Process Mode" der "Pause" Node im Inspector auf "Always" stezten.
		4. Pausierten Zustand visualisieren.
			4.1 ColorRect namens "Overlay", Label namens "PauseLabel" und Button namens "ContinueButton" als Child Nodes von "Pause" erstellen.
			4.2 Farbe des ColorRect wählen und Alpha-Wert so anpassen,dass das Spiel im Hintergrund noch zu sehen ist.
			4.3 Anchor Preset "Full Rect" auswählen, damit der gesamte ViewPort abgedeckt ist.
			4.4 Label mit Text "Paused" versehen und zentrieren.
			4.5 Button Text auf "Continue" setzen und *pressed()* Signal mit dem Script verbinden.
			4.6 Beim Aufruf von *_on_continue_button_pressed()* *pause_game()* aufrufen. 
			4.7 Sichtbarkeit der "Pause" Node im Szenenbaum ausschalten, damit die Sichtbarkeit beim Spielstart aus ist. 
