extends NPCData
class_name NPCInteractionData

@export_multiline var question: String
@export var answer1 : String
@export var answer2: String
@export var answer3: String
@export var answer_conclusions: Array[NPCData]
@export var timer_duration: int = 15
@export var locked_answers: Array[bool] = [false, false, false]
