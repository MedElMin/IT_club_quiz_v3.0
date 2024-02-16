extends VBoxContainer


# Called when the node enters the scene tree for the first time.





func _on_play_pressed():
	get_tree().change_scene_to_file("res://Interface_play/inetrface_play.tscn")
