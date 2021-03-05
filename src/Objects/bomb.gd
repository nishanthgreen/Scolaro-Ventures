extends Area2D


#to play explosion animation as player enters the area of the bomb
func _on_bomb_body_entered(body):
	$explosion.play()
	$bomb_sound.play()
 

#trash the bomb as explosion gets over
func _on_explosion_animation_finished() -> void:
		queue_free()

