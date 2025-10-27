extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var movement_speed: float = 500
@export var run_multiplier: float = 2

var character_direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Pobranie kierunku ruchu
	character_direction.x = Input.get_axis("ui_left", "ui_right")
	character_direction.y = Input.get_axis("ui_up", "ui_down")

	# Normalizacja — zapobiega szybszemu ruchowi po przekątnej
	if character_direction != Vector2.ZERO:
		character_direction = character_direction.normalized()

		# Jeśli przytrzymany Shift – zwiększ prędkość
		var speed = movement_speed
		if Input.is_action_pressed("ui_shift"):  # dodamy tę akcję w InputMap
			speed *= run_multiplier

		velocity = character_direction * speed

		# Animacje i obrót sprite’a
		if sprite.animation != "rycerz_walk":
			sprite.animation = "rycerz_walk"

		if character_direction.x < 0:
			sprite.flip_h = true
		elif character_direction.x > 0:
			sprite.flip_h = false
	else:
		# Zatrzymanie natychmiast po puszczeniu klawiszy
		velocity = Vector2.ZERO
		if sprite.animation != "rycerz_idle":
			sprite.animation = "rycerz_idle"

	move_and_slide()
