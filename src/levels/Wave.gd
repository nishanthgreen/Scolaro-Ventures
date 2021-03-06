extends Node2D

#loading and assigning the enemies scene to the variable at the start of the node.

onready var skeleton_enemy = preload("res://src/Actors/Wave_enemies/Enemyy_wave.tscn")       
onready var giant_enemy = preload("res://src/Actors/Wave_enemies/Enemy_A_wave.tscn")
onready var armored_enemy = preload("res://src/Actors/Wave_enemies/lvl2_enemy_1_wave.tscn")
onready var witch_enemy = preload("res://src/Actors/Wave_enemies/lvl_2_Enemy_wave.tscn")

signal score

var e_count = 0 # to count no. of enemies.

export var e_limit = 7 # limiting no. of enemies.

export var spawn_Rate = 3 # Spawning enemies at this rate.
var disable = true # Wall collisionshape disbaling variable.
var detect_disable = false # wave starting collision shape disabling variable.

#disabling left and right wall, so that palyer can pass through
func _ready():
	$Left/Left_wall.disabled = true
	#$Right/right_wall.disabled = true


# enabling the left and right wall, so that player can't pass through.
func _physics_process(delta):
	if disable == false:
		$Left/Left_wall.disabled = false
	
	if detect_disable == true:
		$Left/Left_area/Left_detect.disabled = true


# function to spawn the enemies.

func spawn():
	
	
	#spawning till the e_limit.
	
	for i in range(e_limit):
		e_count += 1
		var a = randi() % 3+1 # to randomize the spawning.
		
		if a == 0:
			var skeleton = skeleton_enemy.instance()
			
			#$Spawn_rate.set_wait_time(spawn_Rate)
			yield(get_tree().create_timer(4),"timeout")
			add_child(skeleton)
			skeleton.position = $Sp.position
			
		if a == 1:
			var giant = giant_enemy.instance()
			yield(get_tree().create_timer(4),"timeout")
			add_child(giant)
			giant.position = $Sp.position
			
		if a == 2:
			var armored = armored_enemy.instance()
			yield(get_tree().create_timer(4),"timeout")
			add_child(armored)
			armored.position = $Sp.position
			
		if a == 3:
			var witch = witch_enemy.instance()
			yield(get_tree().create_timer(4),"timeout")
			add_child(witch)
			witch.position = $Sp.position

	if e_count == e_limit:
		yield(get_tree().create_timer(2),"timeout")
		$Wait.visible = false
		$Go.visible = true
		$Sprite.visible = false
		$Right/right_wall.disabled = true
		$Left/Left_wall.disabled = true
		emit_signal("score")


# to detect whether the player exited the region
func _on_Left_area_body_exited(body):
	if body.name == "Player_2":
		disable = false
		$Wait.visible = true
		$Sprite.visible = true
		detect_disable = true
		spawn()
