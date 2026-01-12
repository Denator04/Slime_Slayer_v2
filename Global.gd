extends Node
# Autoload: Global

var spawn_point_name: String = ""
var next_scene_path: String = ""


func change_scene(path: String, spawn_point := "") -> void:
	if not ResourceLoader.exists(path):
		push_error("Scena nie istnieje: " + path)
		return

	next_scene_path = path
	spawn_point_name = spawn_point

	# Zmiana sceny bezpiecznie po tej klatce
	call_deferred("_do_change_scene")


func _do_change_scene() -> void:
	var err := get_tree().change_scene_to_file(next_scene_path)
	if err != OK:
		push_error("Nie udało się zmienić sceny: " + next_scene_path)
