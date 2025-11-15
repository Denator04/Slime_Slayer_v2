extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var movement_speed: float = 500
@export var run_multiplier: float = 2
@export var flip_distance_multiplier: float = 1.2 

var character_direction: Vector2 = Vector2.ZERO
var is_flipping: bool = false
var player_chosen = 1

var idle_an
var walk_animation: String

func player_walk(a, b, c, d):
	if character_direction.x > 0:
		walk_animation = a
	elif character_direction.x < 0:
		walk_animation = b
	elif character_direction.y > 0:
		walk_animation = c
	elif character_direction.y < 0:
		walk_animation = d

func player_stats() -> void:
	if player_chosen == 1:
		idle_an = "rycerz_idle_B"
		player_walk("walk_side_B", "walk_side_B", "walk_front_B", "walk_back_B")
		
		
func _ready():
	player_stats()
	

func _physics_process(delta):
	player_stats()
	
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
			sprite.play(walk_animation)
	else:
		velocity = Vector2.ZERO
		if sprite.animation != idle_an and not is_flipping and character_direction == Vector2.ZERO:
			sprite.play(idle_an)

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
	else:
		sprite.play(idle_an)
