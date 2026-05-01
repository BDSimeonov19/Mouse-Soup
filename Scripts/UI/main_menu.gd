extends Control

var hud_scene = preload("res://Scenes/UI/hud.tscn").instantiate()
@onready var begin: Button = $VBoxContainer/Begin

func _ready() -> void:
	focus()

func focus() -> void:
	begin.grab_focus()

func _on_begin_pressed() -> void:
	get_node("/root/Main/UISFX").play()	
	var intro_screen_scene = load("res://Scenes/UI/intro_screen.tscn").instantiate()
	get_node("/root/Main/UI").add_child(intro_screen_scene)
	queue_free()

func _on_settings_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	var settings_menu_scene = load("res://Scenes/UI/settings_menu.tscn").instantiate()
	add_child(settings_menu_scene)


func _on_quit_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	SaveManager.save_game()
	get_tree().quit()
