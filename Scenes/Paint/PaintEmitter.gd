class_name PaintEmitter
extends Node3D
 
@export var paint_scene: PackedScene
@export var speed_variance: float = 1.0
@export var rotation_variance: float = 5.0
 
@export var emit := true
 
var rng = RandomNumberGenerator.new()
 
@export var LevelUVPosition: UVPosition = null
@export var draw_viewport: Viewport = null
@export var mask_viewport: Viewport = null

@export var number: int = 1

func inject_to_paint_scene(p):
	p.set_viewport(draw_viewport)
	p.set_leveluv(LevelUVPosition)
	p.set_mask(mask_viewport)

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

func emit_single_paint():
		var p = paint_scene.instantiate() as CharacterBody3D
		inject_to_paint_scene(p) # DODANE PRZEZ DAWIDA
		add_child(p)
		#p.speed += rng.randf_range(0.0, speed_variance)
		p.global_position = global_position
		p.global_rotation = global_rotation
		#p.rotate_x(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
		#p.rotate_y(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
		#p.set_start_velocity()
