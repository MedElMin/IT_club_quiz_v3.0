extends TextureRect

const starting_size: Vector2 = Vector2(500, 100)

func _ready():
	var label: RichTextLabel = $Label
	size = starting_size
	label.size = size
	label.bbcode_enabled = true

func set_question_text(question: String):
	$Label.text = "[center]" + question + "[/center]"
