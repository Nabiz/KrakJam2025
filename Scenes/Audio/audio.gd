extends Node

@onready var mainMusic = $MainMusic;

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.time_low.connect(onTimeLow);
	GameState.time_end.connect(onTimeEnd);
	pass;

func onTimeLow():
	mainMusic.pitch_scale = 1.1;

func onTimeEnd():
	var tween = get_tree().create_tween()
	tween.tween_property(mainMusic, "pitch_scale", 0.8, 1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(mainMusic.stop);
