extends CanvasLayer

var dialog = []
var index = 0
var active = false

@onready var panel = $Panel
@onready var portrait = $Panel/Portrait
@onready var text_label = $Panel/Text

func start_dialog(data: Array):
	dialog = data
	index = 0
	active = true
	panel.visible = true
	show_line()

func show_line():
	var line = dialog[index]
	portrait.texture = load(line["portrait"])
	text_label.text = line["text"]

func _input(event):
	if active and event.is_action_pressed("ui_accept"):
		index += 1
		if index >= dialog.size():
			end_dialog()
		else:
			show_line()

func end_dialog():
	panel.visible = false
	active = false
