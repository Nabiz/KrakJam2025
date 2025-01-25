extends Area3D

func _ready():
	self.body_entered.connect(onBodyEntered)
	self.body_exited.connect(onBodyExited)
	
func onBodyEntered(body: Node):
	if body is Player:
		GameState.startLoading();

func onBodyExited(body: Node):
	if body is Player:
		GameState.stopLoading();
