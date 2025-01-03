extends Node3D

var init_pos: Vector3
var destination: Vector3
var moving: bool = false
var parent: CharacterBody3D
var movement_delta: float = 0

var PREFER_X: int = 0
var PREFER_Z: int = 1


func _ready() -> void:
	parent = $".."


func _process(delta: float) -> void:
	pass



func build_path(dest: Vector3):
	var next = parent.position
	var delta = dest - parent.position
	
	# Choose preferred direction
	# 0 = Prefer north-south
	# 1 = Prefer east-west
	var preferred_dir = PREFER_X if abs(delta.x) > abs(delta.z) else PREFER_Z
	var result = []
	while not non_vertical_match(next, dest):
		result.append(next)
		var next_move = next_move_direction(next, dest, preferred_dir)
		next += next_move
		if lateral_match(next, dest, preferred_dir):
			preferred_dir ^= 1
	return result


func find_next_position():
	pass



func lateral_match(pos1: Vector3, pos2: Vector3, preferred_dir: int) -> bool:
	if preferred_dir == PREFER_X:
		return pos1.x == pos2.x
	else:
		return pos1.z == pos2.z


func next_move_direction(start: Vector3, end: Vector3, preferred: int) -> Vector3:
	if non_vertical_match(start, end):
		return Vector3.ZERO
	if preferred == PREFER_Z:
		if start.z > end.z:
			return Vector3.FORWARD
		elif start.z < end.z:
			return Vector3.BACK
		else:
			return Vector3.ZERO
	else:
		if start.x > end.x:
			return Vector3.LEFT
		if start.x < end.x:
			return Vector3.RIGHT
		return Vector3.ZERO


func non_vertical_match(pos1: Vector3, pos2: Vector3) -> bool:
	return pos1.x == pos2.x and pos1.z == pos2.z
