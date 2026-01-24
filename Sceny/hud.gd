extends CanvasLayer

@onready var health_bar: ProgressBar = $Panel/HBoxContainer/VBoxContainer/HealthBar
@onready var armor_bar: ProgressBar = $Panel/HBoxContainer/VBoxContainer/ArmorBar
@onready var portrait: TextureRect = $Panel/HBoxContainer/Portrait
@onready var weapon_icon: TextureRect = $Panel/HBoxContainer/WeaponIcon

func set_health(current: int, max_value: int) -> void:
	health_bar.max_value = max_value
	health_bar.value = current

func set_armor(current: int, max_value: int) -> void:
	armor_bar.max_value = max_value
	armor_bar.value = current

func set_portrait(texture: Texture2D) -> void:
	portrait.texture = texture

func set_weapon_icon(texture: Texture2D) -> void:
	weapon_icon.texture = texture
