extends Actor
signal enemy_1_died
var movement = 1
var dir = 1       #initialisation of direction

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

# ***************************detection of player's attack **********************
func _on_Death_area_entered(area: Area2D) -> void:
	$CollisionShape2D.disabled = true
	_velocity.x = 0
	PlayerInfo.wave_dead += 1
	$AnimatedSprite.animation = "die"
	$AnimatedSprite.play()
	$enemy_death.play()
	emit_signal("enemy_1_died")


# *************************** initiation of attack *****************************
func _on_attackingArea_body_entered(body: Node) -> void:
	movement = 0
	if body.global_position.x < $CollisionShape2D.global_position.x:
		$AnimatedSprite.flip_h = true
		dir = -1
	else:
		$AnimatedSprite.flip_h = false
		dir = 1 
	_velocity.x = 400 * dir
	$AnimatedSprite.animation = "attack"
	$AnimatedSprite.play()
	$enemy_attack.play()


# *************************** execution of animation ***************************
func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "die":
		queue_free()
		
	if $AnimatedSprite.animation == "attack":
		_velocity.x = speed.x * dir
		movement = 1
	
	
# *************************** enemy's movement *********************************
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if movement == 1:
		_velocity.x *= -1 if is_on_wall() else 1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = _velocity.x < 0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if _velocity.x == 0:
		$attackingArea/left_attack.disabled = true
		$attackingArea/right_attack.disabled = true
		$Death/CollisionShape2D.disabled = true





