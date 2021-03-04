extends KinematicBody2D
signal kill
signal exited

func _physics_process(delta):
	$AnimationPlayer.play("ping_pong")


func _on_Killing_area_body_entered(body):
	$axe_sound.play()
	if body.name == "Player_2":
		emit_signal("kill")


func _on_Killing_area_body_exited(body):
	$axe_sound.stop()
	emit_signal("exited")
