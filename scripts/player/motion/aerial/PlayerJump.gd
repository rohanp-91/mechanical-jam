extends "PlayerAerialMotion.gd"

func initialize(velocity, low_fall = false):
	.initialize(velocity)

func enter():
	_velocity = enter_velocity
	
	var direction = get_input_direction()
	owner.flip_sprite(direction)
	
	owner.get_node("AnimationPlayer").play("Jump")
	.jump()
	
func process(delta):
	var direction = get_input_direction()
	owner.flip_sprite(direction)
	
	.move(direction, delta)
	
	if _velocity.y >= 0:
		.exit("Fall")
	
func physics_process(delta):
	.physics_process(delta)
	
func unhandled_input(event):
	.unhandled_input(event)
	
	
