extends CharacterBody2D

@export var movement_speed : float = 500
var character_direction : Vector2

func _phisics_process(delta):
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.x = Input.get_axis("move_up", "move_down")
	
	if character_direction:
		velocity = character_direction * movement_speed
		if %sprite.animation != "rycerz_walk": %sprite.animation = "rycerz_walk"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %sprite.animation != "rycerz_idle": %sprite.animation = "Idle"

	move_and_slide()
