extends Sprite2D

var if_carried = false
var food_name = ""

func choose_image(given_name):
	if given_name == "TofuBox":
		texture = load("res://Assets/food/tofu.png")
	elif given_name == "PastaBox":
		texture = load("res://Assets/food/pasta.png")
	elif given_name =="BambooChest" :
		texture = load("res://Assets/food/bamboo.png")
	elif given_name =="RiceBox":
		texture = load("res://Assets/food/rice.png")
	elif given_name =="Pot":
		texture = load("res://Assets/kitchen/pot.png")
	elif given_name =="PlateWithTortillas":
		texture = load("res://Assets/food/tortilla.png")
