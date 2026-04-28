extends HBoxContainer

@export var progress_low : CompressedTexture2D
@export var progress_mid : CompressedTexture2D
@export var progress_high : CompressedTexture2D

@onready var bar : TextureProgressBar = $ProgressBar

signal value_changed(val: float)

var value : int = 2:
	set(val):
		value = val
		bar.value = val
		value_changed.emit(val)

func _on_value_changed(val: float) -> void:
	if val - bar.min_value < (bar.max_value - bar.min_value)/3 :
		bar.texture_progress = progress_low
	elif val - bar.min_value > 2 * (bar.max_value - bar.min_value)/3:
		bar.texture_progress = progress_high
	else:
		bar.texture_progress = progress_mid
	get_tree().create_timer(0.5).timeout.connect(func() -> void:
		visible = true)
	get_tree().create_timer(4.0).timeout.connect(func() -> void:
		visible = false)
