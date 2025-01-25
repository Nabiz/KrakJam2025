extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5

@export var target_node: Node3D
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation.play("Jumping")

func _physics_process(delta: float) -> void:
	look_at(target_node.position)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity = SPEED * (target_node.global_position-self.global_position).normalized()

	move_and_slide()
