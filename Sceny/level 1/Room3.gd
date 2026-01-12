extends Node2D

func _ready():
	if Global.spawn_point_name == "":
		Global.spawn_point_name = "default"

	if has_node(Global.spawn_point_name):
		$Player.global_position = get_node(Global.spawn_point_name).global_position
