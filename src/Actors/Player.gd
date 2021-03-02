extends Actor

export var stomp_impulse: = 2000.0

export var spring: = 4000


func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_die_body_entered(body: Node) -> void:
	get_tree().change_scene("res://src/levels/Title_screen/GameOver.tscn")

	
func _on_Fall_body_entered(body: Node) -> void:
	get_tree().change_scene("res://src/levels/Title_screen/GameOver.tscn")

func _on_Portal_body_entered(body: Node) -> void:
	PlayerInfo.Portal_status = 2
	PlayerInfo.portal_save()
	get_tree().change_scene("res://src/levels/level_2.tscn")
	
	
func _on_Spring_body_entered(body: Node) -> void:
	_velocity.y = -spring
	
func _on_Portal_body_entered_lvl_0(body: Node) -> void:
	PlayerInfo.Portal_status = 1
	PlayerInfo.portal_save()
	get_tree().change_scene("res://src/levels/Title_screen/Title_menu.tscn")

func _ready() -> void:
	PlayerInfo.portal_load()
	if PlayerInfo.Portal_status == 1:
		PlayerInfo.load_data()
		global_position.x = PlayerInfo.checkpoint_pos_lvl1 + 100
	if PlayerInfo.Portal_status == 0:
		global_position.x = 128
		

func _physics_process(delta: float) -> void:
	
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0 # short jump interupt
	var direction: = get_direction()                                                      # find moving direction
	_velocity = calculate_move_velocity(_velocity,direction,speed, is_jump_interrupted)     
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)                                     # make move function  
	
	
	#*************************** Movement animation *****************************
	if _velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = _velocity.x < 0
	elif _velocity.y < 0 :
		$AnimatedSprite.animation = "jump"
		$soundjump.play()
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = _velocity.y > 0
		
	if _velocity.x == 0:
		$AnimatedSprite.stop()
	#**************************************************************************** 
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y 
	if is_jump_interrupted:
		out.y = 0.0
	return out 
	
func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func Entered_checkpoint():
	PlayerInfo.load_data()
	PlayerInfo.checkpoint_pos_lvl1 = max(PlayerInfo.checkpoint_pos_lvl1 , global_position.x)
	PlayerInfo.save_data()

































