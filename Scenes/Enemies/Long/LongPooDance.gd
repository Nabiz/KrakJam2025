extends CharacterBody3D


const SPEED = 1.0
const JUMP_VELOCITY = 4.5

@export var LevelUVPosition: UVPosition = null
@export var draw_viewport: Viewport = null
@export var mask_viewport: Viewport = null

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var poo_emiter: PaintEmitter = $PaintEmitter
@onready var gfx: Node3D = $GFX;

@onready var audioFart: AudioStreamPlayer3D = $AudioFart

@onready var agent: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	#set_new_target()
	animation.play("dance");
	animation.seek(randf());
	poo_emiter.LevelUVPosition = self.LevelUVPosition
	poo_emiter.draw_viewport = self.draw_viewport
	poo_emiter.mask_viewport = self.mask_viewport

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	#wander()
#
#func wander():
	#var look_pos = Vector3(agent.target_position.x, global_position.y, agent.target_position.z)
	#if not global_transform.origin.is_equal_approx(look_pos):
		#look_at(look_pos)
	#var destination = agent.get_next_path_position()
	#var local_destination = destination - global_position
	#var direction = local_destination.normalized()
	#
	#velocity = direction * SPEED
	#move_and_slide()
	

func emit_paint():
	poo_emiter.emit_single_paint();
	#audioFart.play();
	
#
func getVisual():
	return gfx;
	
	
#func get_random_reachable_target() -> Vector3:
	#var nav_map = agent.get_navigation_map()
	#var start_pos = global_position
#
	#for i in range(10):  # Try multiple times for a valid point
		#var random_offset = Vector3(randf_range(-10, 10), 0,randf_range(-10, 10))
		#var random_target = start_pos + random_offset
		#
		#var closest_point = NavigationServer3D.map_get_closest_point(nav_map, random_target)
#
		#if closest_point != Vector3.ZERO and (closest_point - random_target).length() < 10:
			#return closest_point
	#return start_pos  # Fallback to current position if no valid point found
#
#
#func set_new_target():
	#var target_position = get_random_reachable_target()
	#agent.set_target_position(target_position)
#
#func _on_navigation_agent_3d_navigation_finished() -> void:
	#set_new_target()
	#$Timer.stop()
	#$Timer.wait_time = 3
	#$Timer.start()
