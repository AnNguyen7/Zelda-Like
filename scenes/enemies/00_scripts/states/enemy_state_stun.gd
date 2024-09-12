class_name EnemyStateStun extends EnemyState

@export var anim_name: String = "stun"
@export var knockback_speed: float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")


@export var next_state: EnemyState

var _damaged_position: Vector2
var _direction: Vector2
var animation_finished_ : bool = false

# what happens when we initialize this state?s
func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass

# what heppens when the enemy enters this state?
func enter() -> void:
	enemy.invulnerable = true
	animation_finished_ = false
	
	_direction = enemy.global_position.direction_to(_damaged_position)
	
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed

	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass

# what happens when the enemy exits this state?
func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass
	
# what happens during the process update in this state?
func process(_delta: float) -> EnemyState:
	if animation_finished_:
		return next_state
		
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null


# what happens during the physics process update in this state?
func physics(_delta: float) -> EnemyState:
	return null

func _on_enemy_damaged(hurt_box: HurtBox) -> void:
	_damaged_position = hurt_box.global_position
	state_machine.change_state(self)
	pass

func _on_animation_finished(_a: String) -> void:
	animation_finished_ = true
	pass
