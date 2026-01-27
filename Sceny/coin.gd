extends Area2D

@onready var coin = $Coin
var player_in_range = false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_range = true

func _process(_delta: float) -> void:
	if player_in_range:
		Global.money += 1
		coin.hide()
		coin.monitoring = false
		coin.monitorable = false
		coin.get_node("CollisionShape2D").disabled = true
