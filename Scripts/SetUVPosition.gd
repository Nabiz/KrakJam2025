extends MeshInstance3D

@export var LevelUVPosition: UVPosition = null
@export var draw_viewport: Viewport = null
@export var mask_viewport: Viewport = null

func _ready() -> void:
	LevelUVPosition.set_mesh(self)
	(mesh.surface_get_material(0) as ShaderMaterial).set_shader_parameter("Paint", draw_viewport.get_texture())
	(mesh.surface_get_material(0) as ShaderMaterial).set_shader_parameter("Mask", mask_viewport.get_texture())
	
