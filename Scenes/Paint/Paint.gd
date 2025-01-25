extends CharacterBody3D

@export var color: Color = Color.SADDLE_BROWN
@export var speed = 5.0
@export var is_splash: bool = true

var LevelUVPosition: UVPosition = null
var draw_viewport: Viewport = null
var mask_viewport: Viewport = null

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_start_velocity():
	velocity = (global_transform.basis * Vector3.FORWARD).normalized() * speed

func set_viewport(v: Viewport):
	draw_viewport = v

func set_mask(v: Viewport):
	mask_viewport = v

func set_leveluv(uv_pos: UVPosition):
	LevelUVPosition = uv_pos

func set_particle_visibility(v: bool):
	if v:
		$View.show()
	else:
		$View.hide()

func _physics_process(delta):
	velocity.y -= gravity * delta
	look_at(position + velocity)

	move_and_slide()
	
	if get_slide_collision_count() > 0:
		for i in range(0, get_slide_collision_count()):
			var col = get_slide_collision(i)
			var uv = LevelUVPosition.get_uv_coords(col.get_position(), col.get_normal(), true)
			if uv:
				if is_splash:
					draw_viewport.paint_splash(uv, color)
					mask_viewport.paint_splash(uv, Color(0.9,0.9,0.9))
				else:
					draw_viewport.paint_soft(uv, color)
					mask_viewport.paint_soft(uv, Color(0.9,0.9,0.9))
		queue_free()
