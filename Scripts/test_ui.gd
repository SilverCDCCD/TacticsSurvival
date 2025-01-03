extends Control


@onready var indicator = $"../Indicator"


func _ready() -> void:
	indicator.body_entered.connect(update_highlight)
	indicator.body_exited.connect(clear_highlight)

func clear_highlight(other: Node3D):
	$HighlightLabel.text = "Highlighted: N/A"

func update_highlight(other: Node3D):
	$HighlightLabel.text = "Highlighted: {0}".format([other.name])

func update_selection(other: Node3D):
	$SelectionLabel.text = "Selected: {0}".format(["N/A" if other == null else other.name])
