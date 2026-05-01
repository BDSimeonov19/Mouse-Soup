extends Node

func _ready() -> void:
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	for collectible in collectibles:
		if collectible.tag in ItemsManager.items_collected:
			collectible.queue_free()
