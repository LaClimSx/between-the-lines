extends Node

const SCORE_LOWER_BOUND: int = -10
const SCORE_UPPER_BOUND: int = 10
const TOTAL_INTERACTIONS: int = 8

var bypass_setters: bool = false

var tuto_done: bool = false
signal tuto_finished

signal score_changed(value: int)
signal ending(text: String)

@onready var timer : Timer = $Timer

var nb_interactions : int = 0:
	set(value):
		if bypass_setters:
			nb_interactions = value
			return
		nb_interactions = value
		if (nb_interactions) == 1:
			timer.start(900)
			tuto_done = true
			tuto_finished.emit()
		if nb_interactions >= TOTAL_INTERACTIONS:
			await get_tree().create_timer(5).timeout
			_on_timer_timeout()

var score : int = 2:
	set(value):
		if bypass_setters:
			score = value
			return
		score = clamp(score + value, SCORE_LOWER_BOUND, SCORE_UPPER_BOUND)
		score_changed.emit(score)
		if score <= SCORE_LOWER_BOUND:
			lost_confidence()
	
func lost_confidence() -> void:
	await get_tree().create_timer(4).timeout
	ending.emit("Your social battery runs low, you are tired and decide to go home. Before leaving, you find Sarah and thank her for inviting you.")
	print("End game, lost confidence")


func _on_timer_timeout() -> void:
	ending.emit("The party is ending, you find Sarah and leave together. On your way back, you thank her for inviting you.")
	print("End game")

func restart() -> void:
	tuto_done = false
	bypass_setters = true
	timer.stop()
	score = 2
	nb_interactions = 0
	bypass_setters = false
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
