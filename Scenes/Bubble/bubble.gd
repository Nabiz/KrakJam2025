extends RigidBody3D

class_name Bubble;

const MIN_SCALE: float = 0.2;
const MAX_SCALE: float = 10.0;
var distortion: float = 1.0;
@onready var gfx: Node3D = $BubbleGFX;
@onready var collisionShape: CollisionShape3D = $CollisionShape3D;
@onready var bounceAudio: AudioStreamPlayer3D = $BounceAudio;
@onready var bounceAudioMob: AudioStreamPlayer3D = $MobBounceAudio;
@onready var explosionAudio: AudioStreamPlayer3D = $ExplosionAudio
@onready var catchAudio: AudioStreamPlayer3D = $CatchAudio
@onready var scoreAudio: AudioStreamPlayer = $ScoreAudio

var grabbedVisual: Node3D = null;

var bounces: int = 0;

func _ready():
	collisionShape.shape = SphereShape3D.new();
	targetScale = MIN_SCALE;

@export var targetScale: float = MIN_SCALE:
	set(value):
		if gfx and collisionShape:
			gfx.scale = Vector3.ONE * clamp(value, MIN_SCALE, MAX_SCALE);
			collisionShape.shape.radius = clamp(value, MIN_SCALE, MAX_SCALE) / 2;
	get():
		return gfx.scale.x;

func destroy():
	explosionAudio.play();
	EventBus.emit_signal("bubble_destroyed");
	#workaround to make audio play before being destroyed
	self.visible = false;
	explosionAudio.connect("finished", Callable(self, "queue_free"))


func score():
	EventBus.emit_signal("enemy_wiped");
	scoreAudio.play();
	#workaround to make audio play before being destroyed
	self.visible = false;
	scoreAudio.connect("finished", Callable(self, "queue_free"))

func _on_body_entered(body: Node):
	if body is Player and grabbedVisual == null:
		destroy();
		return;
	
	if body.is_in_group("ScoringArea") and grabbedVisual != null:
			score();
			return;
			
		
	if body.is_in_group("Catchable") and grabbedVisual == null:
		assert(body.has_method("getVisual"), "getVisual not defined. Items in catchable group have to have getVisual method implemented to access static placeholder when grabbed!")
		grabbedVisual = body.getVisual();
		grabbedVisual.reparent(self);
		body.queue_free();
		catchAudio.play();
		EventBus.emit_signal("enemy_grabbed");
		self.add_to_group("FullBubble");
		
		var tween = get_tree().create_tween()
		tween.tween_property(grabbedVisual, "position", Vector3.DOWN * 0.3, 0.8).set_trans(Tween.TRANS_SPRING)
		return;
	
	if (!body.is_in_group("Catchable") and grabbedVisual == null):
		bounceAudio.play();
		bounces = bounces + 1;
		
		if bounces > 3:
			destroy();
			
	if (grabbedVisual != null):
		bounceAudioMob.play();
