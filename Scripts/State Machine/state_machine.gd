class_name StateMachine extends Node

@export var initial_state : State
var states : Dictionary
var active_state : State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition_state.connect(transition)
	active_state = initial_state

func _process(delta: float) -> void:
	active_state.update()

func _physics_process(delta: float) -> void:
	active_state.physics_update()

func transition(current_state: State, new_state_name: String):
	if current_state != active_state:
		return
	
	active_state.exit()
	
	active_state = states[new_state_name.to_lower()]
	
	active_state.enter()
