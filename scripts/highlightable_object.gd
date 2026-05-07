extends InteractableObject


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.frame = 1


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside_area = true
		if not interacted: $Timer.start(1.5)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside_area = false
		$Timer.stop()
		$AnimatedSprite2D.frame = 0
