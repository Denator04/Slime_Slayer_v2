extends Node

var spawn_point_name: String = ""
var next_scene_path: String = ""
var spawn_point_place: String = ""

var SPEED = 200.0
var dmg = 5
var hp := 5
var armor := 0
var money = 20


func change_scene(path: String, spawn_point := "") -> void:
	if not ResourceLoader.exists(path):
		push_error("Scena nie istnieje: " + path)
		return

	next_scene_path = path
	spawn_point_name = spawn_point

	call_deferred("_do_change_scene")


func _do_change_scene() -> void:
	var err := get_tree().change_scene_to_file(next_scene_path)
	if err != OK:
		push_error("Nie udało się zmienić sceny: " + next_scene_path)
