extends Area2D

@export var target_room: Node
@export var spawn_position: Vector2

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		get_tree().current_scene.get_node("RoomManager").change_room(target_room, spawn_position)
