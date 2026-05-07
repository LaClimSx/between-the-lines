extends InteractableObject

signal sitting

func interact() -> void:
	sitting.emit()
	Global.score += 1
	interacted = true
