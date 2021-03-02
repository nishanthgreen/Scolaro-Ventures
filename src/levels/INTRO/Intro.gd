extends Control



func _on_VideoPlayer_finished() -> void:
	if PlayerInfo.Portal_status == 0:
		get_tree().change_scene("res://src/levels/Level_0.tscn")
	else:
		get_tree().change_scene("res://src/levels/Title_screen/Title_menu.tscn")

func _ready() -> void:
	PlayerInfo.portal_load()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and PlayerInfo.Portal_status == 0:
		get_tree().change_scene("res://src/levels/Level_0.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://src/levels/Title_screen/Title_menu.tscn")
