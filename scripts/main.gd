extends Node2D

func _ready() -> void:
	Global.score_changed.connect(func(_val: int) -> void:
		$CanvasLayer/Control/ScoreLabel.text = "Score: " + str(Global.score))
	%Zero.curr_data = %Zero.interaction_data
	%Zero.interact()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
