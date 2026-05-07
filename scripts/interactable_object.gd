extends Area2D
class_name InteractableObject

var player_inside_area: bool = false
var interacted: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _unhandled_input(event : InputEvent) -> void:
	if player_inside_area && not interacted && event.is_action_pressed("interact"):
		interact()
		interacted = true


func interact() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside_area = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside_area = false
