extends Node2D

func _ready():
	print("=== SCENE STRUCTURE ===")
	print_all_nodes(self, 0)

func print_all_nodes(node: Node, indent: int):
	var indent_str = "  ".repeat(indent)
	print(indent_str + node.name + " (" + node.get_class() + ")")
	
	if node.has_method("get_z_index"):
		print(indent_str + "  Z-index: " + str(node.get_z_index()))
	if node.has_method("is_y_sort_enabled"):
		print(indent_str + "  Y-sort: " + str(node.is_y_sort_enabled()))
	
	for child in node.get_children():
		print_all_nodes(child, indent + 1)
