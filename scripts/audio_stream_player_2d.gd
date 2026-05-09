extends AudioStreamPlayer2D

func _on_change_music() -> void:
	var new_music : AudioStreamMP3 = load("res://assets/music_mc.mp3")
	set_stream(new_music)
	play()
