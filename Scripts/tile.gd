extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	id_overlap()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func id_overlap() -> void:
	var col = move_and_collide(Vector3.ZERO).get_collider().to_string()
	print(col)
