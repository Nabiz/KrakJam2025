extends Node3D


func _ready() -> void:
	add_to_group("Catchable")

func getVisual():
	var gfx = get_child(0)
	if gfx and gfx is MeshInstance3D:
		return gfx
