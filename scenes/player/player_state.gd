class_name PlayerState extends Node

static var player: Player
static var state_machine: PlayerStateMachine

func _ready():
	pass
	
# what happens when we initialize this state?
func init() -> void:
	pass

# what heppens when the player enters this state?
func enter() -> void:
	pass

# what happens when the player exits this state?
func exit() -> void:
	pass
	
# what happens during the process update in this state?
func process(_delta: float) -> PlayerState:
	return null

# what happens during the physics process update in this state?
func physics(_delta: float) -> PlayerState:
	return null
	
func handle_input( _event: InputEvent) -> PlayerState:
	return null
