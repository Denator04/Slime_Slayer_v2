extends Node2D


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceny/level 1/level_1.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceny/options.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_login_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceny/login_menu.tscn")
