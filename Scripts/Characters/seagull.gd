extends CharacterBody2D

var health = 2
var idle_time = 1
var charge_time = 0.8
var charge_windup_time = 1.5
var charge_multiplier = 4
const SPEED = 35.0

var last_velocity := 0.0

@export var home : Marker2D
@onready var sprite := $AnimatedSprite2D;

func _physics_process(delta: float) -> void:
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif last_velocity > 0:
		$AnimatedSprite2D.flip_h = true
	elif last_velocity < 0:
		$AnimatedSprite2D.flip_h = false
	
	last_velocity = velocity.x
	move_and_slide()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		take_damage();

func take_damage() -> void:
	health -= 1;
	
	if health == 0:
		kill();
	
	sprite.modulate = Color(1, 0, 0, 1)
	await get_tree().create_timer(0.5).timeout
	sprite.modulate = Color(1, 1, 1, 1)

func kill() -> void:
	queue_free()
