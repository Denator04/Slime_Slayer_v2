extends Area2D

@export var target_scene: String
@export var target_spawn: String

func _on_body_entered(body: PhysicsBody2D) -> void:
	Global.spawn_point_name = target_spawn
	get_tree().change_scene_to_file(target_scene)
