extends CharacterBody2D
class_name Player


@export var speed : int = 75
const WORLD_BORDERS_MIN: Vector2i = Vector2i(10, 50)
const WORLD_BORDERS_MAX: Vector2i = Vector2i(310, 170)

enum Direction {LEFT, RIGHT, UP, DOWN}

var prev_dir : Direction = Direction.DOWN

func get_input() -> void:
	var input_direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(_delta: float) -> void:
	get_input()
	animate()
	move_and_slide()
	position.x = clamp(position.x, WORLD_BORDERS_MIN.x, WORLD_BORDERS_MAX.x)
	position.y = clamp(position.y, WORLD_BORDERS_MIN.y, WORLD_BORDERS_MAX.y)


func animate() -> void:
	var animation : String = $AnimatedSprite2D.animation
	if velocity == Vector2(0, 0):
		match prev_dir:
			Direction.UP:
				animation = "idle_up"
			Direction.DOWN:
				animation = "idle_down"
			Direction.LEFT:
				animation = "idle_left"
			Direction.RIGHT:
				animation = "idle_right"
	else:
		#DOWN
		if velocity.y >= abs(velocity.x):
			animation = "walking_down"
			prev_dir = Direction.DOWN
		#UP
		elif -velocity.y >= abs(velocity.x):
			animation = "walking_up"
			prev_dir = Direction.UP
		#RIGHT
		elif velocity.x > abs(velocity.y):
			animation = "walking_right"
			prev_dir = Direction.RIGHT
		#LEFT
		else:
			animation = "walking_left"
			prev_dir = Direction.LEFT
	$AnimatedSprite2D.animation = animation
