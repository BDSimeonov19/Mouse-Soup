extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0


@onready var animated_sprite = $AnimatedSprite2D

func _process(delta: float) -> void:
	handle_animations()

func handle_animations() -> void:
	if (!animated_sprite.is_playing()) or \
	   (Input.is_action_just_released("left") or Input.is_action_just_released("right")):
		animated_sprite.play("idle")
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		animated_sprite.play("walk")
	if Input.is_action_just_pressed("attack"):
		animated_sprite.play("attack")
	
	if Input.is_action_just_pressed("left"):
		animated_sprite.flip_h = true
	if Input.is_action_just_pressed("right"):
		animated_sprite.flip_h = false

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

	move_and_slide()
