extends "../Motion.gd"

func unhandled_input(event):
	if event.is_action_pressed("jump"):
		.exit("Jump")
	return .unhandled_input(event)
	
func process(delta):
	if not owner.is_on_floor():
		.exit("Fall")
		
func physics_process(delta):
	.physics_process(delta)
