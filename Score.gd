extends Control

var current_score := 1

# Called when the node enters the scene tree for the first time.
func _ready():
	set_score(1)
	pass # Replace with function body.

func add_score(gain):
	set_score(current_score + gain)

func set_score(score):
	current_score = score
	get_child(0).text = str(int(score))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
