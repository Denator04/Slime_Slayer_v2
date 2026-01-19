extends CharacterBody2D

@onready var sprite = $Mytexture

var is_dead: bool = false
var is_hit = false
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var knockbackDirection: Vector2 = Vector2.ZERO

###	STATYSTYKI	###
var dmg = 1
var hp = 100
const SPEED = 300.0


func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()


func dying():
	is_dead = true
	for i in 10:
		sprite.visible = false
		await get_tree().create_timer(0.4).timeout
		sprite.visible = true
		await get_tree().create_timer(0.4).timeout
		
func take_damage(amount: int, direction: Vector2) -> void:
	if is_dead or is_hit:
		return

	is_hit = true
	hp -= amount
	print("Enemy HP:", hp)

	apply_knockback(direction, 350, 0.05)

	if hp <= 0:
		dying()

	await get_tree().create_timer(0.1).timeout
	is_hit = false
 


func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(dmg)
		
		
func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction.normalized() * force
	knockback_timer = knockback_duration
	
