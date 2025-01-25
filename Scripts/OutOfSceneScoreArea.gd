extends Area3D

func _ready():
	self.body_exited.connect(onBodyExited)
	
func onBodyExited(body):
	if body is Bubble:
		if body.grabbedVisual != null:
			body.score();
		else:
			body.destroy();
