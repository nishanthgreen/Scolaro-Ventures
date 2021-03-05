extends Area2D

#get notified about the player's entry into checkpoint

func _on_Checkpoint_body_entered(body: Node) -> void:
	if body.name == "Player_2":
		body.Entered_checkpoint()
