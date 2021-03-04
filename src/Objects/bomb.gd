extends Area2D



func _on_bomb_body_entered(body):
	$explosion.play()
	$bomb_sound.play()
 



func _on_explosion_animation_finished() -> void:
	#if $explosion.animation== "explosion":
		queue_free()
