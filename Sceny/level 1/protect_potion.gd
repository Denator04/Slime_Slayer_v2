extends Area2D

var armor_amount = 1;

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.armor += armor_amount
		print("Dodano 1 punkt pancerza: ", body.armor)
		queue_free()
