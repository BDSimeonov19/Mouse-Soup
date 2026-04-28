class_name FlyingCharge extends State

@export var enemy : CharacterBody2D 
var player : Character

var distance_to_player : Vector2
var charge_timer : SceneTreeTimer
var windup_timer : SceneTreeTimer

func enter():
	pass

func exit():
	pass

func update():
	pass

func physics_update():
	# windup charge
	if !windup_timer:
		$"../../AnimatedSprite2D".animation = "charge_windup"
		windup_timer = get_tree().create_timer(enemy.charge_windup_time)
		enemy.velocity = Vector2()
	# ready to charge
	if !charge_timer and windup_timer.time_left == 0:
		$"../../AnimatedSprite2D".animation = "fly"
		player = get_tree().get_first_node_in_group("player")
		distance_to_player = player.global_position - enemy.global_position
		enemy.velocity = distance_to_player.normalized() * enemy.SPEED * enemy.charge_multiplier
		charge_timer = get_tree().create_timer(enemy.charge_time)
	
	# charge is over
	if charge_timer and charge_timer.time_left == 0:
		transition_state.emit(self, "FlyingIdle")
		charge_timer = null
		windup_timer = null
