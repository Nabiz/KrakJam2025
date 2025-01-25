extends Control


@onready var bubbleMeter: TextureProgressBar = $BubbleMeter
@onready var timeLeft: Label = $TimeLeft


var pos = Vector2.ZERO;

func _ready():
	pos = bubbleMeter.position;
	bubbleMeter.value = GameState.bubbles;
	onTimeChange(GameState.time);
	GameState.bubble_change.connect(onBubbleChange)
	GameState.time_change.connect(onTimeChange)
	GameState.want_bubble_but_empty.connect(bump);

func onBubbleChange(value: float):
	bubbleMeter.value = value;

func onTimeChange(value: int):
	var seconds = value%60
	var minutes = (value/60)%60
	
	timeLeft.text = "%2d:%02d" % [minutes, seconds]
	pass;

func bump():
	var tween = get_tree().create_tween();
	tween.tween_property(bubbleMeter, "position", pos + Vector2.DOWN * 10, 0.2).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(bubbleMeter, "position", pos, 0.2).set_trans(Tween.TRANS_SPRING)
