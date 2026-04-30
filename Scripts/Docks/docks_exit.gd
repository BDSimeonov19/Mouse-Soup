extends Area2D

@onready var field_scene = preload("res://Scenes/Levels/field.tscn").instantiate()

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		call_deferred("change_to_field_scene")

func change_to_field_scene():
	get_node("/root/Main/World/Docks").queue_free()
	get_node("/root/Main/World").add_child(field_scene)
	SaveManager.save_data["current_level_path"] = "res://Scenes/Levels/field.tscn"
