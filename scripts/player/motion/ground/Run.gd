extends "GroundMotion.gd"

func enter():
	var direction = get_input_direction()
	owner.flip_sprite(direction)
	
	owner.get_node("AnimationPlayer").play("Run")
	
func process(delta):
	var direction = get_input_direction()
	if not direction:
		if _velocity.x <= idle_threshold:
			.exit("Idle")
		else:
			stop(_velocity, delta)
		
	owner.flip_sprite(direction)
	_velocity = move(_velocity, direction, delta)
	
	.process(delta)
	
func physics_process(delta):
	.physics_process(delta)
	
func unhandled_input(event):
	return .unhandled_input(event)
	
func move(velocity: Vector2, direction: int, delta: float) -> Vector2:
	velocity.x = lerp(velocity.x, max_ground_speed * direction, acceleration * delta)
	return velocity
	
func stop(velocity, delta) -> Vector2:
	velocity.x = lerp(velocity.x, 0.0, friction * delta)
	return velocity
