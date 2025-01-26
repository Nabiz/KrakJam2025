extends TextureButton



func _on_pressed():
	$click.play();
	GameState.start_game.emit();



func _on_mouse_entered():
	$hover.play();
