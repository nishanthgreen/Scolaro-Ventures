extends Control

var lvl1 = "res://src/levels/LeveL_1.tscn"
var lvl2 = "res://src/levels/level_2.tscn"
 
func _process(delta):
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		visible = true

func _on_ResumeButton_pressed():
	hide()
	get_tree().paused = false


func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().change_scene(lvl1)


func _on_MainMenuButtonPause_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://src/levels/Title_screen/Title_menu.tscn")
