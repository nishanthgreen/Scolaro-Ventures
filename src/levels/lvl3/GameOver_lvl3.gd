extends Control

func _ready() -> void:
	PlayerInfo.score_load()
	PlayerInfo.H_score = max (PlayerInfo.H_score, PlayerInfo.score)
	PlayerInfo.score_save()
	$H_score.text = String(PlayerInfo.H_score)
	$score.text = String(PlayerInfo.score)
	
