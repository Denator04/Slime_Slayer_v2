extends CharacterBody2D

const SPEED = 200.0

@onready var sprite = $visualOffset/PlayerSprite
@onready var animation_tree : AnimationTree = $AnimationTree

var direction :Vector2 = Vector2.ZERO
var last_direction = Vector2.ZERO

func _ready():
	animation_tree.active = true
	

func _process(delta):
	updateAnimationParameters()

func _physics_process(delta: float) -> void:
	var sprite_offset_y := Vector2(0, 0) # daj wartość np. Vector2(0, -8) jeśli trzeba
	#sprite.global_position = global_position + sprite_offset_y
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		velocity = direction * SPEED
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
