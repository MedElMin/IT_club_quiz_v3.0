extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	var label: Label = $Label
	label.size = self.size
	
	label.set_vertical_alignment(VERTICAL_ALIGNMENT_CENTER)
	label.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	# $Label.position = self.size / 2 - $Label.size / 2

#var x = 0
#var y = 0
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var label: Label = $Label
	#x = (x + 1)  % 16
	#y = (y + 1)  % 12
	#if x == 0:
		#label.horizontal_alignment = (label.horizontal_alignment + 1) % 4
	#if y == 0:
		#label.vertical_alignment = (label.vertical_alignment + 1) % 4
