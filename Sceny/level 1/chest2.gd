extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_potion = $Health_Potion
@onready var protect_potion = $Protect_Potion

var player_in_range = false
var opened = false

func _ready() -> void:
	sprite.play("Close")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if has_node("Health_Potion"):
		var hp_potion := $Health_Potion
		hp_potion.hide()
		hp_potion.monitoring = false
		hp_potion.monitorable = false
		hp_potion.get_node("CollisionShape2D").disabled = true

	if has_node("Protect_Potion"):
		var protect_potion := $Protect_Potion
		protect_potion.hide()
		protect_potion.monitoring = false
		protect_potion.monitorable = false
		protect_potion.get_node("CollisionShape2D").disabled = true

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = true
		print("Gracz w zasięgu skrzyni")

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = false
		print("Gracz wyszedł z zasięgu")

func open_chest() -> void:
	opened = true
	sprite.play("Open")
	$CollisionShape2D.disabled = true
	
	$Health_Potion.show()
	$Health_Potion.monitoring = true
	$Health_Potion.monitorable = true
	$Health_Potion.get_node("CollisionShape2D").disabled = false

	$Protect_Potion.show()
	$Protect_Potion.monitoring = true
	$Protect_Potion.monitorable = true
	$Protect_Potion.get_node("CollisionShape2D").disabled = false

func _process(_delta: float) -> void:
	if opened:
		return

	if player_in_range and Input.is_action_just_pressed("interact"):
		open_chest()
