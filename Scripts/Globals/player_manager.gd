extends Node

var health := 3

signal health_change(new_health, health_change)

func change_health(diff):
	health += diff
	health = clamp(health, 0, 3)
	health_change.emit(health, diff)

func kill():
	get_node("/root/Main/World").get_child(0).queue_free()
	get_node("/root/Main/UI").get_child(0).queue_free()
	var death_screen_scene = load("res://Scenes/UI/death_screen.tscn").instantiate()
	get_node("/root/Main/UI").add_child(death_screen_scene)
	health = 3
