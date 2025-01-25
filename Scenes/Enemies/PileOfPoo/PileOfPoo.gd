extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5

@export var LevelUVPosition: UVPosition = null
@export var draw_viewport: Viewport = null
@export var mask_viewport: Viewport = null

@export var target_node: Node3D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var poo_emiter: PaintEmitter = $PaintEmitter
@onready var gfx: Node3D = $GFX;

@onready var audioFart: AudioStreamPlayer3D = $AudioFart

func _ready() -> void:
	animation.play("Jumping");
	animation.seek(randf());
	poo_emiter.LevelUVPosition = self.LevelUVPosition
	poo_emiter.draw_viewport = self.draw_viewport
	poo_emiter.mask_viewport = self.mask_viewport

func _physics_process(delta: float) -> void:
	look_at(target_node.position)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var velocity_x = (target_node.global_position.x-self.global_position.x)
	var velocity_z = (target_node.global_position.z-self.global_position.z)
	var vector_xz = Vector2(velocity_x, velocity_z).normalized()
	velocity.x = vector_xz.x * SPEED
	velocity.z = vector_xz.y * SPEED

	move_and_slide()

func emit_paint():
	poo_emiter.emit_single_paint();
	audioFart.play();
	
#
func getVisual():
	return gfx;
	
