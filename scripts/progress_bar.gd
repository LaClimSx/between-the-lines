extends TextureProgressBar

@export var progress_low : CompressedTexture2D
@export var progress_mid : CompressedTexture2D
@export var progress_high : CompressedTexture2D


func _on_value_changed(val: float) -> void:
	if val - min_value < (max_value - min_value)/3 :
		texture_progress = progress_low
	elif val - min_value > 2 * (max_value - min_value)/3:
		texture_progress = progress_high
	else:
		texture_progress = progress_mid
	visible = true
	get_tree().create_timer(3).timeout.connect(func() -> void:
		visible = false)
