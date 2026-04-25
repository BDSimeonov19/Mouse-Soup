extends Node

var items_collected := []

func item_collected(tag: String) -> void:
	items_collected.append(tag)
	get_node("/root/Main").save_data["items_collected"] = items_collected
	print(items_collected)
