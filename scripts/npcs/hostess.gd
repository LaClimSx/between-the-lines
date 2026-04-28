extends NPC

@export var interaction_data_minus : NPCData
@export var path_follow: PathFollow2D

@export var move_speed : float

func _input(event: InputEvent) -> void:
	if player_inside_area && event.is_action_pressed("interact") && not interacted:
		curr_data = interaction_data if Global.score >= 0 else interaction_data_minus
		interact()
		interacted = true
		$AnimatedSprite2D.animation = "interacted"
		Global.timer.start(Global.timer.time_left - 60)


func _process(delta: float) -> void:
	path_follow.progress_ratio += delta * move_speed
