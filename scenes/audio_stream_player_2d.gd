extends AudioStreamPlayer2D




var music_c = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_music_changes() -> void:
	music_c += 1;
	if music_c == 2 :
		print("aga")
		var new_music = load("res://assets/music_end.mp3")
		print(new_music)
		set_stream(new_music)
		play()
