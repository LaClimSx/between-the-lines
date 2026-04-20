extends Control
class_name InteractionPanel

signal answered(value: int)
signal too_late

func _ready() -> void:
	%AnswersContainer.get_child(0).grab_focus.call_deferred()


func setup(tex: CompressedTexture2D, question: String,
 answers: Array[String], timer_duration: int = 10) -> void:
	%TextureRect.texture = tex
	%QuestionLabel.text = question
	var answer_buttons: Array[Node] = %AnswersContainer.get_children()
	for i in range(answers.size()):
		answer_buttons[i].text = answers[i]
		answer_buttons[i].pressed.connect(func() -> void:
			get_tree().paused = false
			answered.emit(i)
			queue_free())
	$Timer.wait_time = timer_duration
	$Timer.timeout.connect(func() -> void: 
		get_tree().paused = false
		too_late.emit()
		queue_free())
	$Timer.start()
	get_tree().paused = true
	visible = true


func _process(_delta: float) -> void:
	%TimerLabel.text = str(int($Timer.time_left)) + "s"
