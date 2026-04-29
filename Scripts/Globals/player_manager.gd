extends Node

var health := 3

signal health_change(new_health, health_change)

func change_health(current_health, diff):
	health = current_health
	health_change.emit(current_health, diff)
	print(current_health)

func kill():
	get_node("/root/Main/World").get_child(0).queue_free()
	get_node("/root/Main/UI").get_child(0).queue_free()
	var death_screen_scene = load("res://Scenes/death_screen.tscn").instantiate()
	get_node("/root/Main/UI").add_child(death_screen_scene)
