extends Control

@onready var resume: Button = $VBoxContainer/Resume

func _ready() -> void:
	focus()

func focus() -> void:
	resume.grab_focus()

func _on_resume_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	get_tree().paused = false
	get_node("/root/Main").is_pausable = true
	queue_free()


func _on_settings_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	var settings_menu_scene = load("res://Scenes/UI/settings_menu.tscn").instantiate()
	add_child(settings_menu_scene)


func _on_quit_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	SaveManager.save_game()
	get_tree().quit()
