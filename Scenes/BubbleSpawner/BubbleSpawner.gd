extends Node

@export var player: Player;
@export var Bubble: PackedScene;

@export var blowingSpeed: float = 0.1;
@onready var audioRelease: AudioStreamPlayer = $AudioRelease
@onready var audioInflate: AudioStreamPlayer = $AudioInflate
var spawning: bool = false;

var currentBubble: Bubble = null;

func getDirection():
	return (player.bubbleSpawnPoint.global_position - player.global_position).normalized();
	
func _ready():
	GameState.end_of_bubble.connect(stopInflation);

func _process(delta):
	if currentBubble:
		var direction = getDirection();
		currentBubble.global_position = player.bubbleSpawnPoint.global_position + direction * currentBubble.targetScale;
		currentBubble.look_at(currentBubble.global_position + direction);

func _input(event):
	if event.is_action_pressed("Spawn"):
		startInflation();
	if event.is_action_released("Spawn"):
		stopInflation();

func startInflation():
	if !GameState.haveBubbles:
		return;
		
	GameState.startSpending();

	audioInflate.play();
	currentBubble = Bubble.instantiate();
	currentBubble.distortion = 2.0;
	add_child(currentBubble);
	
func stopInflation():
	if currentBubble == null:
		return;
	
	GameState.stopSpending();
	audioInflate.stop();
	audioRelease.play();
	currentBubble.apply_force(getDirection() * 0.2);
	currentBubble.distortion = 1.0;
	currentBubble = null;

func _physics_process(delta):
	if currentBubble:
		currentBubble.targetScale = lerpf(currentBubble.targetScale, currentBubble.MAX_SCALE, blowingSpeed * delta);
		
