extends StaticBody2D
class_name NPC


@export var tex: CompressedTexture2D
@export var question: String
@export var answer1: String
@export var answer2: String
@export var answer3: String
@export var answers_order: Array[int]

const INTERACTION_PANEL = preload("res://scenes/interaction_panel.tscn")

var player_inside_area: bool = false

func _input(event: InputEvent) -> void:
	if player_inside_area && event.is_action_pressed("interact"):
		print("interacting with NPC: " + name)
		var panel : InteractionPanel = INTERACTION_PANEL.instantiate()
		panel.visible = false
		add_child(panel)
		panel.setup(tex, question, [answer1, answer2, answer3], answers_order)
		panel.answered.connect(_received_answer)
		panel.too_late.connect(func() -> void: _received_answer(-2))

# placeholder function to test
func _received_answer(score: int) -> void:
	print("Answered with a score of: ", score)
	Global.score = score


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside_area = true


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside_area = false
