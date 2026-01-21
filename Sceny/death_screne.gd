extends Node2D

func _on_exit_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceny/main_menu.tscn");

func _on_back_to_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceny/level 1/level_1.tscn");
