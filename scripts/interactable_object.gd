extends Area2D
class_name InteractableObject

var player_inside_area: bool = false
var interacted: bool = false


func _unhandled_input(event : InputEvent) -> void:
	if player_inside_area && event.is_action_pressed("interact"):
		print("coubeh")


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside_area = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside_area = false
