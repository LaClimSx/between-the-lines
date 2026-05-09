extends NPC

@export var interaction_data_minus : NPCData
@export var path_follow: PathFollow2D

@export var move_speed : float

var prev_pos : Vector2 = global_position 

func _input(event: InputEvent) -> void:
	if player_inside_area && event.is_action_pressed("interact") && not interacted:
		curr_data = interaction_data if Global.score >= 0 else interaction_data_minus
		interact()
		interacted = true
		$AnimatedSprite2D.animation = "interacted"
		Global.timer.start(Global.timer.time_left - 60)


func _process(delta: float) -> void:
	path_follow.progress_ratio += delta * move_speed
	var velocity: Vector2 = global_position - prev_pos
	var animation : String = $AnimatedSprite2D.animation
	#DOWN
	if velocity.y >= abs(velocity.x):
		animation = "walking_down_default" if not interacted else "walking_down_interacted"
	#UP
	elif -velocity.y >= abs(velocity.x):
		animation = "walking_up_default" if not interacted else "walking_up_interacted"
	#RIGHT
	elif velocity.x > abs(velocity.y):
		animation = "walking_right_default" if not interacted else "walking_right_interacted"
	#LEFT
	else: 
		animation = "walking_left_default" if not interacted else "walking_left_interacted"
	$AnimatedSprite2D.animation = animation
	prev_pos = global_position
