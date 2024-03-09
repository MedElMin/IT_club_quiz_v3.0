extends Node2D

var score: int
var camera


# This is not running as we are instantiating the scene
func _ready():
	print("Game over score is: ", score)
	# camera set up
	camera = $Camera2D
	## TOPLEFT ANCHOR
	camera.anchor_mode = 0
	camera.make_current()
	# load background
	var bg_size = $Background.sprite_frames.get_frame_texture("Quiz background", 0).get_size()
	var view_port: Viewport = camera.get_custom_viewport()
	if view_port == null:
		view_port = get_viewport()
	
	$Background.scale = view_port.get_visible_rect().size / bg_size
	$Background.position += bg_size * $Background.scale / 2
	$Background.play() 
	
func set_score(score):
	self.score = score
	get_child(0).text = str(int(score))

