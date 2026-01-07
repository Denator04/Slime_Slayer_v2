extends Control

@onready var portrait = get_node_or_null("HBoxContainer/PortraitPanel/Portrait")
@onready var dialog_text = get_node_or_null("HBoxContainer/TextPanel/Label")

var portraits = {
	"npc": preload("res://Assets/Portraits/dialog_NPC.png"),
	"player": preload("res://Assets/Portraits/dialog_MC.png"),
	"NPC": preload("res://Assets/Portraits/dialog_NPC.png"),
	"Player": preload("res://Assets/Portraits/dialog_MC.png")
}

var balloon = null
var last_line = null


func start_dialogue(path: String, start_node: String) -> void:
	visible = true

	var dialogue_res = load(path)
	balloon = DialogueManager.show_dialogue_balloon(dialogue_res, start_node)

	_update_from_balloon_line()

	if balloon != null:
		balloon.tree_exited.connect(_on_dialogue_ended)


func _process(_delta) -> void:
	if balloon == null:
		return

	var line = balloon.get("dialogue_line")
	if line == null:
		return

	if line != last_line:
		last_line = line
		_update_from_balloon_line()


func _update_from_balloon_line() -> void:
	if balloon == null:
		return
	if portrait == null:
		push_error("Portrait node not found — sprawdź ścieżkę HBoxContainer/PortraitPanel/Portrait")
		return
	if dialog_text == null:
		return

	var line = balloon.get("dialogue_line")
	if line == null:
		return

	var speaker := str(line.get("character"))
	var text := str(line.get("text"))

	print("SPEAKER =", speaker)

	if portraits.has(speaker):
		portrait.texture = portraits[speaker]
		portrait.visible = true
	else:
		print("⚠ brak portretu dla:", speaker)
		portrait.visible = false

	dialog_text.text = text


func _on_dialogue_ended() -> void:
	visible = false
	balloon = null
	last_line = null
