extends RayCast2D

var player: Node2D

@onready var enemy: CharacterBody2D = get_parent() as CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	collides()
	RayHandle()
	
	
	
func collides() ->void:
	if is_colliding():
		print("colliduje")

func RayHandle() -> void:
	var playerDirection = player.global_position
	var wektor = playerDirection - enemy.global_position
	var angle_rad = atan2(wektor.x, wektor.y)
	var angle_deg = rad_to_deg(angle_rad)
	var angle = angle_deg/100 

	rotation = angle
