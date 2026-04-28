extends Node2D

const PARTICLE = preload("res://scenes/particle.tscn")
var tween: Tween

func _ready() -> void:
	Global.score_changed.connect(func(val: int) -> void:
		%ProgressBar.value = val)
	Global.ending.connect(func(text: String) -> void:
		%Label.text = text
		$CanvasLayer/EndPanel.visible = true
		get_tree().paused = true
		%EndButton.grab_focus.call_deferred())
	%ProgressBar.value_changed.connect(move_particle)
	%Zero.curr_data = %Zero.interaction_data
	%Zero.interact()


func move_particle(_val: float) -> void:
	var particle : TextureRect = PARTICLE.instantiate()
	particle.global_position = $Player.global_position
	add_child(particle)
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	var end_pos : Vector2 = %ProgressBar.global_position + Vector2(%ProgressBar.size.x / 2, -3)
	tween.tween_property(particle, "global_position", end_pos, 1.0)
	tween.tween_callback(particle.queue_free)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_end_button_pressed() -> void:
	get_tree().quit()
