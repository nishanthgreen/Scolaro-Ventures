extends "res://src/Actors/Actor.gd"
onready var bullet_scene = preload("res://src/Objects/Bullet.tscn")  #To load the bulet scnene at the start of the node.
var target = null
onready var R_timer = get_node("Right_timer") # to load the timer name "R_timer" at the start of the node.
onready var L_timer = get_node("Left_timer")   # to load the timer name "L_timer" at the start of the node.


# To make the Spaceship move to rightside after an interval.
func _on_Right_timer_timeout():
	_velocity.x = speed.x



# To make the Spaceship move to leftside after an interval.
func _on_Left_timer_timeout():
	_velocity.x = -speed.x
	
	
	
#To detect wether the player entered the firing range, if so assigning the target.
func _on_Area2D_body_entered(body):
	if body.name == "Player_2":
		target = body
		$fireball_sound.play()
		
		
# To detect wether the player exited the firing range, if so assigning the target null.
func _on_Area2D_body_exited(body):
	if body == target:
		target = null
		$fireball_sound.stop()


#A function to fire the bullet.
func fire():
	var bullet = bullet_scene.instance()  #Instancing the bullet scene so that we can use its properties.
	bullet.position = get_global_position() #Getting the bullet position.
	bullet.target = target # Making the bullet travel to target's position.
	get_parent().add_child(bullet)
	$Gun_timer.set_wait_time(0.5)



#A function for fire rate of the bullet
func _on_Gun_timer_timeout():
	if target != null:
		fire()



func _ready()  -> void:
	_velocity.x = -speed.x #Setting the initial direction.
	R_timer.set_wait_time(2) # Setting wait time for "R_timer".
	R_timer.start() 
	L_timer.set_wait_time(4)  # Setting waiting time for "L_timer".
	L_timer.start()
	
func _physics_process(delta)  ->  void :
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


