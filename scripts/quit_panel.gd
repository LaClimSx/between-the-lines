extends Control

func _ready() -> void:
	%NoButton.grab_focus.call_deferred()
	get_tree().paused = true


func _on_yes_button_pressed() -> void:
	#TODO maybe change the ending
	visible = false
	Global.lost_confidence()
	queue_free()


func _on_no_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
