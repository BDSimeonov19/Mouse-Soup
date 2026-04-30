extends Area2D

@onready var win_scene = preload("res://Scenes/UI/win_screen.tscn").instantiate()

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		call_deferred("change_to_win_scene")

func change_to_win_scene():
	get_node("/root/Main/World/Field").queue_free()
	get_node("/root/Main/UI/Hud").queue_free()
	get_node("/root/Main/UI").add_child(win_scene)
	SaveManager.save_data["current_level_path"] = "res://Scenes/Levels/forest.tscn"
