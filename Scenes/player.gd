extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var if_cutting = false
var if_carrying = false
var dir = Vector2.ZERO
var collider_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.animation = "standing_down"
	dir = Vector2.DOWN
	$Node2D/FoodSprite.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_if_carrying()
	Level.label_text = ""
	
	animation()
	action_on_click()

func animation():
	if !if_cutting:
		check_collisions()
	
		var panda_velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_right"):
			panda_velocity.x += 1
			dir = Vector2.RIGHT
		if Input.is_action_pressed("move_left"):
			panda_velocity.x -= 1
			dir = Vector2.LEFT
		if Input.is_action_pressed("move_down"):
			panda_velocity.y += 1
			dir = Vector2.DOWN
		if Input.is_action_pressed("move_up"):
			panda_velocity.y -= 1
			dir = Vector2.UP

		if panda_velocity.length() > 0:
			panda_velocity = panda_velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
			
		
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

func check_if_carrying():
	if if_carrying:
		#Transform according to player position
		if dir == Vector2.DOWN:
			$Node2D/FoodSprite.position.x = $Node2D.position.x 
			$Node2D/FoodSprite.show()
		elif dir == Vector2.UP:
			$Node2D/FoodSprite.hide()
		elif dir == Vector2.RIGHT:
			$Node2D/FoodSprite.position.x = $Node2D.position.x + 80
			$Node2D/FoodSprite.show()
		elif dir == Vector2.LEFT:
			$Node2D/FoodSprite.position.x = $Node2D.position.x - 80
			$Node2D/FoodSprite.show()
	else:
		$Node2D/FoodSprite.hide()
		
	
	
func check_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		const str_start = "Click on \n"
		if collision.get_collider():
			if collision.get_collider().name=="TofuBox" and !if_carrying:
				Level.label_text = str_start + "tofu box to pick it up"
			elif collision.get_collider().name=="BambooChest" and !if_carrying:
				Level.label_text = str_start + "bamboo chest to pick up bamboo"
			elif collision.get_collider().name=="PastaBox" and !if_carrying:
				Level.label_text = str_start + "pasta box pick it up"
			elif collision.get_collider().name=="RiceBox" and !if_carrying:
				Level.label_text = str_start + "rice box pick it up"
			elif collision.get_collider().name=="TrashCan" and if_carrying:
				Level.label_text = str_start + "trash can to throw away"
			elif collision.get_collider().name=="Pot" and !if_carrying:
				Level.label_text = str_start + "pot pick it up"
			elif collision.get_collider().name=="PlateWithTortillas" and !if_carrying:
				Level.label_text = str_start + "tortilla plate to pick up a tortilla"
			elif collision.get_collider().name=="CountertopForOrders" and if_carrying:
				Level.label_text = str_start + "countertop to serve"
			elif collision.get_collider().name=="CuttingBoard" and if_carrying:
				Level.label_text = str_start + "cutting board to cut"
			elif collision.get_collider().name=="Oven" and if_carrying:
				Level.label_text = str_start + "oven to cook"
			
			collider_name = collision.get_collider().name

func action_on_click():
	if Input.is_action_just_released("mouse_button_left"):
		if !if_carrying:
			pick_up()
		else:
			put_down()
	
	

func pick_up():
	$Node2D/FoodSprite.choose_image(collider_name)
	if_carrying = true

func put_down():
	if_carrying = false
