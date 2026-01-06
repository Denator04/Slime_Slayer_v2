extends CharacterBody2D

@onready var sprite = $Mytexture

const SPEED = 300.0
var hp = 10
var is_dead: bool = false
var is_hit = false



func _physics_process(delta: float) -> void:
		

	move_and_slide()


func dying():
	is_dead = true
	for i in 10:
		sprite.visible = false
		await get_tree().create_timer(0.4).timeout
		sprite.visible = true
		await get_tree().create_timer(0.4).timeout
		
func take_damage(amount: int) -> void:
	if is_dead and is_hit == true:
		return  # already dying, ignore further damage
	is_hit = true
	hp -= amount
	print("Enemy HP:", hp)

	if hp <= 0:
		dying()  # trigger death/blink effect
