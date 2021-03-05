extends KinematicBody2D

#variables
var move = Vector2.ZERO
var look_vec = Vector2.ZERO      #variable to calculate the position of the player
var target = null
export var speed = 300

#to get the current position of the moving player
func _ready():
	look_vec = target.position - global_position
	
#to update the current position
func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed *delta
	position += move

#trash the bullet as it exits the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

