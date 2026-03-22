extends CanvasLayer
class_name InteractionPanel

signal answered(value: int)
signal too_late

func setup(tex: CompressedTexture2D, question: String,
 answers: Array[String], answers_order: Array[int], timer_duration: int = 10):
	%TextureRect.texture = tex
	%QuestionLabel.text = question
	var answer_buttons: Array[Node] = %AnswersContainer.get_children()
	for i in range(answers.size()):
		answer_buttons[i].text = answers[i]
		answer_buttons[i].pressed.connect(func():
			answered.emit(answers_order[i])
			queue_free())
	$Timer.wait_time = timer_duration
	$Timer.timeout.connect(func(): 
		too_late.emit()
		queue_free())
	$Timer.start()
	visible = true



func _process(delta):
	%TimerLabel.text = str(int($Timer.time_left))
