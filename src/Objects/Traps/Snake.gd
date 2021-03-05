extends Area2D

#snake animation being idle when the player enters the detection area
func _on_Detection_area_body_entered(body):
	if body.name == "player_2":
		$snake.play("Appear")
		if $snake.frame == 0:
			$snake.play("Idle")

#snake animation being idle when the player exit the detection area
func _on_Detection_area_body_exited(body):
	$snake.play("Idle")
	
#snake attacks as player enters the attacking area 
func _on_Snake_body_attack_area_entered(body):
	if body.name == "Player_2":
		$snake.play("Attack")

#trash the snake as attacking the player is completed
func _on_snake_animation_finished() -> void:
	if $snake.animation == "Attack":
		queue_free()

func _ready():
	$snake.play("Appear")
	if $snake.frame == 0:
		$snake.stop()
		
