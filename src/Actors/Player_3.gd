#refer player_2 

extends Actor

const Flame = preload("res://src/Objects/Flame_player.tscn")

# variables
var isAttacking = false;
var health = 100;
var heal = 50;
var damage = 20;
var disable = 0;
var die = 1
var spike = 1
export var stomp_impulse: = 2000.0

#signals:
signal health(health)
signal heal(heal)

func _on_Portal_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		PlayerInfo.current_score_save()
		get_tree().change_scene("res://src/levels/Title_screen/The_ENd.tscn")

func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "attack":
		disable = 1
		isAttacking = false
	if $AnimatedSprite.animation == "die":
		isAttacking = false
		get_tree().change_scene("res://src/levels/lvl3/GameOver_lvl3.tscn")
		
func _on_Death_body_entered(body: Node) -> void:
	life()
	
func _on_Spike_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		$player_on_spike.play()
		spike = 1
		while(spike):
			life()
			yield(get_tree().create_timer(.6),"timeout")

func _on_Spike_body_exited(body: Node) -> void:
	spike = 0

func _on_Snake_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		$snakehiss.play()
		life()
func _on_Stompdetecter_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	
func _on_Fall_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		die()
		
func _on_bomb_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		damage = 50
		life()

func _on_MEDS_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		heal()
		
func _on_Axe_kill():
	die()

func _on_Boulder_kill():
	die()

	
func _ready() -> void:
	PlayerInfo.current_score_load()
	PlayerInfo.load_data_3()
	global_position.y = 0
	global_position.x = 70 + PlayerInfo.checkpoint_pos_lvl3

func _physics_process(delta: float) -> void:
	
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0 # short jump interupt
	var direction: = get_direction()                                                       # find moving direction
	_velocity = calculate_move_velocity(_velocity,direction,speed, is_jump_interrupted)     
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)                                    # make move function  
	
	
	# Movement animation
	if _velocity.x != 0 and isAttacking == false:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = _velocity.x < 0
	elif _velocity.y < 0 and isAttacking == false:
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()
		$player_jump.play()
		$AnimatedSprite.flip_h = _velocity.y > 0
	# idle
	if _velocity.x == 0 and _velocity.y >= 0:
		if isAttacking == false:
			$AnimatedSprite.play("idle")
	# Attack
	if Input.is_action_just_pressed("Attack"):
		isAttacking = true
		if $AnimatedSprite.flip_h == false:
			$AttackArea/Right_attack.disabled = false
		elif  $AnimatedSprite.flip_h == true:
			$AttackArea/Left_attack.disabled = false
		$AnimatedSprite.play("attack")
		$player_attack.play()
	
	# Ranged Attack flame
	if Input.is_action_just_pressed("fire"):
		$flame_sound.play()
		var flame = Flame.instance()
		get_parent().add_child(flame)
		if $AnimatedSprite.flip_h == false:
			flame.dir = 1
			flame.position = $Crosshair_R.global_position
		if $AnimatedSprite.flip_h == true:
			flame.dir = -1
			flame.position = $Crosshair_L.global_position
			
	# Player's Health damage
	if Input.is_action_just_pressed("Health"):   # temporary
		pass
	
	# Player Healing
	if Input.is_action_just_pressed("heal"):     # temporary
		pass
		
	if disable == 1:
		$AttackArea/Right_attack.disabled = true
		$AttackArea/Left_attack.disabled = true
		disable = 0
		
	#die
	if $AnimatedSprite.animation != "die" and die == 0:
		get_tree().change_scene("res://src/levels/Title_screen/GameOver_lvl2.tscn")
	
	
	
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
	out.x = speed.x * direction.x * die
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y * die
	if is_jump_interrupted:
		out.y = 0.0
	return out 

func life() -> void:
	health = health - damage
	damage = 20
	emit_signal("health",health)
	if health <= 0:
		die()

func heal() -> void:
	health = health + heal
	health = min(health,100)
	emit_signal("heal",health)

func die():
	#return true
	die = 0
	$CollisionShape2D.disabled = true
	isAttacking = true
	$AnimatedSprite.animation = "die"
	$AnimatedSprite.play()
	$player_death.play()

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func Entered_checkpoint():
	PlayerInfo.load_data_3()
	PlayerInfo.checkpoint_pos_lvl3 = max(PlayerInfo.checkpoint_pos_lvl3 , global_position.x)
	PlayerInfo.save_data_3()

