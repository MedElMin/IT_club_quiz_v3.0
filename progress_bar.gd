extends ColorRect

var full_length: float
var underlying_timer: Timer 

# Called when the node enters the scene tree for the first time.
func _ready():
	# center the bar relative to the parent
	
	underlying_timer = get_node("../../Timer")
	full_length = size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var progress = underlying_timer.time_left / underlying_timer.wait_time
	size.x = progress * full_length
	
