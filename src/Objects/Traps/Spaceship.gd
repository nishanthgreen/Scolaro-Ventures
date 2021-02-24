extends "res://src/Actors/Actor.gd"
onready var bullet_scene = preload("res://src/Objects/Bullet.tscn")
var target = null
onready var R_timer = get_node("Right_timer")
onready var L_timer = get_node("Left_timer")

func _on_Right_timer_timeout():
	_velocity.x = speed.x

func _on_Left_timer_timeout():
	_velocity.x = -speed.x

func _on_Area2D_body_entered(body):
	if body.name == "Player_2":
		target = body
		$fireball_sound.play()
		
func _on_Area2D_body_exited(body):
	if body == target:
		target = null
		$fireball_sound.stop()

func fire():
	var bullet = bullet_scene.instance()
	bullet.position = get_global_position()
	bullet.target = target
	get_parent().add_child(bullet)
	$Gun_timer.set_wait_time(0.5)
	
func _on_Gun_timer_timeout():
	if target != null:
		fire()

func _ready()  -> void:
	_velocity.x = -speed.x
	R_timer.set_wait_time(2)
	R_timer.start()
	L_timer.set_wait_time(4)
	L_timer.start()
	
func _physics_process(delta)  ->  void :
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


