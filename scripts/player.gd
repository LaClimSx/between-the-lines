extends CharacterBody2D
class_name Player


@export var speed : int = 75

enum Direction {LEFT, RIGHT, UP, DOWN}

var prev_dir : Direction = Direction.DOWN

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	animate()
	move_and_slide()


func animate():
	var animation = $AnimatedSprite2D.animation
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
