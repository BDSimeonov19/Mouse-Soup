extends Node

@onready var seagull_sound: RandomizedAudioStreamPlayer = $SeagullSound

var seagull_sound_timer : SceneTreeTimer

func _ready() -> void:
	seagull_sound_timer = get_tree().create_timer(8)
	seagull_sound_timer.timeout.connect(handle_seagull_sound)

func handle_seagull_sound() -> void:
	var time = randf_range(18,28)
	seagull_sound.play()
	seagull_sound_timer = get_tree().create_timer(time)
	seagull_sound_timer.timeout.connect(handle_seagull_sound)
