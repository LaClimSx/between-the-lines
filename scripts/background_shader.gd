extends CanvasItem
@onready var mat := material as ShaderMaterial


func _ready() -> void:
	Global.score_changed.connect(func(score: int) -> void:
		change_color(score))

func change_color(score: float) -> void: 
	var confidence = ((score - Global.SCORE_LOWER_BOUND) / (Global.SCORE_UPPER_BOUND - Global.SCORE_LOWER_BOUND));
	if mat != null: 
		var curr_tween = create_tween();
		curr_tween.tween_property(mat, "shader_parameter/confidence", confidence, 0.5)
		
