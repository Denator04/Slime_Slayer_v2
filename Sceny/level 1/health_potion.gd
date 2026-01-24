extends Area2D

var player_in_range = false
var collected = false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Player.
