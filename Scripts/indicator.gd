extends Area3D


signal position_update
signal move_player

var highlighted: Node3D
var selected: Node3D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_select"):
		select()
	if event.is_action_pressed("player_deselect"):
		deselect()
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if event.physical_keycode == KEY_P:
			print(position)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("player_move_fwd"):
		move(Vector3.FORWARD)
	elif Input.is_action_just_pressed("player_move_back"):
		move(Vector3.BACK)
	elif Input.is_action_just_pressed("player_move_left"):
		move(Vector3.LEFT)
	elif Input.is_action_just_pressed("player_move_right"):
		move(Vector3.RIGHT)
	position_update.emit()


func _ready() -> void:
	area_entered.connect(id_capture)
	body_entered.connect(id_capture)
	body_exited.connect(clear_highlight)


func clear_highlight(other: Node3D):
	highlighted = null
	print("Highlight cleared")


func deselect():
	selected = null
	print("Selection cleared")


func id_capture(other: Node3D) -> void:
	if other.collision_layer & 1 == 1:
		highlighted = other
	elif other.collision_layer & 4 == 4:
		print(other.name)


func move(dir: Vector3):
	var final_pos = $IndicatorMover.get_movement(position + dir)
	position = final_pos


func select():
	match selection_mode():
		2:
			print(selected.get_child(2).build_path(position))
		4, 6:
			selected = highlighted
			$"../Test UI".update_selection(selected)
		7:
			selected = null
			$"../Test UI".update_selection(selected)


func selection_mode() -> int:
	var result = 0
	if highlighted:
		result += 4
	if selected:
		result += 2
	if highlighted == selected:
		result += 1
	return result
