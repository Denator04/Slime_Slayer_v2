extends Area2D

@export var heal_amount := 2

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.hp += heal_amount
		print("HP zwiększone do: ", body.hp)
		queue_free()
