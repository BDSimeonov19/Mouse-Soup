extends Control

var level_scene = preload("res://Scenes/forest.tscn").instantiate()


func _on_begin_pressed() -> void:
	get_node("/root/Main/World").add_child(level_scene)
	get_node("/root/Main").is_pausable = true
	queue_free()

func _on_settings_pressed() -> void:
	var settings_menu_scene = load("res://Scenes/settings_menu.tscn").instantiate()
	add_child(settings_menu_scene)


func _on_quit_pressed() -> void:
	get_node("/root/Main").save_game()
	get_tree().quit()
