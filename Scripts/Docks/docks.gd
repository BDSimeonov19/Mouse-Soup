extends Node

@onready var seagull_sound: RandomizedAudioStreamPlayer = $SeagullSound

var seagull_sound_timer : SceneTreeTimer

func _ready() -> void:
	seagull_sound_timer = get_tree().create_timer(8)
	seagull_sound_timer.timeout.connect(handle_seagull_sound)
	
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	for collectible in collectibles:
		#print(collectible.tag)
		if collectible.tag in ItemsManager.items_collected:
			collectible.queue_free()


func handle_seagull_sound() -> void:
	var time = randf_range(18,28)
	seagull_sound.play()
	seagull_sound_timer = get_tree().create_timer(time)
	seagull_sound_timer.timeout.connect(handle_seagull_sound)
