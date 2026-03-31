extends StaticBody2D
class_name NPC


@export var tex: CompressedTexture2D
@export var question: String
@export var answer1: String
@export var answer2: String
@export var answer3: String
@export var answers_order: Array[int]

const INTERACTION_PANEL = preload("res://scenes/interaction_panel.tscn")
const SIMPLE_PANEL = preload("res://scenes/simple_panel.tscn")

var interaction_panel : InteractionPanel

var player_inside_area: bool = false
var interacted: bool = false

func _input(event: InputEvent) -> void:
	if player_inside_area && event.is_action_pressed("interact") && not interacted:
		interact()
		interacted = true

func interact() -> void:
	interaction_panel = INTERACTION_PANEL.instantiate()
	interaction_panel.visible = false
	$Panels.add_child(interaction_panel)
	interaction_panel.setup(tex, question, [answer1, answer2, answer3], answers_order)
	interaction_panel.answered.connect(_received_answer)
	interaction_panel.too_late.connect(func() -> void: _received_answer(-2))


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
