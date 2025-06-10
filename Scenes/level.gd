extends Node2D
class_name Level

static var label_text = ""


func _on_fail_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Fail.tscn")


func _on_success_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Success.tscn")
	
	
func _process(_delta: float) -> void:
	$Label.text = label_text
