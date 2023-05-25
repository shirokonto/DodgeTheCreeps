extends Node

@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	get_tree().call_group("mobs", "queue_free") # deletes every mob
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()

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
