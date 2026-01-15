extends Area2D

@export var target_scene: String
@export var spawn_point: String

var used := false   

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if used:
		return

	if body.name == "Player":
		used = true

		if target_scene == "":
			push_error("Door: target_scene is empty!")
			return

		Global.change_scene(target_scene, spawn_point)
