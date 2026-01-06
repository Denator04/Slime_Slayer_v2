extends CharacterBody2D

@onready var sprite = $Mytexture

var is_dead: bool = false
var is_hit = false

###	STATYSTYKI	###
var dmg = 1
var hp = 10
const SPEED = 300.0


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
		dying()  


func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(dmg)

#func _on_hitbox_area_body_exited(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#body.stop_dmg()	
