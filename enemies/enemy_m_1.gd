extends CharacterBody2D

@onready var sprite = $Mytexture
@onready var ray_cast: RayCast2D = $RayCast2D
var player: Node2D


var is_dead: bool = false
var is_hit = false
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var knockbackDirection: Vector2 = Vector2.ZERO

###	STATYSTYKI	###
var dmg = 1
var hp = 100
var SPEED = 75.0

var direction = Vector2.ZERO


## ZMIENNE WIDZENIA ##
@export var ray_length: float = 200
@export var ray_count: int = 5
@export var between_rays_angle: float = 2.0
var rays: Array = []




func _ready():
	player = get_tree().get_first_node_in_group("player")
	sprite.play("idle")





func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		
	else:
		PlayerDetection()
		print("ok")
	
	#RayHandler()
	move_and_slide()


func dying():
	is_dead = true
	for i in 10:
		sprite.visible = false
		await get_tree().create_timer(0.4).timeout
		sprite.visible = true
		await get_tree().create_timer(0.4).timeout
		
		
func take_damage(amount: int, direction: Vector2) -> void:
	if is_dead or is_hit:
		return

	is_hit = true
	hp -= amount
	print("Enemy HP:", hp)

	apply_knockback(direction, 500, 0.05)

	if hp <= 0:
		dying()

	await get_tree().create_timer(0.1).timeout
	is_hit = false
 


func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(dmg,direction)
		
		
func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction.normalized() * force
	knockback_timer = knockback_duration
	SPEED = 0.0
	await get_tree().create_timer(0.5).timeout
	SPEED = 75.0

	
func PlayerDetection() -> void:
	if ray_cast.collides() && !player.is_dead:
		direction = Vector2.RIGHT.rotated(ray_cast.rotation)
		velocity = direction * SPEED
	else: velocity = Vector2.ZERO
	
