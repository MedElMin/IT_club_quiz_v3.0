extends Node2D


func _ready():


	var camera = $Camera2D
	camera.make_current()
	
	# Manually positioning UI elements
	var center: Vector2 =  camera.get_screen_center_position()



	
	# Load background
	var bg_size = $Background.sprite_frames.get_frame_texture("Quiz background", 0).get_size()
	var view_port: Viewport = camera.get_custom_viewport()
	if view_port == null:
		view_port = get_viewport()
	
	$Background.scale = view_port.get_visible_rect().size / bg_size
	$Background.position += bg_size * $Background.scale / 2
	$Background.play() 


 
