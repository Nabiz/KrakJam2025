extends Area3D

func _ready():
	self.body_exited.connect(onBodyExited)
	
func onBodyExited(body):
	if body is Bubble:
		if body.grabbedVisual != null and body.is_in_group("Enemy"):
			body.score();
		else:
			body.destroy();
