extends Area2D

var x: = 0

func _on_Spring_body_entered(body: Node) -> void:
	
	x = 1


func _physics_process(delta: float) -> void:
	if x == 1:
		$AnimatedSprite.animation = "spring"
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	

	






