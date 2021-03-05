extends KinematicBody2D
signal kill
signal exited

#playing of axe-movement animation as level begins
func _physics_process(delta):
	$AnimationPlayer.play("ping_pong")

#detection of player entered and emiting a signal 'kill'
func _on_Killing_area_body_entered(body):
	
	if body.name == "Player_2":
		emit_signal("kill")

#emiting of signal 'exited' as player exit from the axe
func _on_Killing_area_body_exited(body):
	
	emit_signal("exited")
