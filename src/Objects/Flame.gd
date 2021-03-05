extends Area2D

const Speed = 250      #speed at which flame is thrown by player
var velocity = Vector2()
var dir = 1            #variable to get the position of enemy (whether at right or left)

#trash the flame as it exits from the screen 
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

#trash the flame as it enters the enemy's body
func _on_Flame_body_entered(body: Node) -> void:
	queue_free()

#attacking using flame based on velocity and direction of enemy
func _physics_process(delta: float) -> void:
	velocity.x = Speed * delta * dir
	translate(velocity)
	$AnimatedSprite.play("fire")
	$flame_sound.play()
	
	if dir == 1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false


