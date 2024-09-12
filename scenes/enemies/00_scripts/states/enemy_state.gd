class_name EnemyState extends Node

#Stores a reference to the enemy that this state belongs to 
var enemy: Enemy
var state_machine: EnemyStateMachine

static var player: Player

# what happens when we initialize this state?
func init() -> void:
	pass

# what heppens when the enemy enters this state?
func enter() -> void:
	pass

# what happens when the enemy exits this state?
func exit() -> void:
	pass
	
# what happens during the process update in this state?
func process(_delta: float) -> EnemyState:
	return null

# what happens during the physics process update in this state?
func physics(_delta: float) -> EnemyState:
	return null
