extends Control

@onready var volume_slider = $"Volume Slider"
@onready var volume_label = $"Volume Percent"

func _on_volume_slider_value_changed(value: float) -> void:
	volume_label.text = str(int(value)) + "%"


func _on_back_pressed() -> void:
	var main_menu_scene = preload("res://Scenes/main_menu.tscn").instantiate()
	print("buh")
	get_node("/root/Main/UI").add_child(main_menu_scene)
	queue_free()
