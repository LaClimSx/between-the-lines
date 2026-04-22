extends ColorRect

@onready var mat := material as ShaderMaterial

#func _ready() -> void:
#	Global.score_changed.connect(func(score: int) -> void:
#		set_scene_temperature(score))

func set_scene_temperature(value: float) -> void:
	mat.set_shader_parameter("warmth", clamp(value, Global.SCORE_LOWER_BOUND, Global.SCORE_UPPER_BOUND))
