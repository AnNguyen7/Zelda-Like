class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://scenes/items/item_pickup/item_pickup.tscn")

@export var anim_name: String = "destroy"

@export var knockback_speed: float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

@export_category("Item Drops")
@export var drops: Array[DropData]


var _damaged_position: Vector2
var _direction: Vector2

# what happens when we initialize this state?s
func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass

# what heppens when the enemy enters this state?
func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damaged_position)
	
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	disable_hurt_box()
	
	drop_items()
	pass

# what happens when the enemy exits this state?
func exit() -> void:
	pass
	
# what happens during the process update in this state?
func process(_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

# what happens during the physics process update in this state?
func physics(_delta: float) -> EnemyState:
	return null

func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
	_damaged_position = hurt_box.global_position
	state_machine.change_state(self)
	pass

func _on_animation_finished(_a: String) -> void:
	enemy.queue_free()
	pass

func disable_hurt_box() -> void:
	var hurt_box: HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false


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
			enemy.get_parent().call_deferred("add_child", drop)
			drop.global_position = enemy.global_position # + Vector2(randf()*16,randf()*16)
	
			drop.velocity = enemy.velocity.rotated(randf_range(-.75*2, .75*2) * randf_range(.45*2, .75*2))
	
	pass