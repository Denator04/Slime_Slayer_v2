extends Control

@onready var anim1: AnimatedSprite2D = $Lapa
@onready var anim2: AnimatedSprite2D = $Slime
@onready var audio: AudioStreamPlayer2D = $Audio

func _ready():
	anim1.play("start")
	anim2.play("start")

	# Czas trwania dłuższej animacji
	var fps1 = anim1.sprite_frames.get_animation_speed("start")
	var fps2 = anim2.sprite_frames.get_animation_speed("start")
	var frames1 = anim1.sprite_frames.get_frame_count("start")
	var frames2 = anim2.sprite_frames.get_frame_count("start")
	var longest = max(frames1/fps1, frames2/fps2)

	await get_tree().create_timer(longest).timeout

	# ---- NATYCHMIASTOWY CZARNY EKRAN ----
	var black = ColorRect.new()
	black.color = Color.BLACK
	black.size = get_viewport_rect().size
	black.anchor_left = 0
	black.anchor_top = 0
	black.anchor_right = 1
	black.anchor_bottom = 1
	black.modulate.a = 1      # od razu w pełni czarny
	black.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(black)

	# ---- ODTWORZENIE DŹWIĘKU ----
	audio.play()
	await audio.finished

	# ---- PRZEJŚCIE DO MENU ----
	get_tree().change_scene_to_file("res://Sceny/main_menu.tscn")
