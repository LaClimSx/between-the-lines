extends InteractableObject

var QUIT_PANEL : PackedScene  = load("res://scenes/quit_panel.tscn")

signal interacting(panel: Control)

func interact() -> void:
	var panel : Control = QUIT_PANEL.instantiate()
	interacting.emit(panel)
	
