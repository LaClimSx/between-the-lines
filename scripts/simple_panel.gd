extends Control
class_name SimplePanel

signal next

func _ready() -> void:
	%NextButton.grab_focus.call_deferred()


func setup(tex: CompressedTexture2D, text: String) -> void:
	%TextureRect.texture = tex
	%Label.text = text
	if not tex:
		%TextureRect.visible = false
	get_tree().paused = true
	visible = true
	%NextButton.disabled = true
	get_tree().create_timer(0.4).timeout.connect(func() -> void : %NextButton.disabled = false)


func _on_next_button_pressed() -> void:
	get_tree().paused = false
	next.emit()
