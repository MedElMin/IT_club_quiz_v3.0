extends Control

signal answer_chosen(index)
# var answer_text = "ANSWER"
var answer_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.text = "ANSWER"
	button.pressed.connect(self._button_pressed)
#	add_child(button)

func set_answer(answer: String):
	$Button.text = answer

func _button_pressed():
	answer_chosen.emit(answer_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
