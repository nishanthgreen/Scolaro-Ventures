extends Control

var dialog_lvl1 = [
	'Welcome to SCOLARO VENTURES. Click ENTER to go next dialogue.',
	'Find the locket to return to your world.',
	'For movements use the ARROW KEYS.',
	'GOOD LUCK']

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
		#$RichTextLabel.ALIGN_CENTER = 0
		$RichTextLabel.bbcode_text = dialog_lvl1[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, 'percent_visible', 0, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)#for letter by letter animation ($node, property, start_value, end_value, time_taken)
		$Tween.start()
	else:
		queue_free()
		get_tree().paused = false
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
