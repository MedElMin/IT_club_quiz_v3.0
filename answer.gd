extends Control

signal answer_chosen(index)

var answer_index = 0

const default_size: Vector2 = Vector2(300, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var button = $AnswerText/Button
	var texture_rect = $AnswerText/TextureRect
	var label =  $AnswerText

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
#	add_child(button)

func set_answer(answer: String):
	$AnswerText.text = "[center]" + answer + "[/center]"

func _button_pressed():
	answer_chosen.emit(answer_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
