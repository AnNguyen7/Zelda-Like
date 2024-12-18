class_name Player extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal player_damaged(hurt_box: HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

var invulnerable: bool = false
var hp: int = 8
var max_hp: int = 8



@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $PlayerStateMachine
@onready var hit_box: HitBox = $HitBox



func _ready():
	GlobalPlayerManager.player = self
	state_machine.initialize(self)
	hit_box.Damaged.connect(_take_damage)
	update_hp(99)
	pass

func _process(_delta):
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	direction = direction.normalized()
	
func _physics_process(_delta):
	move_and_slide()

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	
	var direction_id: int = \
		int(round( (direction + cardinal_direction * .1).angle() / TAU * DIR_4.size() ))
	
	var new_dir = DIR_4[direction_id]

		
		
	if new_dir == cardinal_direction:
		return false
	
	# new direction
	cardinal_direction = new_dir 
	# set new direction to the signal(tell to other nodes that
	# the player has changed the direction
	direction_changed.emit(new_dir) 
	
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation(state: String) -> void:
	animation_player.play(state + "_" + animation_direction())


func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage(hurt_box: HurtBox) -> void:
	if invulnerable:
		return
	update_hp( -hurt_box.damage)
	if hp > 0:
		player_damaged.emit(hurt_box)
	else:
		player_damaged.emit(hurt_box)
		update_hp(99)
	pass

func update_hp(delta) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHud.update_hp(hp,max_hp)
	pass
	
func make_invulnerable(_duration: float = 1.0) -> void:
	invulnerable = true
	hit_box.set_deferred("monitorable", false)
	#hit_box.monitorable = false
	
	await get_tree().create_timer(_duration).timeout
	invulnerable = false
	hit_box.monitorable = true
	pass
