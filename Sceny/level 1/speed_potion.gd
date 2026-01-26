extends Area2D

@export var speed_bonus := 50
@export var duration := 5.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if body.speed_buff_active:
		return

	body.speed_buff_active = true
	Global.SPEED += speed_bonus
	print("Speed zwiększony:", Global.SPEED)

	queue_free()

	await get_tree().create_timer(duration).timeout

	Global.SPEED -= speed_bonus
	body.speed_buff_active = false
	print("Speed wrócił do normy:", Global.SPEED)
