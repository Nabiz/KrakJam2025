extends Node

var sceneLost = preload("res://Scenes/Outro/Outro.tscn");
var sceneWin = preload("res://Scenes/Outro/Win.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_lost.connect(onGameLost)
	GameState.game_won.connect(onGameWin)


func onGameLost():
	var outro = sceneLost.instantiate();
	self.add_child(outro);
	outro.play();

func onGameWin():
	var outro = sceneWin.instantiate();
	self.add_child(outro);
	outro.play();
