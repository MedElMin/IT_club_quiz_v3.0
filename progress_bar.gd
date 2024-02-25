extends ColorRect

var full_width: float
var underlying_timer: Timer 

# Called when the node enters the scene tree for the first time.
func _ready():
	var background_bar: ColorRect = get_parent()
	# Initialize a few attributes
	underlying_timer = get_node("../../Timer")
	full_width = size.x

	# center the bar relative to the parent
	position.x = (background_bar.size.x - size.x) / 2
	position.y = (background_bar.size.y - size.y) / 2
	print(position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var progress = underlying_timer.time_left / underlying_timer.wait_time
	size.x = progress * full_width
	
