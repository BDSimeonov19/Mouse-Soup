extends Control

@onready var volume_slider = $"Volume Slider"
@onready var volume_label = $"Volume Percent"
var master_bus_index = AudioServer.get_bus_index("Master")


func _ready() -> void:
	volume_slider.value = SaveManager.settings["volume"]

func _on_volume_slider_value_changed(value: float) -> void:
	volume_label.text = str(int(value)) + "%"


func _on_back_pressed() -> void:
	SaveManager.settings["volume"] = volume_slider.value
	queue_free()
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(SaveManager.settings["volume"]/100))
