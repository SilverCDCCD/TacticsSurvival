extends Node3D


@onready var gridmap:GridMap = $"../.."


func check_block_type(pos: Vector3) -> int:
	return gridmap.get_cell_item(gridmap.local_to_map(pos))


func check_float(pos: Vector3) -> Vector3:
	if check_block_type(pos) != -1:
		$"..".position += Vector3.UP
		return check_float(pos + Vector3.UP)
	else:
		return pos


func check_sink(pos: Vector3) -> Vector3:
	if check_block_type(pos + Vector3.DOWN) == -1:
		$"..".position += Vector3.DOWN
		return check_sink(pos + Vector3.DOWN)
	else:
		return pos


func get_movement(pos: Vector3) -> Vector3:
	return check_sink(check_float(pos))
