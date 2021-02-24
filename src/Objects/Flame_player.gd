extends KinematicBody2D


const Speed = 250
var velocity = Vector2()
var dir = 1

func _on_flame_body_entered(body: Node) -> void:
	queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	velocity.x = Speed * delta * dir
	translate(velocity)
	$AnimatedSprite.play("fire")
	
	if dir == 1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false









