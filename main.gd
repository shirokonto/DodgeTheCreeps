extends Node

@export var mob_scene: PackedScene
@export var coin_scene: PackedScene
var score
var coinCount = 0
var maxCoins = 3

func new_game():
	get_tree().call_group("mobs", "queue_free") # deletes every mob
	get_tree().call_group("coins", "queue_free") # deletes every coin
	score = 0
	coinCount = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	spawn_initial_coins()

func spawn_initial_coins():
	for i in range(maxCoins):
		var coin = coin_scene.instantiate()
		coin.position = generate_random_position()
		$CoinsContainer.add_child(coin)
		coinCount += 1
		
func generate_random_position():
	var randX = randf_range(100, 500)
	var randY = randf_range(100, 500)
	return Vector2(randX, randY)		
		
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate() # create new instnce of mob scene

	var mob_spawn_location = get_node("MobPath/MobSpawnLocation") # choose random location on path
	mob_spawn_location.progress_ratio = randf()

	var direction = mob_spawn_location.rotation + PI / 2 # set mob direction

	mob.position = mob_spawn_location.position # Set mob's random position
	
	direction += randf_range(-PI / 4, PI / 4) # Add randomness to direction.
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0) # Choose velocity for mob.
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob) # Spawn mob by adding it to the Main scene.


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_player_coins_collected():
	pass # Replace with function body.
