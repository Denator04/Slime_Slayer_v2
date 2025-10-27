extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var movement_speed: float = 500
var character_direction: Vector2 = Vector2.ZERO



func _physics_process(delta):
	character_direction.x = Input.get_axis("ui_left", "ui_right")
	character_direction.y = Input.get_axis("ui_up", "ui_down")
	
	if Input.is_action_pressed("ui_left"): print("lewo")
	if Input.is_action_pressed("ui_right"): print("prawo")
	if Input.is_action_pressed("ui_up"): print("góra")
	if Input.is_action_pressed("ui_down"): print("dół")


	if character_direction != Vector2.ZERO:
		character_direction = character_direction.normalized()
		velocity = character_direction * movement_speed

		if sprite.animation != "rycerz_walk":
			sprite.animation = "rycerz_walk"

		if character_direction.x < 0:
			sprite.flip_h = true
		elif character_direction.x > 0:
			sprite.flip_h = false
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed * delta)
		if sprite.animation != "rycerz_idle":
			sprite.animation = "rycerz_idle"

	move_and_slide()
