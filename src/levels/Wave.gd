extends Node2D

onready var skeleton_enemy = preload("res://src/Actors/Wave_enemies/Enemyy_wave.tscn")
onready var giant_enemy = preload("res://src/Actors/Wave_enemies/Enemy_A_wave.tscn")
onready var armored_enemy = preload("res://src/Actors/Wave_enemies/lvl2_enemy_1_wave.tscn")
onready var witch_enemy = preload("res://src/Actors/Wave_enemies/lvl_2_Enemy_wave.tscn")

signal score

var e_count = 0
export var e_limit = 7
export var spawn_Rate = 3
var disable = true
var detect_disable = false

func _ready():
	$Left/Left_wall.disabled = true
	#$Right/right_wall.disabled = true

func _physics_process(delta):
	if disable == false:
		$Left/Left_wall.disabled = false
	
	if detect_disable == true:
		$Left/Left_area/Left_detect.disabled = true
	
func spawn():
	#var enemies = [skeleton, giant, armored, witch]
	for i in range(e_limit):
		e_count += 1
		var a = randi() % 3+1
		
		if a == 1:
			var skeleton = skeleton_enemy.instance()
			
			#$Spawn_rate.set_wait_time(spawn_Rate)
			yield(get_tree().create_timer(4),"timeout")
			add_child(skeleton)
			skeleton.position = $Sp.position
			
		if a == 2:
			var giant = giant_enemy.instance()
			yield(get_tree().create_timer(4),"timeout")
			add_child(giant)
			giant.position = $Sp.position
			
		if a == 3:
			var armored = armored_enemy.instance()
			yield(get_tree().create_timer(4),"timeout")
			add_child(armored)
			armored.position = $Sp.position
			
		if a == 4:
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
		emit_signal("score")

func _on_Left_area_body_exited(body):
	if body.name == "Player_2":
		disable = false
		$Wait.visible = true
		$Sprite.visible = true
		detect_disable = true
		spawn()
