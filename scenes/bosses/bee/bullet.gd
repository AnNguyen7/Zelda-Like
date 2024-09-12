class_name BeeBullet extends Area2D

@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@export var damage: int = 1
@onready var hurt_box: HurtBox = $HurtBox


var direction: Vector2 = Vector2.RIGHT
var speed: int = 350

func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(_on_screen_exited)
	hurt_box.area_entered.connect(_on_area_entered)
	pass

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	pass

func _on_screen_exited() -> void:
	queue_free()

func _on_area_entered(_area: HitBox) -> void:
	queue_free()
