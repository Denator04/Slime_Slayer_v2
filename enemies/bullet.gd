extends CharacterBody2D

@onready var collisionShape = $CollisionShape2D
var player: Node2D
var enemy: Node2D

var pos:Vector2
var rota: float
var dir: float
var speed = 300
var dmg = 1


func _ready():
	enemy = get_parent()
	player = get_tree().get_first_node_in_group("player")
	global_position = pos
	global_rotation = rota
	
func _physics_process(delta):
	velocity = Vector2.RIGHT.rotated(dir) * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Trafiono:", collision.get_collider().name)
		if(collision.get_collider().is_in_group("player")):
			print((player.global_position - enemy.global_position).normalized())
			player.take_damage(dmg, Vector2.RIGHT.rotated(dir))
		queue_free()
	
