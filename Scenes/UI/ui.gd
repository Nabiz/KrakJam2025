extends Control


@onready var bubbleMeter: TextureProgressBar = $BubbleMeter

func _ready():
	bubbleMeter.value = GameState.bubbles;
	
	GameState.bubble_change.connect(onBubbleChange)

func onBubbleChange(value: float):
	bubbleMeter.value = value;
