extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.start_loading.connect(self.play)
	GameState.stop_loading.connect(self.stop)
