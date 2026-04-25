extends Area2D

@onready var docks_scene = preload("res://Scenes/docks.tscn").instantiate()

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		call_deferred("change_to_docks_scene")

func change_to_docks_scene():
	get_node("/root/Main/World").add_child(docks_scene)
	get_node("/root/Main/World/Forest").queue_free()
	SaveManager.save_data["current_level_path"] = "res://Scenes/docks.tscn"
