extends Camera3D


@export var follow_target: Node
@export var offset = Vector3(0, 2, 2)
var from_pos: Vector3
var to_pos: Vector3
var delta_movement: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	follow_target.position_update.connect(set_target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	do_move()


func do_move() -> void:
	if from_pos == null or to_pos == null:
		return
	elif delta_movement < 1:
		delta_movement += .05
		self.position = to_pos.lerp(from_pos, delta_movement)


func set_target() -> void:
	from_pos = position
	to_pos = follow_target.transform.origin + offset
	delta_movement = 0
