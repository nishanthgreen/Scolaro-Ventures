extends Area2D


func _on_Checkpoint_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		body.Entered_checkpoint()
