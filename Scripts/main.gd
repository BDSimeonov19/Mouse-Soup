extends Node

var is_pausable := false


signal health_change(new_health, health_change)

func _ready() -> void:
	SaveManager.load_game()

func _process(delta: float) -> void:
	if is_pausable and Input.is_action_just_pressed("pause"):
		var settings_menu_scene = preload("res://Scenes/pause_menu.tscn").instantiate()
		get_node("/root/Main/UI").add_child(settings_menu_scene)
		get_tree().paused = true
		get_node("/root/Main").is_pausable = false



func take_damage(current_health, diff):
	health_change.emit(current_health, diff)
