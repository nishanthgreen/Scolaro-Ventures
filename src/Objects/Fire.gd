extends KinematicBody2D

export (int) var Speed

var velocity = Vector2()
var dir = 1

func _on_flame__body_entered(body: Node) -> void:
	queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	velocity.x = Speed * delta * dir
	translate(velocity)
	$Sprite.flip_h = velocity.x < 0


