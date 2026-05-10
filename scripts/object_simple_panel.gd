extends Control
class_name ObjectSimplePanel

func _ready() -> void:
	visible = false

func show_panel() -> void:
	get_tree().paused = true
	visible = true
	%NextButton.grab_focus.call_deferred()
	%NextButton.disabled = true
	get_tree().create_timer(0.5).timeout.connect(func() -> void : %NextButton.disabled = false)



func _on_next_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
