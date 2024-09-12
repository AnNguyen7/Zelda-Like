class_name BeeStateShoot extends BeeState

@export var bullet_scene: PackedScene
@onready var timer: Timer = $Timer
@onready var shoot_sfx: AudioStreamPlayer2D = $ShootSfx

func transition():
	if not owner.ray_cast.is_colliding():
		if owner.hp > 3:
			get_parent().change_state("Idle")
		else:
			get_parent().change_state("Dash")

func enter() -> void:
	super.enter()
	timer.start()

func exit() -> void:
	super.exit()
	timer.stop()

func _on_timer_timeout() -> void:
	shoot()

func shoot() -> void:
	if not owner.nearest_target:
		return
	
	var bullet: Area2D = bullet_scene.instantiate()
	
	bullet.position = owner.global_position
	bullet.direction = (owner.nearest_target.global_position - owner.global_position).normalized()

	#add it to scene tree
	get_tree().current_scene.call_deferred("add_child", bullet)
	shoot_sfx.play()
	pass
