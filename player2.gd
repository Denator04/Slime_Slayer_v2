extends CharacterBody2D
class_name Player

var is_dead = false
var is_hit = false

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var speed_buff_active := false

# ===== STATYSTYKI =====
var SPEED = Global.SPEED
var dmg = Global.dmg
var sprint = 1
var max_hp = 5
var hp = Global.hp
var armor = Global.armor
var money = Global.money

@export var portrait_texture: Texture2D
@export var weapon_icon: Texture2D

@onready var sprite = $visualOffset/PlayerSprite
@onready var anPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var weapon_hitbox = $weaponHitbox

var last_hit_enemy: CharacterBody2D = null
var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO


func _ready():
	animation_tree.active = true
	weapon_hitbox.monitoring = false
	weapon_hitbox.monitorable = false
	disable_weapon()

	# ⏳ poczekaj 1 klatkę aż HUD się załaduje (AutoLoad)
	await get_tree().process_frame

	## ===== INIT HUD =====
	#HUD.set_health(hp, max_hp)
	#HUD.set_armor(armor, max_armor)
	#HUD.set_portrait(portrait_texture)
	#HUD.set_weapon_icon(weapon_icon)


func _process(delta):
	updateAnimationParameters()


func _physics_process(delta):
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
	else:
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

		if direction != Vector2.ZERO:
			last_direction = direction

		sprint = 1.5 if Input.is_action_pressed("ui_shift") else 1.0

		if direction != Vector2.ZERO:
			velocity = direction.normalized() * SPEED * sprint
		else:
			velocity = Vector2.ZERO

	move_and_slide()


# ===== ANIMATION TREE =====
func updateAnimationParameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true

	animation_tree["parameters/conditions/swing"] = Input.is_action_just_pressed("ui_c")

	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
		animation_tree["parameters/attack/blend_position"] = direction

		sprite.flip_h = direction.x < 0


# ===== WALKA =====
func _on_weapon_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(dmg, last_direction)


func take_damage(amount: int, enemy_direction: Vector2) -> void:
	if is_dead or is_hit:
		return

	is_hit = true

	if armor > 0:
		armor -= 1
		#HUD.set_armor(armor, max_armor)
	else:
		hp -= amount
		hp = max(hp, 0)
		#HUD.set_health(hp, max_hp)

	print("MY HP:", hp)

	apply_knockback(enemy_direction, 500, 0.1)

	if hp <= 0:
		dying()

	await get_tree().create_timer(0.1).timeout
	is_hit = false


func dying():
	is_dead = true
	animation_tree.active = false
	SPEED = 0

	anPlayer.play("death")
	await anPlayer.animation_finished

	queue_free()
	get_tree().change_scene_to_file("res://Sceny/death_screne.tscn")


func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction.normalized() * force
	knockback_timer = knockback_duration

func get_last_direction() -> Vector2:
	return last_direction
	
func get_dmg() -> int:
	return dmg

func enable_weapon():
	weapon_hitbox.monitoring = true
	weapon_hitbox.monitorable = true
	weapon_hitbox.get_node("hitbox").disabled = false

func disable_weapon():
	weapon_hitbox.monitoring = false
	weapon_hitbox.monitorable = false
	weapon_hitbox.get_node("hitbox").disabled = true
