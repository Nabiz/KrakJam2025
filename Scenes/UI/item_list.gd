extends HFlowContainer

@export var Icon: PackedScene = null;
@export var numberOfEnemies: int:
	set(value):
		numberOfEnemies = value;
		invalidateCounter(value);
	get:
		return numberOfEnemies
		

func invalidateCounter(number: int):
	var count = self.get_child_count();
	if (Icon == null):
		return;
		
	var nodes = self.get_children();
	
	for node in nodes:
		node.queue_free()
		
	for n in number:
		self.add_child(Icon.instantiate());
			
		
		
