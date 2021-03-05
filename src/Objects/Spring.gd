extends Area2D

var x: = 0      #to initialize the starting idle position of spring

func _on_Spring_body_entered(body: Node) -> void:
	x = 1             #to notify when the player is on the spring


#spring movement based on position of player on/off the spring
func _physics_process(delta: float) -> void:
	if x == 1:
		$AnimatedSprite.animation = "spring"
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	
