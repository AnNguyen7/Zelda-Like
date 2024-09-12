extends CanvasLayer

@onready var control: Control = $Control


var hearts_array: Array[HeartGUI] = []
@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer

func _ready() -> void:
	for child in h_flow_container.get_children():
		if child is HeartGUI:
			hearts_array.append(child)
			child.visible = false
	pass
	

func update_hp(_hp: int, _max_hp: int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, _hp)
	pass

func update_heart(_index: int, _hp: int) -> void:
	var _value: int = clampi(_hp - _index * 4, 0 , 4)
	hearts_array[_index].value = _value
	pass

func update_max_hp(_max_hp: int) -> void:
	var _hearts_count: int = roundi(_max_hp * .25)
	for i in hearts_array.size():
		if i < _hearts_count:
			hearts_array[i].visible = true
		else:
			hearts_array[i].visible = false
	pass
