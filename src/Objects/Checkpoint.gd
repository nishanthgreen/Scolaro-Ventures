extends Area2D

#get notified about the player's entry into the checkpoint
func _on_Checkpoint_body_entered(body: Node) -> void:
	body.Entered_checkpoint()

