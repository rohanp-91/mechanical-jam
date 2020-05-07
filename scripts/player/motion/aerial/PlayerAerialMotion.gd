extends "../PlayerMotion.gd"
	
var enter_velocity: Vector2
var air_jump: bool = false

func initialize(velocity, low_fall = false):
	enter_velocity = velocity
	
func move(direction, delta):
	if direction:
		_velocity.x = lerp(_velocity.x, max_horizontal_air_speed * direction, air_acceleration * delta)
	else:
		_velocity.x = lerp(_velocity.x, 0.0, air_friction * delta)
		
func jump(air_jump: bool = false):
	if air_jump == true:
		_velocity.y = -jump_velocity * air_jump_multiplier
	else:
		_velocity.y = -jump_velocity
	
func physics_process(delta):
	.physics_process(delta)

func unhandled_input(event):
	if _velocity.y < 0 and event.is_action_released("jump"):
		var delta = get_physics_process_delta_time()
		_velocity.y = lerp(_velocity.y, 0.0, jump_decceleration * delta)
		.exit("Fall", true)
	elif event.is_action_pressed("jump") and air_jump:
		air_jump = false
		.exit("Jump")
	return .unhandled_input(event)
