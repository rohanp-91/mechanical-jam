extends "PlayerGroundMotion.gd"

func enter():
	_velocity.x = 0
	owner.get_node("AnimationPlayer").play("Idle")
	
func unhandled_input(event):
	return .unhandled_input(event)

func process(delta):
	var direction = get_input_direction()
	if direction:
		.exit("Run")
	.process(delta)
		
func physics_process(delta):
	.physics_process(delta)
