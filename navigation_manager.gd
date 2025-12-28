extends Node

const scene_roomA = preload("res://Sceny/level 1/level_1.tscn")
const scene_roomB = preload("res://Sceny/level 1/RoomB.tscn")

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"roomA":
			scene_to_load = scene_roomA
		"roomB":
			scene_to_load = scene_roomB
		
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
