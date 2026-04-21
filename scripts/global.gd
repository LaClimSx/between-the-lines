extends Node

const SCORE_LOWER_BOUND: int = -10

signal score_changed(value: int)
@onready var timer : Timer = $Timer

var score : int = 2:
	set(value):
		score += value
		score_changed.emit(score)
		if score <= SCORE_LOWER_BOUND:
			lost_confidence()
	
func lost_confidence() -> void:
	print("End game, lost confidence")


func _on_timer_timeout() -> void:
	print("End game")
