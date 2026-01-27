extends Control

@onready var portrait = $Portrait
@onready var label = $DialoguePanel/DialogueLabel

var portraits = {
	"npc": preload("res://Assets/Portraits/dialog_NPC.png"),
	"player": preload("res://Assets/Portraits/dialog_MC.png")
}

var balloon = null
var last_line = null


func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	


func start_dialogue(path: String, start_node: String) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	visible = true

	var dialogue_res = load(path)
	balloon = DialogueManager.show_dialogue_balloon(dialogue_res, start_node)

	_update_line()

	if balloon != null:
		balloon.tree_exited.connect(_on_dialogue_end)


func _process(_delta: float) -> void:
	if balloon == null:
		return

	var line = balloon.get("dialogue_line")
	if line == null:
		return

	if line != last_line:
		last_line = line
		_update_line()


func _update_line() -> void:
	if balloon == null:
		return

	var line = balloon.get("dialogue_line")
	if line == null:
		return

	var speaker := str(line.character)
	var text := str(line.text)

	if portraits.has(speaker):
		portrait.texture = portraits[speaker]
		portrait.visible = true
	else:
		portrait.visible = false

	label.text = text


func _go_to_shop():
	get_tree().change_scene_to_file("res://Sceny/Shop.tscn")

func _on_dialogue_end() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	balloon = null
	last_line = null

	get_tree().call_group("NPC", "dialogue_finished")
