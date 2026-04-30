extends Control

var forest_scene = load("res://Scenes/Levels/forest.tscn").instantiate()
var hud_scene = preload("res://Scenes/UI/hud.tscn").instantiate()

func _on_restart_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	get_node("/root/Main/World").add_child(forest_scene)
	get_node("/root/Main/UI").add_child(hud_scene)
	PlayerManager.health_change.connect(hud_scene.update_health)
	queue_free()
