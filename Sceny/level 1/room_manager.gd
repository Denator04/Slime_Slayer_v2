extends Node

var current_room: Node = null
var player: Node = null

func register_player(p):
	player = p

func change_room(new_room: Node, spawn_pos: Vector2):
	if current_room:
		current_room.exit_room()

	current_room = new_room
	current_room.enter_room(player, spawn_pos)
