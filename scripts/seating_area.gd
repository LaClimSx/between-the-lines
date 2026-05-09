extends Area2D

var player_inside_area: bool = false
var interacted: bool = false

signal sitting

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _unhandled_input(event : InputEvent) -> void:
	if player_inside_area && not interacted && event.is_action_pressed("interact"):
		interact()


func interact() -> void:
	sitting.emit()
	Global.score += 1
	interacted = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside_area = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside_area = false
