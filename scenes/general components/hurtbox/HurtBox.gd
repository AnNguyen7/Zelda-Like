class_name HurtBox extends Area2D

@export var damage: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if area_entered.is_connected(_on_area_entered):
		area_entered.disconnect(_on_area_entered)
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is HitBox:
		area.take_damage(self)
