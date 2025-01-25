extends Node

signal bubble_change;
signal end_of_bubble;
signal time_change;

# state
var bubbles = 100;
var time = 180;

var ticker = Timer.new();

var bubblesTicker = Timer.new();

var haveBubbles:
	get():
		return bubbles > 0;

func _ready():
	add_child(ticker);
	add_child(bubblesTicker);
	ticker.timeout.connect(_on_timer_timeout);
	bubblesTicker.timeout.connect(_on_bubbleTicker_timeout);

	ticker.start(1);
	
func startSpending():
	bubblesTicker.start(0.1);
	print("start")

func stopSpending():
	bubblesTicker.stop();


func _on_timer_timeout():
	time -= 1;
	time_change.emit(time);
	print(time);
	
func _on_bubbleTicker_timeout():
	print(bubbles);
	bubble_change.emit(bubbles);
	if bubbles <= 0:
		end_of_bubble.emit();
		stopSpending()
	bubbles -= 1;
