extends Area2D

func _on_MEDS_body_entered(body: Node) -> void:
	queue_free()
