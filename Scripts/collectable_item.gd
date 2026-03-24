class_name CollectableItem extends Node2D

@export var tag : String

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Character:
		ItemsManager.item_collected(tag)
		queue_free()
