class_name Plant extends Node2D
@onready var hit_box = $HitBox
@onready var sprite = $Sprite2D
@onready var sprite_2 = $Sprite2D2

var random_sprite: Array

const PICKUP = preload("res://scenes/items/item_pickup/item_pickup.tscn")

@export_category("Item Drops")
@export var drops: Array[DropData]

func _ready():

	sprite.visible = false
	sprite_2.visible = false
	
	random_sprite = [sprite, sprite, sprite, sprite, sprite, sprite_2]
	var active_sprite = random_sprite.pick_random()
	
	if active_sprite == sprite:
		sprite.frame = get_frame_with_exclude(16)
		sprite.visible = true

	else:
		sprite_2.visible = true
	
	hit_box.Damaged.connect(take_damage)

func take_damage(_damage: HurtBox) -> void:
	drop_items()
	$AnimationPlayer2.play("queue_free")
	#queue_free()
	
func get_frame_with_exclude(exclude_frame: int) -> int:
	var frame: int
	while true:
		frame = randi() % 20
		if frame == exclude_frame:
			continue
		else:
			break
			
	return frame

func drop_items() -> void:
	if drops.size() == 0:
		return
		
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
		var drop_count: int = drops[i].get_drop_count()
		for j in drop_count:
			var drop: ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			get_parent().call_deferred("add_child", drop)
			drop.position = global_position
	pass
