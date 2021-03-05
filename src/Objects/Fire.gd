extends KinematicBody2D

export (int) var Speed

var velocity = Vector2()
var dir = 1     #variable to get the player's position(right or left to enemy)

#trash the fire as player attacks the enemy with flame
func _on_flame__body_entered(body: Node) -> void:
	queue_free()

#trash the fire as it exits the screen
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

#flipping of enemy's fire according to player's position
func _physics_process(delta: float) -> void:
	velocity.x = Speed * delta * dir
	translate(velocity)
	$Sprite.flip_h = velocity.x < 0


