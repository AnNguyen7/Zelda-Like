class_name State_Attack extends PlayerState

var is_attack: bool = false

@export var attack_sound: AudioStream
@export_range(1,20,0.5) var decelerate_speed: float = 5.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

# effect
@onready var attack_effect_anim = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"

@onready var walk: PlayerState = $"../Walk"
@onready var idle: PlayerState = $"../Idle"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var attack_hurt_box = %AttackHurtBox



#what happens when the player enters this state
func enter() -> void:
	player.update_animation("attack")
	attack_effect_anim.play("attack_" + player.animation_direction())
	animation_player.animation_finished.connect(end_attack)
	# play the sfx
	audio.stream = attack_sound
	audio.volume_db = -18.0
	audio.pitch_scale = randf_range(.9,1.1)
	audio.play()
	
	is_attack = true
	# create a timer and set delay
	await get_tree().create_timer(0.075).timeout
	if is_attack:
		attack_hurt_box.monitoring = true
	
	
	
#what happens when the player exits this state
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	is_attack = false
	attack_hurt_box.monitoring = false

func process(_delta: float) -> PlayerState:
	#player.velocity = Vector2.ZERO
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if not is_attack:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null

func physics(_delta: float) -> PlayerState:
	return null
	
func handle_input( _event: InputEvent) -> PlayerState:
	return null

func end_attack( _animationName: String) -> void:
	is_attack = false
