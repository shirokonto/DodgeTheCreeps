extends Area2D
signal hit
signal coins_collected

@export var speed = 400 # How fast the player will move (pixels/sec).
var sprint_speed = 1000
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # 480 x 720
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Check for input (Project -> Project Settings -> Input Map)
	var velocity = Vector2.ZERO # The player's movement vector -> should not be moving
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	elif !Input.is_action_pressed("sprint"):
		speed = 400

	if velocity.length() > 0: # prevents fast diagonal speeding
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	# move in given direction
	position += velocity * delta # frame length
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# play appropriate animation 
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0 # if v.x <0 : flip_h =true
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func _on_body_entered(body):
	if body.is_in_group("coins"):
		body.queue_free()
		# coins_collected.emit
		body.hide()
	else:
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true) # tells Godot to wait to disable the shape until it's safe to do so

func collect_coins():
	pass

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
