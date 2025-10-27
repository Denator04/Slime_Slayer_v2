extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	
	move_and_slide()
