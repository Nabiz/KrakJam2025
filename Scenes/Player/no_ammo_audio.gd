extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.want_bubble_but_empty.connect(self.play)
