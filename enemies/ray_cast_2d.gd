extends RayCast2D

var player: Node2D
var player_marker: Marker2D

@onready var enemy: CharacterBody2D = get_parent() as CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player_marker = player.get_node("Marker2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	collides()
	RayHandle()
	
	
	
func collides() ->bool:
	force_raycast_update()
	
	if is_colliding():
		return true
	return false


func RayHandle() -> void:
	global_position = enemy.global_position
	var player_global = player_marker.global_position
	
	# look_at wymaga globalnej pozycji
	look_at(player_global)
	
