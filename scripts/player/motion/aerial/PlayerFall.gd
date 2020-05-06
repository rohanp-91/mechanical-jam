extends "PlayerAerialMotion.gd"

var is_low_fall: bool = false

func initialize(velocity, low_fall = false):
	if low_fall:
		is_low_fall = true
	else:
		is_low_fall = false
		
	.initialize(velocity)

func enter():
	_velocity = enter_velocity
	
	var direction = get_input_direction()
	owner.flip_sprite(direction)
	
	owner.get_node("AnimationPlayer").play("Fall")
	
func process(delta):
	var direction = get_input_direction()
	owner.flip_sprite(direction)
	
	.move(direction, delta)
	
	if is_low_fall == true:
		_velocity.y += gravity * (low_fall_multiplier - 1) * delta
	else:
		_velocity.y += gravity * (fall_multiplier - 1) * delta
		
	if owner.is_on_floor():
		air_jump = true
		.exit("Idle")
		
func physics_process(delta):
	.physics_process(delta)
	
func unhandled_input(event):
	return .unhandled_input(event)
