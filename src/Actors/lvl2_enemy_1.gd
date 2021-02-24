extends Actor
signal enemy_1_died
var movement = 1
var dir = 1

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_Death_area_entered(area: Area2D) -> void:
	$CollisionShape2D.disabled = true
	_velocity.x = 0
	$AnimatedSprite.animation = "die"
	$AnimatedSprite.play()
	$enemy_death.play()
	emit_signal("enemy_1_died")

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

func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "die":
		queue_free()
	if $AnimatedSprite.animation == "attack":
		_velocity.x = speed.x * dir
		movement = 1
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if movement == 1:
		_velocity.x *= -1 if is_on_wall() else 1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = _velocity.x < 0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y





