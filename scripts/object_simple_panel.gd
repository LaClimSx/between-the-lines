extends Control
class_name ObjectSimplePanel

func _ready() -> void:
	visible = false

func show_panel() -> void:
	get_tree().paused = true
	visible = true
	%NextButton.grab_focus.call_deferred()



func _on_next_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
