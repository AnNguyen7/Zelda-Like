class_name BeeStateDash extends BeeState

@onready var timer: Timer = $Timer
@onready var dash_sfx: AudioStreamPlayer2D = $DashSfx

func transition():
	if ray_cast.is_colliding():
		get_parent().change_state("Shoot")


func dash():
	if owner.nearest_target:
		dash_sfx.play()
		var tween = get_tree().create_tween()
		tween.tween_property(owner, "position", owner.nearest_target.position, 0.75)
	else:
		get_parent().change_state("Idle")
	


func _on_timer_timeout() -> void:
	dash()

func enter():
	super.enter()
	timer.start()

func exit():
	super.exit()
	timer.stop()
