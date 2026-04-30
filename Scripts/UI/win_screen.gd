extends Control

var forest_scene = load("res://Scenes/Levels/forest.tscn").instantiate()
var hud_scene = preload("res://Scenes/UI/hud.tscn").instantiate()

@onready var score_label: Label = $Score
@onready var best_score_label: Label = $BestScore

func _ready() -> void:
	var score = SaveManager.save_data["items_collected"].size()
	var best_score = SaveManager.save_data["best_score"]
	if score > best_score:
		SaveManager.save_data["best_score"] = score
		best_score = score
	score_label.text = score_label.text.replace("x", str(score))
	best_score_label.text = best_score_label.text.replace("x", str(best_score)) 

func _on_restart_pressed() -> void:
	get_node("/root/Main/UISFX").play()
	get_node("/root/Main/World").add_child(forest_scene)
	get_node("/root/Main/UI").add_child(hud_scene)
	PlayerManager.health_change.connect(hud_scene.update_health)
	queue_free()
