#refer enemyy.gd

extends "res://src/Actors/Actor.gd"

signal enemy_died


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	#if body.global_position.y > $StompDetector.global_position.y:
		#return
	$StompDetector/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	_velocity.x = 0
	die()
	

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= -1 if is_on_wall() else 1
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	

	if _velocity.x != 0:
		$enemy.animation = "hit"
		$enemy.play()
		$enemy.flip_h = _velocity.x > 0

	if $enemy.animation == "die":
		if $enemy.frame == 7:
			queue_free()
			emit_signal("enemy_died")
	"res://assets/sounds/pepSound4.ogg"


func die() -> void:
	$enemy.animation = "die"
	$soundsquash.play()
	$enemy.play()
	set_collision_mask_bit(0,false)


