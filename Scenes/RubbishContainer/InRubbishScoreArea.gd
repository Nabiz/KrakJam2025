extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body is Bubble:
		if body.grabbedVisual != null:
			body.score();
		else:
			body.destroy();
