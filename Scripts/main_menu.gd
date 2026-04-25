extends Control

var level_scene = preload("res://Scenes/forest.tscn").instantiate()
var settings_menu_scene = load("res://Scenes/settings_menu.tscn").instantiate()


func _on_begin_pressed() -> void:
	get_node("/root/Main/World").add_child(level_scene)
	queue_free()

func _on_settings_pressed() -> void:
	get_node("/root/Main/UI").add_child(settings_menu_scene)
	queue_free()


func _on_quit_pressed() -> void:
	get_tree().quit()
