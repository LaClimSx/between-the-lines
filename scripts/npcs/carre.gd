extends NPC

var simple_panel: SimplePanel

@export var simple_panel_text : String = "Annoying man: You want some vodka, a beer? \nYou: No thank you."



func interact() -> void:
	simple_panel = SIMPLE_PANEL.instantiate()
	simple_panel.visible = false
	$Panels.add_child(simple_panel)
	simple_panel.setup(tex, simple_panel_text)
	simple_panel.next.connect(next)


func next() -> void:
	if simple_panel:
		simple_panel.queue_free()
		simple_panel = null
	super.interact()
