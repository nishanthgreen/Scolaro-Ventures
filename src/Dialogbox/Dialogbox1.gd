extends Control

var dialog_lvl1 = [
	'Welcome to level 1.',
	'You will face some dangerous enimies.',
	'You can kill the enimies by jumping on them.'
]

var dialog_index = 0
var finished = false

func _ready():
	
	load_dialog()
	get_tree().paused = true
func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
	
	
func load_dialog():
	if dialog_index < dialog_lvl1.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog_lvl1[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, 'percent_visible', 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)#for letter by letter animation ($node, property, start_value, end_value, time_taken)
		$Tween.start()
	else:
		queue_free()
		get_tree().paused = false
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
