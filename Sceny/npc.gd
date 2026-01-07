extends Node2D

var player_in_range := false


func _ready() -> void:
	$InteractArea.body_entered.connect(_on_body_entered)
	$InteractArea.body_exited.connect(_on_body_exited)


func _on_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		print("PLAYER wszedł w zasięg")


func _on_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		print("PLAYER wyszedł z zasięgu")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		print("E wciśnięte, player_in_range =", player_in_range)

		if player_in_range:
			print("ODPALAM DIALOG")
			Dialogue.start_dialogue(
				"res://Dialogues/dialogue1.dialogue",
                "start"
			)
