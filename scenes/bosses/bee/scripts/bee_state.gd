class_name BeeState extends Node2D
# abstract class

var player: Player
var bee: Bee
@onready var debug = owner.find_child("Debug")
@onready var ray_cast = owner.find_child("RayCast2D")

func _ready() -> void:
	player = GlobalPlayerManager.player
	set_physics_process(false)
	pass # Replace with function body.

func enter() -> void:
	set_physics_process(true)
	pass
	
func exit() -> void:
	set_physics_process(false)
	pass

func transition():
	pass

func _physics_process(_delta: float) -> void:
	transition()
	debug.text = name
	pass
