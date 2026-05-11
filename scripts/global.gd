extends Node

const SCORE_LOWER_BOUND: int = -10
const SCORE_UPPER_BOUND: int = 10
const TOTAL_INTERACTIONS: int = 8

var bypass_setters: bool = false

var first_game: bool = true

var tuto_done: bool = false
signal tuto_finished

@warning_ignore("unused_signal")
signal fade_to_black

signal score_changed(value: int)
signal ending(party_over: bool, text: String)

@onready var timer : Timer = $Timer
const GAME_TIME: int = 520

var nb_interactions : int = 0:
	set(value):
		if bypass_setters:
			nb_interactions = value
			return
		nb_interactions = value
		if nb_interactions == 1:
			timer.start(GAME_TIME)
			tuto_done = true
			tuto_finished.emit()
		if nb_interactions >= TOTAL_INTERACTIONS:
			if timer.time_left >= 20:
				timer.start(20)
			


var score : int = 2:
	set(value):
		if bypass_setters:
			score = value
			return
		score = clamp(value, SCORE_LOWER_BOUND, SCORE_UPPER_BOUND)
		score_changed.emit(score)
		if score <= SCORE_LOWER_BOUND:
			get_tree().create_timer(4).timeout.connect(lost_confidence)


func lost_confidence() -> void:
	ending.emit(false, "Your social battery runs low, you are tired and decide to go home. Before leaving, you find Sarah and thank her for inviting you. Maybe this wasn’t the right day or the right party, but next time will be better for sure.")


func _on_timer_timeout() -> void:
	if score >= 0 :
		ending.emit(true, "The party is ending. Before leaving, you chat with your new friends for a bit. You find Sarah and walk home with her. You’re glad you came with her after all, it wasn’t as bad as you expected.")
	else:
		ending.emit(true, "The party is ending, you find Sarah and leave together. On your way home, you talk about how you felt meeting these new people. You feel like you had a hard time interacting with them. Maybe this wasn’t the best time for you to go out, or the right party, but next time will be better for sure. You’re glad to have a friend like Sarah to reassure you.")


func restart() -> void:
	tuto_done = false
	bypass_setters = true
	timer.stop()
	score = 2
	nb_interactions = 0
	bypass_setters = false
	get_tree().paused = false
	if first_game:
		first_game = false
		get_tree().change_scene_to_file("res://scenes/asd_ending_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
