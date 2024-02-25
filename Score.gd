extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	set_score(1)
	pass # Replace with function body.

func set_score(score):
	get_child(0).text = str(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
