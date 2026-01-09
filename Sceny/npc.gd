extends Node2D

var player_in_range := false
var dialogue_active := false


func _ready() -> void:
	$InteractArea.body_entered.connect(_on_body_entered)
	$InteractArea.body_exited.connect(_on_body_exited)


func _on_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player_in_range = true


func _on_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player_in_range = false


func _process(_delta: float) -> void:
	if dialogue_active:
		return

	if Input.is_action_just_pressed("interact") and player_in_range:
		dialogue_active = true

		Dialogue.start_dialogue(
			"res://Dialogues/dialogue1.dialogue",
			"start"
		)


# 👉 wywoływane z Dialogue (autoload) po zakończeniu dialogu
func dialogue_finished() -> void:
	dialogue_active = false
