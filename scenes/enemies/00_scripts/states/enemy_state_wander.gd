class_name EnemyStateWander extends EnemyState

@export var anim_name: String = "walk"
@export var wander_speed: float = 17.5

@export_category("AI")

@export var state_animation_duration: float = .8
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 2

@export var next_state: EnemyState

var _timer: float = 0.0
var _direction: Vector2

# what happens when we initialize this state?s
func init() -> void:
	pass

# what heppens when the enemy enters this state?
func enter() -> void:
	_timer = (randi_range(state_cycles_min, state_cycles_max)) * state_animation_duration
	var rand = randi_range(0,3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(anim_name)
	pass

# what happens when the enemy exits this state?
func exit() -> void:
	pass
	
# what happens during the process update in this state?
func process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null

# what happens during the physics process update in this state?
func physics(_delta: float) -> EnemyState:
	return null
