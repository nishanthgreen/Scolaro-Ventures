extends Control

#we can type the dialogue we want in this variable.

var dialog_lvl1 = [
	'Welcome to SCOLARO VENTURES. Click ENTER to go next dialogue.',
	'Find the locket to return to your world.',
	'For movements use the ARROW KEYS.',
	'GOOD LUCK']

var dialog_index = 0 # To know which line is displaying.
var finished = false # to know wether the dialogue is completed or not, so that we can make the next indicator visible.


#To load the dialogue at the start of the parent node and when loading dialogue, everything aside dialoguebox is paused.
func _ready():
	
	load_dialog()
	get_tree().paused = true
	
	
func _process(delta):
	$"next-indicator".visible = finished     #To enable the indicator.
	if Input.is_action_just_pressed("ui_accept"):        # To navigate to next dialogue.
		load_dialog()
	
	
# This function is to load the dialogue.	
func load_dialog():
	if dialog_index < dialog_lvl1.size():     #This if statement will run till the diaogue is completed.
		finished = false
		#$RichTextLabel.ALIGN_CENTER = 0
		$RichTextLabel.bbcode_text = dialog_lvl1[dialog_index] # used for advanced text editing like unique color for each for etc.
		$RichTextLabel.percent_visible = 0 # This property is used for letter by letter animation.
		$Tween.interpolate_property(
			$RichTextLabel, 'percent_visible', 0, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)#for letter by letter animation ($node, property, start_value, end_value, time_taken)
		$Tween.start()
	else:
		queue_free()  #When the dialogue is completed free the node so that we can move to next one
		get_tree().paused = false #To unpause after the whole dialogue is completed.
	dialog_index += 1 # Incrmenting this will help us, when to complete the dialogue.



# This function is called when the twin animation is completed.
func _on_Tween_tween_completed(object, key):
	finished = true
