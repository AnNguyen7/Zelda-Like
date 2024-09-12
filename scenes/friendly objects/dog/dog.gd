class_name Dog extends CharacterBody2D
@onready var hit_box = $HitBox
@onready var sprite = $Sprite2D
@onready var sprite_2 = $Sprite2D2
@onready var timer = $Timer

var random_sprite: Array

# pickup handle
const PICKUP = preload("res://scenes/items/item_pickup/item_pickup.tscn")

@export_category("Item Drops")
@export var drops: Array[DropData]


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(change_direction)
	timer.wait_time = randf_range(1,1.5)
	
	sprite.visible = false
	sprite_2.visible = false

	random_sprite = [sprite, sprite_2]
	var active_sprite = random_sprite.pick_random()
	if active_sprite == sprite:
		sprite.visible = true
	else:
		sprite_2.visible = true
		
	hit_box.Damaged.connect(take_damage)
	
func take_damage(_damage: HurtBox) -> void:
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.9,1.1)
	
	var random_animation: Array[String] = ["queue_free", "queue_free_2"]
	drop_items()
	$AnimationPlayer.play(random_animation.pick_random())
	
	#queue_free()

func change_direction():
	var directions = ["left", "right"]
	var random_direction = directions.pick_random()
	match random_direction:
		"left":
			sprite.flip_h = true  
			sprite_2.flip_h = true
		"right":
			sprite.flip_h = false  
			sprite_2.flip_h = false
	
	# Randomize the timer interval again and restart it
	timer.wait_time = randf_range(1.0, 1.5)
	timer.start()


func drop_items() -> void:
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i]  == null or drops[i].item == null:
			continue
			
		var drop_count = drops[i].get_drop_count()
		for j in drop_count:
			var drop: ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			get_parent().call_deferred("add_child", drop)
			drop.global_position = global_position
