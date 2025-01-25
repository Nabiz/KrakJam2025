extends SubViewport
 
@onready var brush: Node2D = $BrushSplash
@onready var soft_brush: Node2D = $BrushSoft
 
func paint_splash(position : Vector2, colour: Color = Color(1, 1, 1)):
	brush.queue_brush(position * 2048, colour)

func paint_soft(position : Vector2, colour: Color = Color(1, 1, 1)):
	soft_brush.queue_brush(position * 2048, colour)
