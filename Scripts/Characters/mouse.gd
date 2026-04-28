class_name Character extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0


@onready var sprite := $AnimatedSprite2D
@onready var attack_cooldown := $AttackCooldown
@onready var hitbox := $Hitbox;

var time_since_last_floor := 0.0
@export var coyote_time := 0.1

var is_attacking := false

var health : int

func _ready() -> void:
	health = PlayerManager.health

func _process(delta: float) -> void:
	handle_attack_animations()

func handle_attack_animations() -> void:
	if Input.is_action_just_pressed("attack") and !is_attacking and attack_cooldown.is_stopped():
		is_attacking = true
		sprite.play("attack")
		$Hitbox/CollisionShape2D.disabled = false
		await sprite.animation_finished
		$Hitbox/CollisionShape2D.disabled = true
		is_attacking = false
		attack_cooldown.start()

func is_on_floor_coyote() -> bool:
	return time_since_last_floor < coyote_time

func _physics_process(delta: float) -> void:
	if is_on_floor():
		time_since_last_floor = 0
	else:
		time_since_last_floor += delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor_coyote():
		velocity.y = JUMP_VELOCITY
		time_since_last_floor += coyote_time

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
			sprite.play("walk")
			flip_hitbox(velocity.x < 0)
			sprite.flip_h = velocity.x < 0
		else:
			sprite.play("idle")

func flip_hitbox(is_facing_left: bool) -> void:
	if (is_facing_left && !sprite.flip_h) || (!is_facing_left && sprite.flip_h):
		hitbox.scale.x *= -1;

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		take_damage()

func take_damage() -> void:
	health -= 1;
	PlayerManager.change_health(health, -1)
	sprite.modulate = Color(1, 0, 0, 1)
	await get_tree().create_timer(0.5).timeout
	sprite.modulate = Color(1, 1, 1, 1)
	if health <= 0:
		#PlayerManager.kill();
		health = 3
		PlayerManager.change_health(health, 3)
