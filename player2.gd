extends CharacterBody2D

class_name Player

var is_dead = false
var is_hit = false

# 		Statystyki		##########
var SPEED = 200.0
var dmg = 5
var sprint = 1
var hp = 5

@onready var sprite = $visualOffset/PlayerSprite
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var weapon_hitbox = $weaponHitbox



var direction :Vector2 = Vector2.ZERO
var last_direction = Vector2.ZERO


func _ready():
	animation_tree.active = true
	weapon_hitbox.monitoring = false


func _process(delta):
	updateAnimationParameters()

func _physics_process(delta: float) -> void:
	var sprite_offset_y := Vector2(0, 0) # daj wartość np. Vector2(0, -8) jeśli trzeba
	#sprite.global_position = global_position + sprite_offset_y
	
	if Input.is_action_pressed("ui_shift"):
		sprint = 1.5
	else: sprint = 1
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		velocity = direction * SPEED * sprint
	else:
		velocity = Vector2.ZERO

	direction = direction.normalized()

	move_and_slide()
	
	
	
	
	
	####	ANIMACJE Z ANIMATION TREE ###
func updateAnimationParameters():
	
	if (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true
		
	if (Input.is_action_just_pressed("ui_c")):
		animation_tree["parameters/conditions/swing"] = true
	else:
		animation_tree["parameters/conditions/swing"] = false
	
	if(direction != Vector2.ZERO):	
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
		animation_tree["parameters/attack/blend_position"] = direction
		
		if(direction.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false


func _on_weapon_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(dmg)
		
		
func take_damage(amount: int) -> void:
	if is_dead or is_hit == true:
		return
	is_hit = true
	hp -= amount
	print("MY HP:", hp)
	await get_tree().create_timer(0.5).timeout
	is_hit = false
	
	if hp <= 0:
		dying()
		
		
func dying():
	is_dead = false
	for n in 5:
		sprite.visible = false
		await get_tree().create_timer(0.4).timeout
		sprite.visible = true
		await get_tree().create_timer(0.4).timeout
