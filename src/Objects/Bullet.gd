extends KinematicBody2D


var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var target = null
export var speed = 300

func _ready():
	look_vec = target.position - global_position
	
	

func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed *delta
	position += move



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
