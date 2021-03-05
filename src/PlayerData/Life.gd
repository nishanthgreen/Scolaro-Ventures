extends Control

#update the health bar
func _on_Player_2_health(health) -> void:
	$HealthBar.value = health

#update the health bar
func _on_Player_2_heal(heal) -> void:
	$HealthBar.value = heal

