class_name Character extends CharacterBody2D

var health = 2

const SPEED = 25.0
const JUMP_VELOCITY = -300.0

@onready var ray := $RayCast2D;
@onready var sprite := $AnimatedSprite2D;

# positive means right
var direction = 1;

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if !ray.is_colliding() and is_on_floor():
		
		direction *= -1;
		scale.x *= -1;
	
	velocity.x = direction * SPEED

	move_and_slide()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		print("ouch")
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
