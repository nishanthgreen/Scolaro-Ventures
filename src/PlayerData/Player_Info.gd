extends Node


var checkpoint_pos_lvl1 = 0
var checkpoint_pos_lvl2 = 0
var checkpoint_pos_lvl3 = 0
var Portal_status = 0
var score = 0
var H_score = 0

func score_save():
	var score = File.new()
	score.open("res://score",score.WRITE_READ)
	score.store_var(H_score)
	score.close()
	
func score_load():
	var score = File.new()
	if not score.file_exists("res://score"):
		return false
	score.open("res://score",score.READ)
	H_score = score.get_var()
	score.close()
	return true
	
func portal_save():
	var portal = File.new()
	portal.open("res://p_status",portal.WRITE_READ)
	portal.store_var(Portal_status)
	portal.close()
	
func portal_load():
	var portal = File.new()
	if not portal.file_exists("res://p_status"):
		return false
	portal.open("res://p_status",portal.READ)
	Portal_status = portal.get_var()
	portal.close()
	return true

func save_data():
	var checkpoint = File.new()
	checkpoint.open("res://check_lvl1",checkpoint.WRITE_READ)
	checkpoint.store_var(checkpoint_pos_lvl1)
	checkpoint.close()


func load_data():
	var checkpoint = File.new()
	if not checkpoint.file_exists("res://check_lvl1"):
		return false
	checkpoint.open("res://check_lvl1",checkpoint.READ)
	checkpoint_pos_lvl1 = checkpoint.get_var()
	checkpoint.close()
	return true

func save_data_2():
	var checkpoint = File.new()
	checkpoint.open("res://check_lvl2",checkpoint.WRITE_READ)
	checkpoint.store_var(checkpoint_pos_lvl2)
	checkpoint.close()

func load_data_2():
	var checkpoint = File.new()
	if not checkpoint.file_exists("res://check_lvl2"):
		return false
	checkpoint.open("res://check_lvl2",checkpoint.READ)
	checkpoint_pos_lvl2 = checkpoint.get_var()
	checkpoint.close()
	return true

func save_data_3():
	var checkpoint = File.new()
	checkpoint.open("res://check_lvl3",checkpoint.WRITE_READ)
	checkpoint.store_var(checkpoint_pos_lvl3)
	checkpoint.close()

func load_data_3():
	var checkpoint = File.new()
	if not checkpoint.file_exists("res://check_lvl3"):
		return false
	checkpoint.open("res://check_lvl3",checkpoint.READ)
	checkpoint_pos_lvl3 = checkpoint.get_var()
	checkpoint.close()
	return true
