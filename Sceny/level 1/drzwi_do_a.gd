extends Area2D

var entered = false;

func _on_body_entered(body: PhysicsBody2D) -> void:
	entered = true
	
func _on_body_exited(body: PhysicsBody2D) -> void:
	entered = false

func _process(delta):
	if entered == true:
		get_tree().change_scene_to_file("res://Sceny/level 1/level_1.tscn")
		
