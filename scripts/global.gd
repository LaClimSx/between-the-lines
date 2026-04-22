extends Node

const SCORE_LOWER_BOUND: int = -10
const SCORE_UPPER_BOUND: int = 10
const TOTAL_INTERACTIONS: int = 8

signal score_changed(value: int)
@onready var timer : Timer = $Timer

var nb_interactions : int = 0:
	set(value):
		nb_interactions = value
		print(nb_interactions)
		if nb_interactions >= TOTAL_INTERACTIONS:
			await get_tree().create_timer(5).timeout
			_on_timer_timeout()

var score : int = 2:
	set(value):
		score = clamp(score + value, SCORE_LOWER_BOUND, SCORE_UPPER_BOUND)
		score_changed.emit(score)
		if score <= SCORE_LOWER_BOUND:
			lost_confidence()
	
func lost_confidence() -> void:
	print("End game, lost confidence")
	get_tree().quit()


func _on_timer_timeout() -> void:
	print("End game")
	get_tree().quit()
