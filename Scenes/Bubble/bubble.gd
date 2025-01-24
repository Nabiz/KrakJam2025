extends RigidBody3D

class_name Bubble;

const MIN_SCALE: float = 0.2;
const MAX_SCALE: float = 10.0;
var distortion: float = 1.0;
@onready var gfx: Node3D = $BubbleGFX;
@onready var collisionShape: CollisionShape3D = $CollisionShape3D;

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
