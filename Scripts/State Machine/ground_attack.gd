class_name GroundAttack extends State

@export var enemy : CharacterBody2D
@export var hitbox_collision_shape : CollisionShape2D
var player : Character

var distance_to_player : float
var attack_timer : SceneTreeTimer
var windup_timer : SceneTreeTimer

func enter():
	windup_timer = get_tree().create_timer(0.2)
	attack_timer = get_tree().create_timer(0)

func exit():
	pass

func update():
	pass

func physics_update():
	player = get_tree().get_first_node_in_group("player")
	distance_to_player = player.global_position.x - enemy.global_position.x

	if abs(distance_to_player) > 20 and !enemy.is_attacking:
		transition_state.emit(self, "GroundFollow")

	elif !enemy.is_attacking and windup_timer.time_left == 0 and attack_timer.time_left == 0:
		enemy.is_attacking = true
		enemy.sprite.play("attack")
		hitbox_collision_shape.disabled = false
		await enemy.sprite.animation_finished
		hitbox_collision_shape.disabled = true
		enemy.is_attacking = false
		enemy.sprite.play("idle")
		attack_timer = get_tree().create_timer(enemy.attack_cooldown)
