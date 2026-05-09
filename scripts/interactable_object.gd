extends Area2D
class_name InteractableObject

@export var highlightable : bool = false
@export var panel_scene: PackedScene

var player_inside_area: bool = false
var interacted: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _unhandled_input(event : InputEvent) -> void:
	if player_inside_area && not interacted && event.is_action_pressed("interact"):
		interact()


func interact() -> void:
	$AnimatedSprite2D.frame = 0
	var panel: ObjectSimplePanel = panel_scene.instantiate()
	$Panels.add_child(panel)
	panel.show_panel()
	Global.score += 1
	interacted = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside_area = true
		if not interacted and highlightable: $Timer.start(1.5)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside_area = false
		if highlightable:
			$Timer.stop()
			$AnimatedSprite2D.frame = 0


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.frame = 1
