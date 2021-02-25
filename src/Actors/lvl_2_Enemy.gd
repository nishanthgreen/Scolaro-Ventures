extends "res://src/Actors/Actor.gd"

const PROJECTILE_SCENE = preload("res://src/Objects/Fire.tscn")
signal witch_died
var flame
var dir = 1
var dead = false
var disable = 0

func _on_Freeze_body_entered(body: Node) -> void:
	disable = 1
	
	
func _on_death_area_entered(area: Area2D) -> void:
	die()
	emit_signal("witch_died")

func _on_enemy_animation_finished() -> void:
	if $enemy.animation == "die":
		queue_free()

func _on_Right_body_entered(body: Node) -> void:
	_velocity.x = 0
	$enemy.flip_h = true
	dir = -1
	projectile_fire()
	
	
func _on_Left_body_entered(body: Node) -> void:
	_velocity.x = 0
	$enemy.flip_h = false
	dir = 1
	projectile_fire()

	
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x 

	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	_velocity.x *= -1  if is_on_wall() else 1
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
# *************************** WALK ANIMATION ********************************
	if _velocity.x != 0 and dead == false:
		$enemy.animation = "walk"
		$enemy.play()
		$enemy.flip_h = _velocity.x > 0
	
	if _velocity.x == 0 and dead == false:
		$enemy.animation = "attack"
		$enemy.play()
		$enemy_2_attack.play()
		
	if disable == 1:
		$Right/right.disabled = true
		$Left/left.disabled   = true
		yield(get_tree().create_timer(3),"timeout")
		disable = 0

	if disable == 0:
		$Right/right.disabled = false
		$Left/left.disabled   = false
	
func projectile_fire():
	flame = PROJECTILE_SCENE.instance()
	get_parent().add_child(flame)
	if $enemy.flip_h == false:
		flame.dir = -1
		flame.position = $crosshair_l.global_position
	if $enemy.flip_h == true:
		flame.dir = 1
		flame.position = $crosshair_r.global_position
	yield(get_tree().create_timer(.5),"timeout")
	_velocity.x = speed.x * dir 


func die() -> void:
	dead = true
	_velocity.x = 0
	$enemy.animation ="die"
	$enemy.play()
	$enemy_2_death.play()







































