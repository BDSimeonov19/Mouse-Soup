class_name RandomizedAudioStreamPlayer extends AudioStreamPlayer

@export var min_pitch : float = 1
@export var max_pitch : float = 1
@export var auto_loop : bool = false

func play_rand(from_position : float = 0.0) -> void:
	pitch_scale = randf_range(min_pitch, max_pitch)
	super.play(from_position)

#func _on_finished() -> void:
	#play_rand()
