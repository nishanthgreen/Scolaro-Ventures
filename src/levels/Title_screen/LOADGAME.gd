extends Button

func _on_LOADGAME_pressed() -> void:
	PlayerInfo.portal_load()
	if PlayerInfo.Portal_status == 1:
		get_tree().change_scene("res://src/levels/LeveL_1.tscn")
	if PlayerInfo.Portal_status == 2:
		get_tree().change_scene("res://src/levels/level_2.tscn")
	if PlayerInfo.Portal_status == 3:
		get_tree().change_scene("res://src/levels/level_3.tscn")
