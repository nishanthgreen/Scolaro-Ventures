extends Control



func _on_VideoPlayer_finished() -> void:
	get_tree().change_scene("res://src/levels/Level_0.tscn")

func _ready() -> void:
	PlayerInfo.Portal_status = 0
	PlayerInfo.portal_save()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://src/levels/Level_0.tscn")
