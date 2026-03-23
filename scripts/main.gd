extends Node2D

func _ready() -> void:
	Global.score_changed.connect(func() -> void:
		$CanvasLayer/Control/ScoreLabel.text = "Score: " + str(Global.score))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
