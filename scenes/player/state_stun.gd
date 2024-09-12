class_name State_Stun extends PlayerState

@export var knock_back_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box: HurtBox
var direction: Vector2

var next_state: PlayerState = null


@onready var idle: PlayerState = $"../Idle"

func init() -> void:
	player.player_damaged.connect(_on_player_damaged)
	pass


func enter() -> void:
	player.animation_player.animation_finished.connect(_on_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knock_back_speed
	player.set_direction()
	
	player.update_animation("stun")
	player.make_invulnerable(invulnerable_duration)
	#player effect animation
	pass
	
func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass
	
func process(_delta: float) -> PlayerState:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state

func physics(_delta: float) -> PlayerState:
	return null

func handle_input( _event: InputEvent) -> PlayerState:
	return null

func _on_player_damaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.change_state(self)
	pass
	
func _on_animation_finished(_a: String) -> void:
	next_state = idle
	pass
