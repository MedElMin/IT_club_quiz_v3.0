extends Control

var answer_text = "ANSWER"
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.text = answer_text
	button.pressed.connect(self._button_pressed)
#	add_child(button)
	
func _button_pressed():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
