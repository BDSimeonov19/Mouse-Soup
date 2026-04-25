extends Node

var is_pausable := false

var save_data := {"items_collected": [], "current_level_path" : ""}
var settings := {"volume": 100}

func _ready() -> void:
	load_game()

func _process(delta: float) -> void:
	if is_pausable and Input.is_action_just_pressed("pause"):
		var settings_menu_scene = preload("res://Scenes/pause_menu.tscn").instantiate()
		get_node("/root/Main/UI").add_child(settings_menu_scene)
		get_tree().paused = true
		get_node("/root/Main").is_pausable = false

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)

	save_file.store_line(JSON.stringify(save_data))
	save_file.store_line(JSON.stringify(settings))
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	
	var save_data_string = save_file.get_line()
	var settings_string = save_file.get_line()
	
	var parse_result = json.parse(save_data_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", save_data_string, " at line ", json.get_error_line())
		return

	save_data = json.data
	
	ItemsManager.items_collected = save_data["items_collected"]
	
	parse_result = json.parse(settings_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", settings_string, " at line ", json.get_error_line())
		return
	
	settings = json.data
