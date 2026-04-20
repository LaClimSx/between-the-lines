extends Control
class_name SimplePanel

signal next

func _ready() -> void:
	%NextButton.grab_focus.call_deferred()


func setup(tex: CompressedTexture2D, text: String) -> void:
	%TextureRect.texture = tex
	%Label.text = text
	get_tree().paused = true
	visible = true


func _on_next_button_pressed() -> void:
	get_tree().paused = false
	next.emit()
