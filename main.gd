extends Node2D

# const a = 65 + 32
# var option_array := Array(range(26)).map(func (i): return char(i + a))

class ParsedMultipleChoiceQuestion:
	var Choices: Dictionary
	var RightAnswers: Array[String]
	var Question: String

const QUESTION_PATH := "res://content/question.json"
const GAIN_PER_QUESTION := 10

var option_to_index = {
	"a": 0,
	"b": 1,
	"c": 2,
	"d": 3,
}
var index_to_option = [
	"a",
	"b",
	"c",
	"d",
]

var background_index = -1
# var question_index = -1
# holds ints
var right_answer_indices: Array = []
# array of indices from the question array
var index_pool: Array
# answer scenes
var answers: Array[Node]
var questions: Array
# timer config
var progress_bar
var timer: Timer
const time_per_question = 30

var camera

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	# load question array
	var err = load_json(QUESTION_PATH)
	
	match typeof(err):
		TYPE_DICTIONARY:
			questions = err["questions"]
		_:
			print("invalid type: ", typeof(err), "\n", err)
			get_tree().quit(1)
	print("number of questions: ", len(questions), "\nThe maximal score is: ", len(questions) * GAIN_PER_QUESTION)
	# Load the timer and connect its signal
	progress_bar = $progress_bar
	timer = progress_bar.get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	
	# initialize question pool
	index_pool = Array(range(questions.size()))
	
	answers = $answers.get_children()

	camera = $Camera2D
	camera.make_current()
	
	# Manually positioning UI elements
	var center: Vector2 =  camera.get_screen_center_position()
	var radius = (center.y - $Question.size.y / 2) / 2 
	# eccentricity or similar
	var factor = 2.5
	for i in range(answers.size()):
		answers[i].position = - answers[i].size / 2 + center + radius *  Vector2(factor * cos(2 * PI * (i as float / answers.size() as float)), sin(2 * PI * (i as float / answers.size() as float) ))
	
	# Placing and centering the question box
	$Question.position = center + (Vector2.UP * radius * 2) - ($Question.size / 2)
	
	score = $score
	
	# pick 'n load the first question
	var question = get_question(pick_out_question())
	
	load_question_multiple_choice(question)
	
	# Load background
	var bg_size = $Background.sprite_frames.get_frame_texture("Quiz background", 0).get_size()
	var view_port: Viewport = camera.get_custom_viewport()
	if view_port == null:
		view_port = get_viewport()
	
	$Background.scale = view_port.get_visible_rect().size / bg_size
	$Background.position += bg_size * $Background.scale / 2
	$Background.play() 

func pick_out_question() -> int:
	if index_pool.size() == 0:
		get_tree().quit(1)
	var pick = randi() % index_pool.size()
	var index = index_pool[pick]
	index_pool[pick] = index_pool[index_pool.size() - 1]
	index_pool.pop_back()
	return index

# Load a question from some data
func load_question_multiple_choice(question: ParsedMultipleChoiceQuestion):
	# TODO: Add question loading
	$Question.set_question_text(question.Question)
	# integer index for the right answer
	right_answer_indices = question.RightAnswers.map(func (right_answer) -> int: return option_to_index[right_answer])
	
	for i in range(min(answers.size(), question.Choices.size())):
		answers[i].answer_index = i
		answers[i].set_answer(question.Choices[index_to_option[i]])
		if not answers[i].answer_chosen.is_connected(self._on_answer_chosen):
			answers[i].answer_chosen.connect(self._on_answer_chosen)
	
	# Start the timer
	timer.start(time_per_question)

func load_json(filePath):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var json = JSON.new()
		var err = json.parse(dataFile.get_as_text())
		
		if err != OK:
			return err
		else:
			return json.data
	else:
		return ERR_FILE_NOT_FOUND

func calculate_score(time_ratio: float):
	return time_ratio * GAIN_PER_QUESTION
	
func _on_answer_chosen(index):
	# compare the answer index and the question answer index
	print(index, right_answer_indices)
	if index in right_answer_indices:
		$score.add_score(calculate_score(timer.time_left / timer.wait_time))
			
		# pick 'n load the first question
		var question = get_question(pick_out_question())
		
		load_question_multiple_choice(question)
	
func _on_timer_timeout():
	# pick 'n load the first question
	var question = get_question(pick_out_question())
	
	load_question_multiple_choice(question)

func get_question(index: int) -> ParsedMultipleChoiceQuestion:
	var result = ParsedMultipleChoiceQuestion.new()
	result.Choices = questions[index]["options"]
	result.Question = questions[index]["question"]
	var right_ans = questions[index]["answer"]
	match typeof(right_ans):
		TYPE_STRING:
			result.RightAnswers.append(right_ans)
		# TODO: Still need to make sure the array type is a string
		TYPE_ARRAY:
			result.RightAnswers = right_ans
		_:
			print("invalid type for answer array: ", typeof(right_ans), "\n", right_ans)
			get_tree().quit(1)
	return result
