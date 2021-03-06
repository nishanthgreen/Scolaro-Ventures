extends Control

var lvl1 = "res://src/levels/LeveL_1.tscn"  # Assigning level_1 scene path to this variable.
var lvl2 = "res://src/levels/level_2.tscn"  # Assigning level_1 scene path to this variable.
 
func _process(delta):
	if Input.is_action_pressed("pause"):   # For pausing the game when the assigned key is pressed.
		get_tree().paused = true
		visible = true

# To resume the game when resume button is clicked.
func _on_ResumeButton_pressed():
	hide()
	get_tree().paused = false

# To restart the game when restart button is clicked.
func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().change_scene(lvl1)   #changing the scene to lvl1

# When menu button is clicked go to title screen
func _on_MainMenuButtonPause_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://src/levels/Title_screen/Title_menu.tscn")  #changing the scene to title menu
