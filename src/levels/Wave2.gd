extends Node


var e_count = 0
export var e_limit = 8
var spawn_Rate = 2


export (Array, NodePath) var spawn_positions

var enemies = ["res://src/Actors/Enemyy.tscn", "res://src/Actors/Enemy_A.tscn", "res://src/Actors/lvl2_enemy_1.tscn", "res://src/Actors/lvl_2_Enemy.tscn" ] #[res://src/Actors/Enemyy.tscn, res://src/Actors/Enemy_A.tscn]

func _physics_process(delta):
	if e_count < e_limit:
		spawn_enemy()










func spawn_enemy():
	var enemy = load(enemies[8])
	var enemy_instance = enemy.instance()
	randomize()
	var spawn_point = randi() % spawn_positions.size()
	var sp = get_node(str("Spawn_points/#", spawn_point))
	
	add_child(enemy_instance)
	enemy_instance.position = sp.position
	$Spawn_rate.set_wait_time(spawn_Rate)
	e_count += 1
