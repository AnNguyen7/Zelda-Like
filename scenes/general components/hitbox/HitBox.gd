class_name HitBox extends Area2D

signal Damaged(hurt_box: HurtBox)

@onready var enemy: Enemy

func _ready():
	pass
	
func _process(_delta):
	pass


func take_damage(hurt_box: HurtBox) -> void:
	Damaged.emit(hurt_box)
