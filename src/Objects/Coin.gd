extends Area2D


signal coin_collected

#bouncing of coin when the player collects it
func _on_Coin_body_entered(body):
	
	$AnimationPlayer.play("Bounce")
	emit_signal("coin_collected")
	set_collision_mask_bit(0,false)
	$soundcoincollect.play()
	

#trash the coin after being collected
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

