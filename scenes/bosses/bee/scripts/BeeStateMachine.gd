class_name BeeStateMachine extends Node2D

var prev_state: BeeState
var current_state: BeeState

func _ready() -> void:
	current_state = get_child(0) as BeeState
	prev_state = current_state
	current_state.enter()


func change_state(state):
	current_state = find_child(state) as BeeState
	current_state.enter()
	
	prev_state.exit()
	prev_state = current_state
