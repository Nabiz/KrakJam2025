extends CenterContainer

func play():
	#$Control/GPUParticles2D.emitting = true;
	$AnimationPlayer.play("enter");
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_texture_button_pressed():
	GameState.startGame();
	$click.play();
