extends Node

var is_pausable := false


signal health_change(new_health, health_change)

func _ready() -> void:
	SaveManager.load_game()

func _process(delta: float) -> void:
	developer_reset_game()
	if is_pausable and Input.is_action_just_pressed("pause"):
		var settings_menu_scene = preload("res://Scenes/pause_menu.tscn").instantiate()
		get_node("/root/Main/UI").add_child(settings_menu_scene)
		get_tree().paused = true
		get_node("/root/Main").is_pausable = false

func developer_reset_game():
	if Input.is_action_just_pressed("reset"):
		SaveManager.save_data = {"items_collected": [], "current_level_path" : "res://Scenes/forest.tscn"}
		SaveManager.settings = {"volume": 100}


func take_damage(current_health, diff):
	health_change.emit(current_health, diff)
