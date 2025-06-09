extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var if_cutting = false
var if_carrying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_if_cutting()
	
	if !if_cutting:
		var velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
			
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		
		if !if_carrying:
			if velocity.x > 0:
				$AnimatedSprite2D.animation = "walk_right"
			elif velocity.x < 0:
				$AnimatedSprite2D.animation = "walk_left"
			elif velocity.y < 0:
				$AnimatedSprite2D.animation = "walk_up"
			elif velocity.y > 0:
				$AnimatedSprite2D.animation = "walk_down"
		else:
			if velocity.x > 0:
				$AnimatedSprite2D.animation = "walk_right_carrying"
			elif velocity.x < 0:
				$AnimatedSprite2D.animation = "walk_left_carrying"
			elif velocity.y < 0:
				$AnimatedSprite2D.animation = "walk_up_carrying"
			elif velocity.y > 0:
				$AnimatedSprite2D.animation = "walk_down_carrying"
	else: 
		$AnimatedSprite2D.animation = "cutting"


func check_if_cutting():
	pass

	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
