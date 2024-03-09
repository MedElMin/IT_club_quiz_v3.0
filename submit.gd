extends Control

signal answer_submitted()


const default_size: Vector2 = Vector2(300, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var button = $AnswerText/Button
	var texture_rect = $AnswerText/TextureRect
	var label =  $AnswerText
	label.text = "[center]SUBMIT[/center]"
	label.fit_content = true
	# overlay the question on top (this z_index is relative)
	button.z_index = -1
	texture_rect.z_index = -1
	z_index += 1
	

	$AnswerText.size = default_size
	
	# resize the button to be the same size as the label

	button.size = $AnswerText.size
	texture_rect.scale = $AnswerText.size / texture_rect.size
	texture_rect.size = $AnswerText.size
	
	$AnswerText.bbcode_enabled = true
	
	button.pressed.connect(self._button_pressed)


func _button_pressed():
	answer_submitted.emit()


