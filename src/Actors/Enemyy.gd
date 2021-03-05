extends "res://src/Actors/Actor.gd"

signal enemy_died # to update score

#initially stop enemy movement
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
#when player stomp occurs enemy die animation is called (only happen stomped o head)
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > $StompDetector.global_position.y:
		return
	$StompDetector/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	_velocity.x = 0
	die()
	
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= -1 if is_on_wall() else 1 #change direction of enemy with respect to hit on wall
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
# *************************** HIT ANIMATION ********************************
	if _velocity.x != 0:
		$enemy.animation = "hit"
		$enemy.play()
		$enemy.flip_h = _velocity.x > 0

#enemy get trased when its death animation is end
	if $enemy.animation == "die":
		if $enemy.frame == 7:
			queue_free()
			emit_signal("enemy_died")
	"res://assets/sounds/pepSound4.ogg"

#function to play die animation
func die() -> void:
	$enemy.animation = "die"
	$soundsquash.play()
	$enemy.play()
	set_collision_mask_bit(0,false)









