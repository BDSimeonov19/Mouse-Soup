class_name FlyingReturnHome extends State 

@export var enemy : CharacterBody2D 
var player : Character

func enter():
	pass

func exit():
	pass

func update():
	pass

func physics_update():
	player = get_tree().get_first_node_in_group("player")
	var distance_to_player := player.global_position - enemy.global_position
	var distance_to_home = enemy.home.global_position - enemy.global_position
	
	if distance_to_home.length() > 5:
		enemy.velocity = distance_to_home.normalized() * enemy.SPEED
	else:
		enemy.velocity = Vector2()
	
	if distance_to_player.length() < 100:
		transition_state.emit(self, "FlyingFollow")
