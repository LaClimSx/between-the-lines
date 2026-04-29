extends Control

@onready var MAIN_SCENE : PackedScene = load("res://scenes/main.tscn")

func _ready() -> void:
	$StartButton.grab_focus.call_deferred()
	
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_SCENE)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
