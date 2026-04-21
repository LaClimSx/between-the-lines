extends StaticBody2D
class_name NPC


@export var interaction_data: NPCData
@export var npc_name: String

const INTERACTION_PANEL = preload("res://scenes/interaction_panel.tscn")
const SIMPLE_PANEL = preload("res://scenes/simple_panel.tscn")

var curr_data : NPCData

var player_inside_area: bool = false
var interacted: bool = false

func _input(event: InputEvent) -> void:
	if player_inside_area && event.is_action_pressed("interact") && not interacted:
		curr_data = interaction_data
		interact()
		interacted = true

func interact() -> void:
	if curr_data is NPCInteractionData:
		var interaction_panel: InteractionPanel = INTERACTION_PANEL.instantiate()
		interaction_panel.visible = false
		$Panels.add_child(interaction_panel)
		interaction_panel.setup(
			curr_data.tex, curr_data.question, 
			[curr_data.answer1, curr_data.answer2, curr_data.answer3], 
			curr_data.locked_answers, curr_data.timer_duration)
		interaction_panel.answered.connect(_received_answer)
		interaction_panel.too_late.connect(func() -> void: _received_answer(-1))
	elif curr_data is NPCSimpleData:
		var simple_panel: SimplePanel = SIMPLE_PANEL.instantiate()
		simple_panel.visible = false
		$Panels.add_child(simple_panel)
		simple_panel.setup(curr_data.tex, curr_data.text)
		simple_panel.next.connect(next)
	else:
		if curr_data.optional_score != 0:
			Global.score = curr_data.optional_score


func _received_answer(answer_nb: int) -> void:
	if curr_data is NPCInteractionData:
		if answer_nb == -1:
			if $Panels.get_child_count() != 0:
				$Panels.get_child(0).queue_free()
			Global.score = -2
			return
		var next_data : NPCData = curr_data.answer_conclusions[answer_nb]
		curr_data = next_data
		if $Panels.get_child_count() != 0:
			$Panels.get_child(0).queue_free()
		interact()


func next() -> void:
	if $Panels.get_child_count() != 0:
		$Panels.get_child(0).queue_free()
	if curr_data.optional_score != 0:
		Global.score = curr_data.optional_score
	if curr_data is NPCSimpleData:
		curr_data = curr_data.next
		if curr_data: interact()


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside_area = true


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside_area = false
