extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var if_cutting = false
var if_carrying = false
var dir = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.animation = "standing_down"
	dir = Vector2.DOWN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_if_cutting()
	Level.label_text = ""
	
	if !if_cutting:
		check_collisions()
			
		var panda_velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("ui_right"):
			panda_velocity.x += 1
			dir = Vector2.RIGHT
		if Input.is_action_pressed("ui_left"):
			panda_velocity.x -= 1
			dir = Vector2.LEFT
		if Input.is_action_pressed("ui_down"):
			panda_velocity.y += 1
			dir = Vector2.DOWN
		if Input.is_action_pressed("ui_up"):
			panda_velocity.y -= 1
			dir = Vector2.UP

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
		
		if velocity == Vector2.ZERO:
			if if_carrying:
				if dir == Vector2.DOWN:
					$AnimatedSprite2D.animation = "standing_down_carrying"
				elif dir == Vector2.UP:
					$AnimatedSprite2D.animation = "standing_up_carrying"
				elif dir == Vector2.RIGHT:
					$AnimatedSprite2D.animation = "standing_right_carrying"
				elif dir == Vector2.LEFT:
					$AnimatedSprite2D.animation = "standing_left_carrying"
			else:
				if dir == Vector2.DOWN:
					$AnimatedSprite2D.animation = "standing_down"
				elif dir == Vector2.UP:
					$AnimatedSprite2D.animation = "standing_up"
				elif dir == Vector2.RIGHT:
					$AnimatedSprite2D.animation = "standing_right"
				elif dir == Vector2.LEFT:
					$AnimatedSprite2D.animation = "standing_left"
					
	else: 
		$AnimatedSprite2D.animation = "cutting"


func check_if_cutting():
	pass
	
	
func check_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			if collision.get_collider().name=="TofuBox" and !if_carrying:
				Level.label_text = "Pick up tofu box"
			elif collision.get_collider().name=="BambooChest" and !if_carrying:
				Level.label_text = "Pick up bamboo"
			elif collision.get_collider().name=="PastaBox" and !if_carrying:
				Level.label_text = "Pick up pasta box"
			elif collision.get_collider().name=="RiceBox" and !if_carrying:
				Level.label_text = "Pick up rice box"
			elif collision.get_collider().name=="TrashCan" and if_carrying:
				Level.label_text = "Throw away"
			elif collision.get_collider().name=="Pot" and !if_carrying:
				Level.label_text = "Pick up pot"
			elif collision.get_collider().name=="PlateWithTortillas" and !if_carrying:
				Level.label_text = "Pick up a tortilla"
			elif collision.get_collider().name=="CountertopForOrders" and if_carrying:
				Level.label_text = "Serve"
			elif collision.get_collider().name=="CuttingBoard" and if_carrying:
				Level.label_text = "Cut"
			elif collision.get_collider().name=="Oven" and if_carrying:
				Level.label_text = "Cook"
