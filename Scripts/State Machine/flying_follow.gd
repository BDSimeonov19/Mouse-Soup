class_name FlyingFollow extends State

@export var enemy : CharacterBody2D 
var player : Character

var distance_to_player : Vector2

func enter():
	pass

func exit():
	pass

func update():
	pass

func physics_update():
	player = get_tree().get_first_node_in_group("player")
	distance_to_player = player.global_position - enemy.global_position
	
	if distance_to_player.length() < 60:
		transition_state.emit(self, "FlyingCharge")
	elif distance_to_player.length() < 250:
		enemy.velocity = distance_to_player.normalized() * enemy.SPEED
	elif distance_to_player.length() < 260:
		enemy.velocity = Vector2()
	else:
		transition_state.emit(self, "FlyingReturnHome")
