extends "res://src/Actors/Actor.gd"
signal enemy_A_died
var score = 0

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

# *************************** detection of player's attack *********************
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	
	$StompDetector/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	_velocity.x = 0
	set_collision_mask_bit(1,false)
	die()
	
	
# *************************** enemy's movement *********************************
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= -1 if is_on_wall() else 1
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
# *************************** HIT ANIMATION ************************************
	if _velocity.x != 0:
		$enemy.animation = "attack"
		$enemy.play()
		$enemy.flip_h = _velocity.x > 0
# *************************** MAKE ENEMY OUT FROM WORLD  ***********************
	if $enemy.animation == "die":
		if $enemy.frame == 6:
			queue_free()
			
	
# *************************** enemy's death ************************************
func die() -> void:
	PlayerInfo.wave_dead += 1
	$enemy.animation = "die"
	$enemy.play()
	$enemysquah.play()

