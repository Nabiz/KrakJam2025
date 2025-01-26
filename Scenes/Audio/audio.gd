extends Node

@onready var mainMusic = $MainMusic;
@onready var lostMusic = $LostMusic;
@onready var winMusic = $WinMusic;

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.time_low.connect(onTimeLow);
	GameState.game_lost.connect(onGameLost);
	GameState.game_won.connect(onGameWin);
	pass;

func onTimeLow():
	mainMusic.pitch_scale = 1.1;

func onGameLost():
	var tween = get_tree().create_tween()
	tween.tween_property(mainMusic, "pitch_scale", 0.8, 1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(mainMusic.stop);
	tween.tween_callback(lostMusic.play);

func onGameWin():
	var tween = get_tree().create_tween()
	tween.tween_callback(mainMusic.stop);
	tween.tween_callback(winMusic.play);
