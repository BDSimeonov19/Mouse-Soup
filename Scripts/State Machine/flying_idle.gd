class_name FlyingIdle extends State

@export var enemy : CharacterBody2D

var timer : SceneTreeTimer

func enter():
	timer = get_tree().create_timer(enemy.idle_time)

func exit():
	pass

func update():
	pass

func physics_update():
	if timer.time_left == 0:
		transition_state.emit(self, "FlyingFollow")
	else:
		enemy.velocity = Vector2()
