extends Area2D


func _on_Checkpoint_body_entered(body: Node) -> void:
	body.Entered_checkpoint()
