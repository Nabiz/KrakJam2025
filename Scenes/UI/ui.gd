extends Control


@onready var bubbleMeter: TextureProgressBar = $BubbleMeter
@onready var timeLeft: Label = $TimeLeft

func _ready():
	bubbleMeter.value = GameState.bubbles;
	onTimeChange(GameState.time);
	GameState.bubble_change.connect(onBubbleChange)
	GameState.time_change.connect(onTimeChange)

func onBubbleChange(value: float):
	bubbleMeter.value = value;

func onTimeChange(value: int):
	var seconds = value%60
	var minutes = (value/60)%60
	
	timeLeft.text = "%2d:%02d" % [minutes, seconds]
	pass;
