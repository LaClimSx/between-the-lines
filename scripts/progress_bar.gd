extends HBoxContainer

@export var progress_low : CompressedTexture2D
@export var progress_mid : CompressedTexture2D
@export var progress_high : CompressedTexture2D

@onready var bar : TextureProgressBar = $ProgressBar

signal value_changed(diff: float)

var value : int = 2:
	set(val):
		var diff: int = val - value
		value = val
		value_changed.emit(diff)
		animate_bar(val)


func animate_bar(val: float) -> void:
	await get_tree().create_timer(0.6).timeout
	var tween : Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(bar, "value", val, 0.75)


func _on_value_changed(_diff: float) -> void:
	get_tree().create_timer(0.5).timeout.connect(func() -> void:
		visible = true)
	get_tree().create_timer(4.5).timeout.connect(func() -> void:
		visible = false)


func _on_progress_bar_value_changed(val: float) -> void:
	if val - bar.min_value < (bar.max_value - bar.min_value)/3 :
		bar.texture_progress = progress_low
	elif val - bar.min_value > 2 * (bar.max_value - bar.min_value)/3:
		bar.texture_progress = progress_high
	else:
		bar.texture_progress = progress_mid
