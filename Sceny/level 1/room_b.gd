extends Node2D

@export var is_start_room := false

func _ready() -> void:
	if is_start_room:
		_activate()
	else:
		_deactivate()

func enter_room(player: Node, spawn_pos: Vector2) -> void:
	_activate()
	add_child(player)
	player.global_position = spawn_pos

func exit_room() -> void:
	_deactivate()

# ------------------------

func _activate() -> void:
	visible = true
	_set_tilemaps_collision(true)
	_set_areas_enabled(true)

func _deactivate() -> void:
	visible = false
	_set_tilemaps_collision(false)
	_set_areas_enabled(false)

func _set_tilemaps_collision(enabled: bool) -> void:
	for tm in find_children("*", "TileMap", true):
		tm.collision_enabled = enabled

func _set_areas_enabled(enabled: bool) -> void:
	for area in find_children("*", "Area2D", true):
		area.monitoring = enabled
		area.monitorable = enabled
