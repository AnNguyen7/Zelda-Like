class_name Bee extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var hit_box: HitBox = $HitBox
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var detect_area: Area2D = $DetectArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# pickup handle
const PICKUP = preload("res://scenes/items/item_pickup/item_pickup.tscn")

@export_category("Item Drops")
@export var drops: Array[DropData]



const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var player: Player
var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

var speed: float = 35.5

var hp: int = 6:
	set(value):
		hp = value
		progress_bar.value = value

var nearest_target: Node = null

func _ready() -> void:
	player = GlobalPlayerManager.player
	set_physics_process(false)
	hit_box.Damaged.connect(_take_damage)
	detect_area.body_entered.connect(_on_body_entered)
	detect_area.body_exited.connect(_on_body_exited)
	pass

func _process(_delta: float) -> void:
	update_nearest_target()
	if nearest_target:
		direction = (nearest_target.position - global_position).normalized()
		ray_cast.target_position = direction * 125

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func update_nearest_target() -> void:
	var closest_distance = INF
	nearest_target = null
	
	for body in detect_area.get_overlapping_bodies():
		if body is Player or body is Enemy:
			var distance = global_position.distance_to(body.global_position)
			if distance < closest_distance:
				closest_distance = distance
				nearest_target = body

func _take_damage(_hurt_box: HurtBox) -> void:
	#hp -= hurt_box.damage
	hp -= 1
	if hp > 0:
		#enemy_damaged.emit(hurt_box)
		pass
	else:
		#enemy_destroyed.emit(hurt_box)
		drop_items()
		animation_player.play("dead")

func _on_body_entered(_body: Node) -> void:
	update_nearest_target()

func _on_body_exited(_body: Node) -> void:
	update_nearest_target()


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
