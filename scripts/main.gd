extends Node2D

const PARTICLE = preload("res://scenes/particle.tscn")

func _ready() -> void:
	get_tree().paused = false
	Global.score_changed.connect(func(val: int) -> void:
		%ProgressBar.value = val
		)
	Global.ending.connect(func(text: String) -> void:
		if !$CanvasLayer/EndPanel.visible:
			%Label.text = text
			$CanvasLayer/EndPanel.visible = true
			get_tree().paused = true
			%EndButton.grab_focus.call_deferred())
	Global.tuto_finished.connect(close_interaction_tuto)
	Global.fade_to_black.connect(fade_to_black)
	%ProgressBar.value_changed.connect(move_particle)
	$Furniture/Door.interacting.connect(func(panel: Control) -> void:
		$CanvasLayer.add_child(panel))


func move_particle(diff: float) -> void:
	var particle : Particle = PARTICLE.instantiate()
	particle.texture = particle.texture_pos if diff > 0 else particle.texture_neg
	add_child(particle)
	particle.global_position = Vector2(-10, -10)
	var tween : Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	var end_pos : Vector2 = %ProgressBar.global_position + Vector2(%ProgressBar.size.x / 2, -3)
	tween.tween_property(particle, "global_position", end_pos, 1.0).from($Player.global_position)
	tween.tween_callback(particle.queue_free)


func close_interaction_tuto() -> void:
	%Zero.queue_free()
	$Player.tuto_movement()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Global.restart()
	if not Global.timer.is_stopped():
		$Clock.frame = floori(10 - (Global.timer.time_left / Global.GAME_TIME) * 10)

func _on_end_button_pressed() -> void:
	Global.restart()


func _sit_on_sofa() -> void:
	fade_to_black();
	const SOFA_POSITION : Vector2 = Vector2(52, 47)
	$Player.sit(SOFA_POSITION)



func fade_to_black() -> void:
	get_tree().paused = true
	var mat : ShaderMaterial = $ShaderLayer/ColorRect.material;
	if mat: 
		var curr_tween : Tween = get_tree().create_tween().bind_node($ShaderLayer/ColorRect);
		curr_tween.tween_property(mat, "shader_parameter/fade", 1.0, 1.2);
		curr_tween.tween_property(mat, "shader_parameter/fade", 0.0, 1.2);
		curr_tween.tween_callback(func() -> void: get_tree().paused = false)
