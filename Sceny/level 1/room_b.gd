extends Node2D

func _ready():
	if Global.spawn_point_name != "" and has_node(Global.spawn_point_name):
		var marker = get_node(Global.spawn_point_name)
		$Player.global_position = marker.global_position
