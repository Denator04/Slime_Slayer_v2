extends Node

var current_room: Node = null
var player: Node = null

func register_player(p):
	player = p
	
	for room in get_parent().get_node("Rooms").get_children():
		if room.is_start_room:
			current_room = room

func change_room(new_room: Node, spawn_pos: Vector2):
	if current_room:
		current_room.exit_room()

	current_room = new_room
	current_room.enter_room(player, spawn_pos)
