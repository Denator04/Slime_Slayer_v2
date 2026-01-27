extends Node2D

@onready var player = $Player
@onready var buttons = $"Button Manager"

func buy_item(price: int, button_name: String, price_label: Node, coin_icon: Node, apply_effect: Callable):
	if Global.money >= price:
		Global.money -= price
		apply_effect.call()

		buttons.get_node(button_name).hide()
		price_label.hide()
		coin_icon.hide()
	else:
		print("Za mało pieniędzy")

func _on_golden_axe_pressed() -> void:
	buy_item(
		10,
		"Golden Axe",
		$Axe_Price,
		$Coin,
		func(): Global.dmg += 5
	)
	print("Zwiększono obrażenia o 5")

func _on_boots_pressed() -> void:
	buy_item(
		15,
		"Boots",
		$Boots_Price,
		$Coin2,
		func(): Global.SPEED += 100
	)
	print("Zwiększono prędkość o 100")

func _on_health_potion_pressed() -> void:
	buy_item(
		15,
		"Health_Potion",
		$Health_Potion_Price,
		$Coin3,
		func(): Global.hp += 5
	)
	print("Zwiększono żywotność o 5")

func _on_armor_potion_pressed() -> void:
	buy_item(
		15,
		"Armor_Potion",
		$Armor_Potion_Price,
		$Coin4,
		func(): Global.armor += 3
	)
	print("Dodano 3 punkty pancerza")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceny/level 1/Room3.tscn")
