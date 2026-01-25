extends CharacterBody2D

@onready var sprite = $Mytexture
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var bulletPos = $bulletPos
var bullet_path = preload("res://enemies/bullet.tscn")
var player: Node2D


var is_dead: bool = false
var is_hit = false
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var knockbackDirection: Vector2 = Vector2.ZERO
var can_shoot:= true

var t1_reached := false
var startingPosition: Vector2
var patrolTarget: Vector2
var patrolDirection: Vector2
var wasDetected:= false

###	STATYSTYKI	###
var dmg = 1
var hp = 100
var SPEED = 60.0

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
		if(Input.is_action_just_pressed("ui_c")):
			shoot()
		
		PlayerDetection()
		
		#print(global_position)
	
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
	if(global_position.distance_to(player.global_position) <= 175):
		shoot()
		sprite.play("shoot")
		velocity = Vector2.ZERO
	elif ray_cast.collides() && !player.is_dead:
		sprite.play("idle")
		direction = Vector2.RIGHT.rotated(ray_cast.rotation)
		velocity = direction * SPEED
		wasDetected = true
	elif(wasDetected):
		sprite.play("idle")
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
	if(global_position.distance_to(target) <= 50.66):
		t1_reached = true
	elif(global_position.distance_to(startingPosition) <= 5):
		t1_reached = false
	
	
func shoot() -> void:
	await get_tree().create_timer(1).timeout
	if(can_shoot):
		can_shoot = false
		var bullet = bullet_path.instantiate()
		bullet.dir=ray_cast.rotation
		bullet.pos = bulletPos.global_position
		bullet.rota = global_rotation
		get_parent().add_child(bullet)
		await get_tree().create_timer(2).timeout
		can_shoot = true
