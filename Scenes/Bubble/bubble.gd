extends RigidBody3D

class_name Bubble;

const MIN_SCALE: float = 0.2;
const MAX_SCALE: float = 10.0;
var distortion: float = 1.0;
@onready var gfx: Node3D = $BubbleGFX;
@onready var collisionShape: CollisionShape3D = $CollisionShape3D;

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
	EventBus.emit_signal("bubble_destroyed");
	self.queue_free();

func _on_body_entered(body: Node):
	if body is Player and grabbedVisual == null:
		destroy();
		return;

		
	if body.is_in_group("Catchable") and grabbedVisual == null:
		assert(body.has_method("getVisual"), "getVisual not defined. Items in catchable group have to have getVisual method implemented to access static placeholder when grabbed!")
		grabbedVisual = body.getVisual();
		grabbedVisual.reparent(self);
		body.queue_free();
		
		EventBus.emit_signal("enemy_grabbed");
		self.add_to_group("FullBubble");
		
		var tween = get_tree().create_tween()
		tween.tween_property(grabbedVisual, "position", Vector3.DOWN * 0.3, 0.8).set_trans(Tween.TRANS_SPRING)
	
	if (!body.is_in_group("Catchable") and grabbedVisual == null):
		bounces = bounces + 1;
		
		if bounces > 3:
			destroy();
