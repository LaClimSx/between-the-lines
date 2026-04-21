extends ColorRect

@onready var mat := material as ShaderMaterial

func _ready() -> void:
	Global.score_changed.connect(func(score: int) -> void:
		set_scene_temperature(score))

func set_scene_temperature(value: float) -> void:
	mat.set_shader_parameter("warmth", clamp(value, -5.0, 5.0))
