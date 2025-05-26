extends Node2D


func _on_fail_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Fail.tscn")


func _on_success_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Success.tscn")
