extends "EnemyMotion.gd"

var is_returning: bool = false

func enter():
	var direction = get_facing_direction()
	owner.flip_sprite(direction)
	
	owner.get_node("AnimationPlayer").play("Move")
	
func process(delta):
	if is_returning:
		return_to_original_position()
	else:
		_should_activate = owner.should_activate()
		var direction = get_facing_direction()
		owner.flip_sprite(direction)
	
		if _should_activate:
			_velocity.x = max_ground_speed * direction
		else:
			.exit("Idle")
		
func return_to_original_position():
	is_returning = true
	var direction = get_original_position_direction()
	owner.flip_sprite(direction)
	
	if direction != 0:
		_velocity.x = max_ground_speed * direction
	elif direction == 0:
		owner.flip_sprite(original_direction)
		is_returning = false
		.exit("Idle")
	
		
func physics_process(delta):
	.physics_process(delta)
