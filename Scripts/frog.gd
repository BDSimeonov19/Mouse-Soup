extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Hitbox = $Hitbox

const SPEED = 75.0
var health = 3
var is_attacking = false
var max_wander_time := 1
var max_pause_time := 2
var attack_cooldown := 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if velocity:
		flip_hitbox(velocity.x < 0)
		sprite.flip_h = velocity.x < 0
	
	move_and_slide()

func flip_hitbox(is_facing_left: bool) -> void:
	if (is_facing_left && !sprite.flip_h) || (!is_facing_left && sprite.flip_h):
		hitbox.scale.x *= -1;

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
