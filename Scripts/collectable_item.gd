class_name CollectableItem extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx: AudioStreamPlayer = $SFX
@onready var area_2d: Area2D = $AnimatedSprite2D/Area2D

@export var tag : String
@export var sprite_frames : SpriteFrames

func _ready() -> void:
	animated_sprite_2d.sprite_frames = sprite_frames
	animated_sprite_2d.play("bob")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Character:
		area_2d.queue_free()
		animated_sprite_2d.queue_free()
		sfx.play()
		ItemsManager.item_collected(tag)
		PlayerManager.change_health(1)
		
func _on_sfx_finished() -> void:
	queue_free()
