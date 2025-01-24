extends CharacterBody3D

class_name Player;

@export_subgroup("Movement")
@export var SPEED = 5
@export var JUMP_VELOCITY = 5

@onready var camera = $Camera3D;
@onready var weapon = $Weapon;
@onready var blowingArea = $Weapon/BlowingArea;
@onready var bubbleSpawnPoint: Marker3D = $Weapon/BubbleSpawnPoint;

@export var blowing: bool = false:
	set(enabled):
		if enabled:
			blowingArea.process_mode = PROCESS_MODE_INHERIT;
		else:
			blowingArea.process_mode = PROCESS_MODE_DISABLED;
	get():
		return blowingArea.process_mode == PROCESS_MODE_INHERIT;
		

var mouse_sensitivity = 700
var gamepad_sensitivity := 0.075

var mouse_captured := true

var movement_velocity: Vector3
var rotation_target: Vector3
var input_mouse: Vector2

func _ready():
	blowingArea.process_mode = PROCESS_MODE_DISABLED;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion and mouse_captured:
		input_mouse = event.relative / mouse_sensitivity
		
		rotation_target.y -= event.relative.x / mouse_sensitivity
		rotation_target.x -= event.relative.y / mouse_sensitivity
	
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
	if Input.is_action_just_pressed("Blow"):
		self.blowing = true;
	
	if Input.is_action_just_released("Blow"):
		self.blowing = false;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Rotation
	camera.rotation.z = lerp_angle(camera.rotation.z, -input_mouse.x * 25 * delta, delta * 5)	
	camera.rotation.x = lerp_angle(camera.rotation.x, rotation_target.x, delta * 25)
	weapon.rotation.z = camera.rotation.z;
	weapon.rotation.x = camera.rotation.x;
	
	rotation.y = lerp_angle(rotation.y, rotation_target.y, delta * 25)
	

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
