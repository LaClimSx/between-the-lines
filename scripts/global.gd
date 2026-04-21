extends Node

const SCORE_LOWER_BOUND: int = -10

signal score_changed
@onready var timer : Timer = $Timer

var score : int = 0:
	set(value):
		score += value
		score_changed.emit()
		if score <= SCORE_LOWER_BOUND:
			lost_confidence()
	
func lost_confidence() -> void:
	print("End game, lost confidence")


func _on_timer_timeout() -> void:
	print("End game")
