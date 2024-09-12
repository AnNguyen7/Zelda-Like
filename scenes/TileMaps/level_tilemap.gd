class_name LevelTileMap extends TileMap



func _ready() -> void:
	GlobalLevelManager.change_tilemap_bounds(get_tilemap_bounds())



func get_tilemap_bounds() -> Array[Vector2]:
	var bounds: Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)
	)
	bounds.append(get_used_rect().end * rendering_quadrant_size)
	
	return bounds
