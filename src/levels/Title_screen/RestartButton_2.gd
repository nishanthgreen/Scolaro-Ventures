extends Button

func _on_RestartButton_gameover_pressed():
	get_tree().change_scene("res://src/levels/level_2.tscn")
