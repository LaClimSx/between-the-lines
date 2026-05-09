extends NPC

signal change_music

func next() -> void:
	if curr_data.text == "Too late…":
		change_music.emit()
	super()
