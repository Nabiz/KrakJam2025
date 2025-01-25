extends CharacterBody3D

@export var color: Color = Color.SADDLE_BROWN
@export var speed = 5.0

var LevelUVPosition: UVPosition = null
var draw_viewport: Viewport = null

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_start_velocity():
	velocity = (global_transform.basis * Vector3.FORWARD).normalized() * speed

func set_viewport(v: Viewport):
	draw_viewport = v

func set_leveluv(uv_pos: UVPosition):
	LevelUVPosition = uv_pos

func _physics_process(delta):
	velocity.y -= gravity * delta
	look_at(position + velocity)

	move_and_slide()
	
	if get_slide_collision_count() > 0:
		for i in range(0, get_slide_collision_count()):
			var col = get_slide_collision(i)
			var uv = LevelUVPosition.get_uv_coords(col.get_position(), col.get_normal(), true)
			if uv:
				draw_viewport.paint(uv, color)
		queue_free()
