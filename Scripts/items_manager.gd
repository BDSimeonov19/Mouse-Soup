extends Node

var items_collected := []

func item_collected(tag: String) -> void:
	items_collected.append(tag)
	print(items_collected)
