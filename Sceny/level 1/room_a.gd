extends Node2D

func enter_room(player: Node, spawn_pos: Vector2):
	visible = true
	set_process(true)
	set_physics_process(true)

	add_child(player)
	player.global_position = spawn_pos

func exit_room():
	visible = false
	set_process(false)
	set_physics_process(false)
