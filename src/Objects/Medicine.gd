extends Area2D

#trash the meds as player collects it
func _on_MEDS_body_entered(body: Node) -> void:
	queue_free()
