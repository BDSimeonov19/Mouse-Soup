extends Control

func _on_resume_pressed() -> void:
	get_tree().paused = false
	get_node("/root/Main").is_pausable = true
	queue_free()


func _on_settings_pressed() -> void:
	var settings_menu_scene = load("res://Scenes/settings_menu.tscn").instantiate()
	add_child(settings_menu_scene)


func _on_quit_pressed() -> void:
	get_node("/root/Main").save_game()
	get_tree().quit()
