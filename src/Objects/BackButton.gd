extends Button

#scene changes to titlemenu as back button is pressed
func _on_BackButton_pressed():
	get_tree().change_scene("res://src/levels/Title_screen/Title_menu.tscn")

