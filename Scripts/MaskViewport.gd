extends SubViewport
 
@onready var brush: Node2D = $Brush
@onready var clean_brush: Node2D = $CleanBrush
 
func paint(position : Vector2, colour: Color = Color(1, 1, 1)):
	brush.queue_brush(position * 2048, colour)

func clean(position : Vector2, colour: Color = Color(1, 1, 1)):
	clean_brush.queue_brush(position * 2048, Color(1,1,1))
