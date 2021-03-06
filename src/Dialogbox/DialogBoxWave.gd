extends Control

#refer dialoguebox0.gd except for the load dialogue part which is in the last function here.


var dialog_lvl2 = [
	'You have done good by comming all the way here',
	'There is an enemy wave ahead',
	'Kill all the enemies and you will get 1000points',
	'GOOD LUCK.'
	
]

var dialog_index = 0
var finished = false

func _ready():
	if PlayerInfo.dialoglvl2 == 1:
		return
	
	#set_physics_process(false)

func _process(delta):
	
	if PlayerInfo.dialoglvl2 == 1:
		queue_free()
	$"Dialogbox/next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
	
	
func load_dialog():
	if dialog_index < dialog_lvl2.size():
		finished = false
		$Dialogbox/RichTextLabel.bbcode_text = dialog_lvl2[dialog_index]
		$Dialogbox/RichTextLabel.percent_visible = 0
		$Dialogbox/Tween.interpolate_property(
			$Dialogbox/RichTextLabel, 'percent_visible', 0, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)#for letter by letter animation ($node, property, start_value, end_value, time_taken)
		$Dialogbox/Tween.start()
	else:
		PlayerInfo.dialoglvl2 = 1
		queue_free()
		get_tree().paused = false
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true

#this function called when the player enter the designated area, so that we can load the dialogue.

func _on_Left_area_body_entered(body):
	$Dialogbox.visible = true
	get_tree().paused = true
	load_dialog()
