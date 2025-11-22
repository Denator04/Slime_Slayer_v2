extends CharacterBody2D

@onready var sprite = $spriteOffset/visualOffset/AnimatedSprite2D
@onready var sprite_offset = $spriteOffset 
@onready var animation = $spriteOffset/AnimationPlayer

@export var movement_speed: float = 500
@export var run_multiplier: float = 2
@export var flip_distance_multiplier: float = 1.2 


var character_direction: Vector2 = Vector2.ZERO
var is_flipping: bool = false
var player_chosen = 1
var direction = 0

var is_attacking
var moveOnAttack: Vector2 = Vector2.ZERO


var attack_an
var idle_an
var walk_animation: String


#		*****	This defines direction mc goes towards	*****
func player_walk(a, b, c, d):
	if character_direction.x > 0:
		walk_animation = a
		direction = 3
	elif character_direction.x < 0:
		walk_animation = b
		direction = 1
	elif character_direction.y > 0:
		walk_animation = c
		direction = 2
	elif character_direction.y < 0:
		walk_animation = d
		direction = 0
		
		
# 		******		direction variable related	 	*******
func direction_depend():
	if(direction == 0):
		idle_an = "rycerz_idle_back_B"
		attack_an = "attack_up_B"
		moveOnAttack = Vector2(0, 20)
	elif(direction == 1):
		idle_an = "rycerz_idle_side_B"
		attack_an = "attack_side_B"
		moveOnAttack = Vector2(20, 0)
	elif (direction == 2):
		idle_an = "rycerz_idle_front_B"
		attack_an = "attack_down_B"
		moveOnAttack = Vector2(0, -20)
	elif(direction == 3):
		idle_an = "rycerz_idle_side_B"
		attack_an = "attack_side_B"
		moveOnAttack = Vector2(-20, 0)


#		*****	This defines animations depending on which character was chosen		*****
func player_stats() -> void:
	if player_chosen == 1:
		idle_an = "rycerz_idle_front_B"
		
#	**************		ATTACK function		***************
#	**************							***************
func attack() -> void:
	if is_attacking:
		return  # prevent double attack

	is_attacking = true
	animation.play("attack_side")
	await animation.animation_finished
	is_attacking = false

		
func _ready():
	sprite.z_index = 10 
	player_stats()
	

func _physics_process(delta):

	direction_depend()
	
	if is_attacking:
		return
	
	if is_flipping:
		move_and_slide()
		return
	
	

	character_direction.x = Input.get_axis("ui_left", "ui_right")
	character_direction.y = Input.get_axis("ui_up", "ui_down")

	if character_direction != Vector2.ZERO:
		character_direction = character_direction.normalized()

		var speed = movement_speed
		if Input.is_action_pressed("ui_shift"):
			speed *= run_multiplier

		velocity = character_direction * speed

		if character_direction.x < 0:
			sprite.flip_h = true
		elif character_direction.x > 0:
			sprite.flip_h = false
			
			
		if !is_flipping and character_direction != Vector2.ZERO:
			player_walk("walk_side_B", "walk_side_B", "walk_front_B", "walk_back_B")
			sprite.play(walk_animation)
			
	else:
		velocity = Vector2.ZERO
		if sprite.animation != idle_an and not is_flipping and character_direction == Vector2.ZERO:
			sprite.play(idle_an)
			
	#	*****	Here is attack handled		*****
	if Input.is_action_just_pressed("ui_c") and !is_attacking:
		attack()
		#sprite_offset.position.x +=200;

	if Input.is_action_just_pressed("ui_space") and not is_flipping:
		start_flip()

	move_and_slide()


func start_flip() -> void:
	is_flipping = true
	sprite.play("rycerz_flip")

	
	var speed = movement_speed
	if Input.is_action_pressed("ui_shift"):
		speed *= run_multiplier 

	var dir = Vector2.LEFT if sprite.flip_h else Vector2.RIGHT

	velocity = dir * speed * flip_distance_multiplier
	move_and_slide()

	await sprite.animation_finished
	_on_flip_finished()

func _on_flip_finished() -> void:
	is_flipping = false

	if character_direction != Vector2.ZERO:
		sprite.play(walk_animation)
