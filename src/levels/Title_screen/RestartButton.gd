extends Button


func _ready():
	pass


func _on_RestartButton_gameover_pressed():
	get_tree().change_scene("res://src/levels/LeveL_1.tscn")
