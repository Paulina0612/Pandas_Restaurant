extends Node2D
class_name Level

static var label_text = ""
	
func _process(_delta: float) -> void:
	$Label.text = label_text
