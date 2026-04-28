class_name GroundWander extends State

@export var enemy : CharacterBody2D 
var player : Character

var distance_to_player : float


var wander_timer : SceneTreeTimer
var pause_timer : SceneTreeTimer

func enter():
	pass

func exit():
	pass

func update():
	pass

func physics_update():
	player = get_tree().get_first_node_in_group("player")
	distance_to_player = player.global_position.x - enemy.global_position.x
	
	if abs(distance_to_player) < 150:
		transition_state.emit(self, "GroundFollow")
	elif !wander_timer:
		var wander_direction = -1 if randf() < 0.5 else 1
		var wander_velocity = randf() * enemy.SPEED * 0.75
		enemy.velocity.x = wander_direction * wander_velocity
		wander_timer = get_tree().create_timer(enemy.max_wander_time * randf())
	elif wander_timer.time_left == 0 and !pause_timer:
		enemy.sprite.play("idle")
		enemy.velocity = Vector2()
		pause_timer = get_tree().create_timer(enemy.max_pause_time * randf())
	elif pause_timer and pause_timer.time_left == 0:
		enemy.sprite.play("walk")
		wander_timer = null
		pause_timer = null
