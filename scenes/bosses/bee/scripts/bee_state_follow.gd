class_name BeeStateFollow extends BeeState

func transition():
	if ray_cast.is_colliding():
		get_parent().change_state("Shoot")

func enter() -> void:
	super.enter()
	owner.set_physics_process(true)
	pass
	
func exit() -> void:
	super.exit()
	owner.set_physics_process(false)	
	pass
