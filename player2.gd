extends CharacterBody2D

class_name Player

var is_dead = false
var is_hit = false

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var speed_buff_active := false

# 		Statystyki		##########
var SPEED = 200.0
var dmg = 5
var sprint = 1
var hp = 5

@onready var sprite = $visualOffset/PlayerSprite
@onready var anPlayer = $AnimationPlayer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var weapon_hitbox = $weaponHitbox
var last_hit_enemy: CharacterBody2D = null



var direction :Vector2 = Vector2.ZERO
var last_direction = Vector2.ZERO


func _ready():
	animation_tree.active = true
	weapon_hitbox.monitoring = false


func _process(delta):
	updateAnimationParameters()

func _physics_process(delta):
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
	else:
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
		if direction != Vector2.ZERO:
			last_direction = direction

		if Input.is_action_pressed("ui_shift"):
			sprint = 1.5
		else:
			sprint = 1

		if direction != Vector2.ZERO:
			velocity = direction.normalized() * SPEED * sprint
		else:
			velocity = Vector2.ZERO

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
		body.take_damage(dmg,last_direction)
		
		
func take_damage(amount: int, enemy_direction: Vector2) -> void:
	if is_dead or is_hit == true:
		return
	is_hit = true
	hp -= amount
	print("MY HP:", hp)
	apply_knockback(enemy_direction, 500, 0.1)
		
	if hp <= 0:
		dying()
			
	await get_tree().create_timer(0.1).timeout
	is_hit = false

		
func dying():
	is_dead = true
	animation_tree.active = false
	SPEED = 0
	anPlayer.play("death")
	await anPlayer.animation_finished
	sprite.visible = false
	get_tree().change_scene_to_file("res://Sceny/death_screne.tscn");
	

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction.normalized() * force
	knockback_timer = knockback_duration
	
