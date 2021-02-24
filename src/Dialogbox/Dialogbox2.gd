extends Control

var dialog_lvl2 = [
	'Welcome to level 2.',
	'Here, you will face more powerful enimies.',
	'After completing level 1, you have gained a freeze ability and an armour.',
	'You can stop your enemy from firing using freeze ability by pressing Z .',
	'You can attack and kill your enemy by pressing X .',
	'You have life bar and you can regain 50% health by using meds available in map'
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
	if dialog_index < dialog_lvl2.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog_lvl2[dialog_index]
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
