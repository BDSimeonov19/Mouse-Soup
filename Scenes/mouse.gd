extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0


@onready var animated_sprite := $AnimatedSprite2D
@onready var attack_cooldown := $AttackCooldown

var is_attacking := false

func _process(delta: float) -> void:
	handle_attack_animations()

func handle_attack_animations() -> void:
	if Input.is_action_just_pressed("attack") and !is_attacking and attack_cooldown.is_stopped():
		is_attacking = true
		animated_sprite.play("attack")
		await animated_sprite.animation_finished
		is_attacking = false
		attack_cooldown.start()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	handle_movement_animations(velocity)
	
	move_and_slide()

func handle_movement_animations(velocity: Vector2) -> void:
	if !is_attacking:
		if velocity:
			animated_sprite.play("walk")
			animated_sprite.flip_h = velocity.x < 0
		else:
			animated_sprite.play("idle")
