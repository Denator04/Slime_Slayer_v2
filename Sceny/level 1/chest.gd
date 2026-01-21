extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var player_in_range = false
var opened = false

func _ready() -> void:
	sprite.play("Close")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

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
	print("Skrzynia otwarta")

func _process(_delta: float) -> void:
	if opened:
		return

	if player_in_range and Input.is_action_just_pressed("interact"):
		open_chest()
