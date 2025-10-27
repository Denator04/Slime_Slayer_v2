extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var movement_speed: float = 500
@export var run_multiplier: float = 2
@export var flip_distance_multiplier: float = 1.2 

var character_direction: Vector2 = Vector2.ZERO
var is_flipping: bool = false

func _physics_process(delta):
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

		if sprite.animation != "rycerz_walk" and not is_flipping:
			sprite.play("rycerz_walk")
	else:
		velocity = Vector2.ZERO
		if sprite.animation != "rycerz_idle" and not is_flipping:
			sprite.play("rycerz_idle")

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

	# nadaj impuls
	velocity = dir * speed * flip_distance_multiplier
	move_and_slide()

	await sprite.animation_finished
	_on_flip_finished()

func _on_flip_finished() -> void:
	is_flipping = false

	if character_direction != Vector2.ZERO:
		sprite.play("rycerz_walk")
	else:
		sprite.play("rycerz_idle")
