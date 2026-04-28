class_name GroundFollow extends State

@export var enemy : CharacterBody2D 
var player : Character

var distance_to_player : float

func enter():
	pass

func exit():
	pass

func update():
	pass

func physics_update():
	player = get_tree().get_first_node_in_group("player")
	distance_to_player = player.global_position.x - enemy.global_position.x
	var direction_to_player = distance_to_player / abs(distance_to_player)
	
	if abs(distance_to_player) < 20:
		enemy.velocity = Vector2()
		transition_state.emit(self, "GroundAttack")
	elif abs(distance_to_player) < 250:
		enemy.sprite.play("walk")
		enemy.velocity.x = direction_to_player * enemy.SPEED
	elif abs(distance_to_player) < 260:
		enemy.velocity = Vector2()
	else:
		transition_state.emit(self, "GroundWander")
