extends Control

@onready var cheese = [$"CanvasLayer/HP 1", $"CanvasLayer/HP 2", $"CanvasLayer/HP 3"]

func update_health(current_health, health_change):
	for i in range(cheese.size()):
		var frame = 0 if i < current_health else 1
		cheese[i].region_rect = Rect2(0, (frame + 1) * 16, 16, 16)
