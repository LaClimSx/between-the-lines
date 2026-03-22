extends CanvasLayer
class_name InteractionPanel

signal answered(value: int)
signal too_late

func _ready() -> void:
	%AnswersContainer.get_child(0).grab_focus.call_deferred()


func setup(tex: CompressedTexture2D, question: String,
 answers: Array[String], answers_order: Array[int], timer_duration: int = 10) -> void:
	%TextureRect.texture = tex
	%QuestionLabel.text = question
	var answer_buttons: Array[Node] = %AnswersContainer.get_children()
	for i in range(answers.size()):
		answer_buttons[i].text = answers[i]
		answer_buttons[i].pressed.connect(func() -> void:
			answered.emit(answers_order[i])
			get_tree().paused = false
			queue_free())
	$Timer.wait_time = timer_duration
	$Timer.timeout.connect(func() -> void: 
		too_late.emit()
		get_tree().paused = false
		queue_free())
	$Timer.start()
	get_tree().paused = true
	visible = true


func _process(_delta: float) -> void:
	%TimerLabel.text = str(int($Timer.time_left)) + "s"
