extends Node

var is_pausable := false
var master_bus_index = AudioServer.get_bus_index("Master")


func _ready() -> void:
	SaveManager.load_game()
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(SaveManager.settings["volume"]/100))

func _process(delta: float) -> void:
	print(SaveManager.save_data)
	developer_reset_game()
	if is_pausable and Input.is_action_just_pressed("pause"):
		var settings_menu_scene = preload("res://Scenes/UI/pause_menu.tscn").instantiate()
		get_node("/root/Main/UI").add_child(settings_menu_scene)
		get_tree().paused = true
		get_node("/root/Main").is_pausable = false

func developer_reset_game():
	if Input.is_action_just_pressed("reset"):
		SaveManager.save_data = {
		"items_collected": [],
		"current_level_path" : "res://Scenes/Levels/forest.tscn",
		"best_score" : 0
		}
		SaveManager.settings = {"volume": 100}
