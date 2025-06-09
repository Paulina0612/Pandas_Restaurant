extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var if_cutting = false
var if_carrying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_if_cutting()
	
	if !if_cutting:
		var panda_velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("ui_right"):
			panda_velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			panda_velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			panda_velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			panda_velocity.y -= 1

		if panda_velocity.length() > 0:
			panda_velocity = panda_velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
			
		#position += panda_velocity * delta
		#position = position.clamp(Vector2.ZERO, screen_size)
		velocity=panda_velocity
		move_and_slide()
		
		if !if_carrying:
			if panda_velocity.x > 0:
				$AnimatedSprite2D.animation = "walk_right"
			elif panda_velocity.x < 0:
				$AnimatedSprite2D.animation = "walk_left"
			elif panda_velocity.y < 0:
				$AnimatedSprite2D.animation = "walk_up"
			elif panda_velocity.y > 0:
				$AnimatedSprite2D.animation = "walk_down"
		else:
			if panda_velocity.x > 0:
				$AnimatedSprite2D.animation = "walk_right_carrying"
			elif panda_velocity.x < 0:
				$AnimatedSprite2D.animation = "walk_left_carrying"
			elif panda_velocity.y < 0:
				$AnimatedSprite2D.animation = "walk_up_carrying"
			elif panda_velocity.y > 0:
				$AnimatedSprite2D.animation = "walk_down_carrying"
	else: 
		$AnimatedSprite2D.animation = "cutting"


func check_if_cutting():
	pass
	
