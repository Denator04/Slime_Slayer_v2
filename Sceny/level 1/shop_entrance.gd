extends Area2D

var player_in_range = false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = true
		print("Gracz w zasięgu")

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = false
		print("Gracz wyszedł z zasięgu")
	
func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://Sceny/shop.tscn")
