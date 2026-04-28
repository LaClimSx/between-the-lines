extends Control
class_name InteractionPanel

signal answered(value: int)
signal too_late

var started: bool = false
var timer_is_white: bool = true

func _ready() -> void:
	%AnswersContainer.get_child(0).grab_focus.call_deferred()
	timer_is_white = %ProgressBarLeft.get("theme_override_styles/fill").bg_color == Color.WHITE


func setup(tex: CompressedTexture2D, question: String,
 answers: Array[String], locks: Array[bool], timer_duration: int = 15) -> void:
	%TextureRect.texture = tex
	%QuestionLabel.text = question
	var answer_buttons: Array[Node] = %AnswersContainer.get_children()
	for i in range(answers.size()):
		answer_buttons[i].text = answers[i]
		if locks[i] && Global.score < 0:
			answer_buttons[i].disabled = true
			answer_buttons[i].text += " [Not confident enough]"
		answer_buttons[i].pressed.connect(func() -> void:
			get_tree().paused = false
			answered.emit(i)
			queue_free())
	if timer_duration < 0:
		%TimerContainer.visible = false
	else:
		%ProgressBarLeft.max_value = timer_duration
		%ProgressBarRight.max_value = timer_duration
		$Timer.wait_time = timer_duration
		$Timer.timeout.connect(func() -> void: 
			get_tree().paused = false
			too_late.emit()
			queue_free())
		$Timer.start()
		started = true
	get_tree().paused = true
	visible = true


func _process(_delta: float) -> void:
	if started:
		%ProgressBarLeft.value = $Timer.time_left
		%ProgressBarRight.value = $Timer.time_left
		if %ProgressBarLeft.value < %ProgressBarLeft.max_value/3 && timer_is_white:
			%ProgressBarLeft.get("theme_override_styles/fill").bg_color = Color.from_rgba8(109, 12, 1, 255)
			%ProgressBarRight.get("theme_override_styles/fill").bg_color = Color.from_rgba8(109, 12, 1, 255)
			timer_is_white = false
		elif %ProgressBarLeft.value >= %ProgressBarLeft.max_value/3 && !timer_is_white:
			%ProgressBarLeft.get("theme_override_styles/fill").bg_color = Color.WHITE
			%ProgressBarRight.get("theme_override_styles/fill").bg_color = Color.WHITE
			timer_is_white = true
