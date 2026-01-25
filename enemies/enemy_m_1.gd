extends CharacterBody2D

@onready var sprite = $Mytexture
@onready var ray_cast: RayCast2D = $RayCast2D
var player: Node2D


var is_dead: bool = false
var is_hit = false
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var knockbackDirection: Vector2 = Vector2.ZERO

var t1_reached := false
var startingPosition: Vector2
var patrolTarget: Vector2
var patrolDirection: Vector2
var wasDetected:= false

###	STATYSTYKI	###
var dmg = 1
var hp = 5
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
	startingPosition = global_position
	patrolTarget = startingPosition + Vector2(300,0)
	patrolDirection = (patrolTarget - startingPosition).normalized()





func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		
	else:
		PlayerDetection()
		#print(global_position)
	
	#RayHandler()
	move_and_slide()


func dying():
	is_dead = true
	sprite.play("death")
	await sprite.animation_finished
	queue_free()
		
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
	if(is_dead):
		velocity = Vector2.ZERO
	elif ray_cast.collides() && !player.is_dead:
		direction = Vector2.RIGHT.rotated(ray_cast.rotation)
		velocity = direction * SPEED
		wasDetected = true
	elif(wasDetected):
		direction = (startingPosition - global_position).normalized()
		velocity = direction * SPEED
		if(global_position.distance_to(startingPosition) <= 5):
			Patrol(patrolTarget)
			wasDetected = false
	else:
		Patrol(patrolTarget) 
	if(player.is_dead):
		velocity = Vector2.ZERO
		
	
	
func Patrol(target: Vector2) -> void:
	if(!t1_reached):
		velocity = patrolDirection * SPEED
	else:
		velocity = -patrolDirection * SPEED
	if(global_position.distance_to(target) <= 5):
		t1_reached = true
	elif(global_position.distance_to(startingPosition) <= 5):
		t1_reached = false
	
#func fire()
