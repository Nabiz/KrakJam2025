extends Node

signal want_bubble_but_empty;
signal bubble_change;
signal end_of_bubble;
signal time_change;
signal time_end;
signal time_low;

signal start_loading;
signal stop_loading;

const ROUND_TIME = 180;
const LOW_TIME = 30;

# state
var bubbles: float = 100;
var time: int = ROUND_TIME;

var ticker = Timer.new();
var bubblesTicker = Timer.new();
var loadingTicker = Timer.new();

var haveBubbles:
	get():
		return bubbles > 0;

func _ready():
	add_child(ticker);
	add_child(bubblesTicker);
	add_child(loadingTicker);
	ticker.timeout.connect(_on_timer_timeout);
	bubblesTicker.timeout.connect(_on_bubbleTicker_timeout);
	loadingTicker.timeout.connect(_on_loadingTicker_timeout);

	ticker.start(1);
	
func startSpending():
	if haveBubbles:
		bubblesTicker.start(0.1);

func stopSpending():
	bubblesTicker.stop();
	
func startLoading():
	start_loading.emit()
	loadingTicker.start(0.1);
	
func stopLoading():
	stop_loading.emit()
	loadingTicker.stop();
	

func _on_timer_timeout():
	time -= 1;
	time_change.emit(time);
	
	if time < LOW_TIME:
		time_low.emit()
		
	if time <= 0:
		time_end.emit();
		ticker.stop();
	
	
func _on_bubbleTicker_timeout():
	bubble_change.emit(bubbles);
	if bubbles <= 0:
		end_of_bubble.emit();
		want_bubble_but_empty.emit();
		stopSpending()
	bubbles -= 0.5;
	

func _on_loadingTicker_timeout():
	bubble_change.emit(bubbles);
	if bubbles >= 100:
		bubbles = 100;
		stopLoading();
	bubbles += 5;
