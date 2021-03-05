extends KinematicBody2D
signal kill

export var speed = Vector2(300.0,1000.0)
export var grav = 4000.0
var dir = -1
var velocity = Vector2.ZERO
const FLOOR_NORMAL = Vector2.UP

#restricting the boulder movement until player reaches the boulder
func _ready():
	set_physics_process(false)
	
#rolling of boulder as player gets near to it
func _physics_process(delta):
	velocity.y += grav * delta
	$AnimationPlayer.play("rolling")
	$rolling_sound.play()
	velocity.x = -speed.x
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y


#detection of player and emiting signal 'kill' when player dead
func _on_boulder_body_entered(body):
	if body.name == "Player_2":
		emit_signal("kill")

#trash the boulder as it is away from the screen
func _on_VisibilityNotifier2D_screen_exited():
	#queue_free()
	$rolling_sound.stop()

