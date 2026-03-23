extends Node

signal score_changed


var score : int = 0:
	set(value):
		score += value
		score_changed.emit()
