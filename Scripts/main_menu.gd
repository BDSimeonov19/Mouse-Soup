extends Control

var level_scene = preload("res://Scenes/forest.tscn").instantiate()
var hud_scene = preload("res://Scenes/hud.tscn").instantiate()

func _on_begin_pressed() -> void:
	get_node("/root/Main/World").add_child(level_scene)
	get_node("/root/Main/UI").add_child(hud_scene)
	get_node("/root/Main").health_change.connect(hud_scene.update_health)
	
	get_node("/root/Main").is_pausable = true
	queue_free()

func _on_settings_pressed() -> void:
	var settings_menu_scene = load("res://Scenes/settings_menu.tscn").instantiate()
	add_child(settings_menu_scene)


func _on_quit_pressed() -> void:
	SaveManager.save_game()
	get_tree().quit()
