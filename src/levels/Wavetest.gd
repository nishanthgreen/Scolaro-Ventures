extends Node


var wave = 0
var sub_wave = 0
export (int) var wave_limit

export (Array, NodePath) var spawn_positions

#list of enemies with spawn rate
var enemies = []
var enemy_rate = [1, 2]
#Enemy count is  how many in sub wave. Enemy type is type of enmey in sub wave
export (Array, Array, int) var enemy_count
export (Array, Array, int) var enemy_type

#enemy amount will get the value of enemy counter that we want from the array
var enemy_amount = null

func spawn_wave():
	

