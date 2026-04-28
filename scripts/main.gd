extends Node2D

func _ready() -> void:
	Global.score_changed.connect(func(val: int) -> void:
		%ProgressBar.value = val)
	Global.ending.connect(func(text: String) -> void:
		%Label.text = text
		$CanvasLayer/EndPanel.visible = true
		get_tree().paused = true
		%EndButton.grab_focus.call_deferred())
	%Zero.curr_data = %Zero.interaction_data
	%Zero.interact()
	
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _on_end_button_pressed() -> void:
	get_tree().quit()
