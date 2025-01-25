class_name PaintEmitter
extends Node3D
 
@export var paint_scene: PackedScene
@export var speed_variance: float = 1.0
@export var rotation_variance: float = 5.0
@export var is_splash: bool = true
 
@export var emit := true
@export var is_cleaner := false
 
var rng = RandomNumberGenerator.new()
 
@export var LevelUVPosition: UVPosition = null
@export var draw_viewport: Viewport = null
@export var mask_viewport: Viewport = null

@export var number: int = 1
@export var particle_visible: bool = false

func _ready() -> void:
	if is_cleaner:
		$Timer.wait_time = 0.1

func inject_to_paint_scene(p):
	p.set_viewport(draw_viewport)
	p.set_leveluv(LevelUVPosition)
	p.set_mask(mask_viewport)
	if "is_splash" in p:
		p.set_particle_visibility(particle_visible)
		p.is_splash = is_splash

func _on_timer_timeout():
	if emit:
		for i in range(number):
			var p = paint_scene.instantiate() as CharacterBody3D
			inject_to_paint_scene(p) # DODANE PRZEZ DAWIDA
			add_child(p)
			p.speed += rng.randf_range(0.0, speed_variance)
			p.global_position = global_position
			p.global_rotation = global_rotation
			p.rotate_x(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
			p.rotate_y(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
			p.set_start_velocity()

func emit_single_paint(is_throwed: bool = false):
		var p = paint_scene.instantiate() as CharacterBody3D
		inject_to_paint_scene(p) # DODANE PRZEZ DAWIDA
		add_child(p)
		p.global_position = global_position
		p.global_rotation = global_rotation
		if is_throwed:
			p.speed += rng.randf_range(0.0, speed_variance)
			p.rotate_x(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
			p.rotate_y(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
			p.set_start_velocity()
