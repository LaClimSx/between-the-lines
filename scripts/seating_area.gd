extends InteractableObject

signal sitting

func interact() -> void:
	sitting.emit()
