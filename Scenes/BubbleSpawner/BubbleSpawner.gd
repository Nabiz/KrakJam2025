extends Node

@export var player: Player;
@export var Bubble: PackedScene;

@export var blowingSpeed: float = 0.1;
var spawning: bool = false;

var currentBubble: Bubble = null;

func _process(delta):
	if currentBubble:
		var direction = (player.bubbleSpawnPoint.global_position - player.global_position).normalized()
		currentBubble.global_position = player.bubbleSpawnPoint.global_position + direction * currentBubble.targetScale;
		currentBubble.look_at(currentBubble.global_position + direction);

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			currentBubble = Bubble.instantiate();
			currentBubble.distortion = 2.0;
			add_child(currentBubble);
		else:
			currentBubble.distortion = 1.0;
			currentBubble = null;

func _physics_process(delta):
	if currentBubble:
		currentBubble.targetScale = lerpf(currentBubble.targetScale, currentBubble.MAX_SCALE, blowingSpeed * delta);
		
