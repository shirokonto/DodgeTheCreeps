extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names() # frames has all three animations
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()]) # randomly choose one of the three animation types

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
