extends Control

var hud_scene = preload("res://Scenes/UI/hud.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_start_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	var current_level_path = SaveManager.save_data["current_level_path"]
	var level_scene = load(current_level_path).instantiate()
	get_node("/root/Main/World").add_child(level_scene)
	get_node("/root/Main/UI").add_child(hud_scene)
	PlayerManager.health_change.connect(hud_scene.update_health)
	queue_free()
