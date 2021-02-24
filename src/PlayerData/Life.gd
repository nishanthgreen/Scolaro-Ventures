extends Control

func _on_Player_2_health(health) -> void:
	$HealthBar.value = health

func _on_Player_2_heal(heal) -> void:
	$HealthBar.value = heal





