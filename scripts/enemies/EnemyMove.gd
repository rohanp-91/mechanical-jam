extends "EnemyMotion.gd"

func enter():
	var direction = get_facing_direction()
	owner.flip_sprite(direction)
	
	owner.get_node("AnimationPlayer").play("Move")
	
func process(delta):
	_should_activate = owner.should_activate()
	var direction = get_facing_direction()
	owner.flip_sprite(direction)
	
	if _should_activate:
		_velocity.x = max_ground_speed * direction
	else:
		.exit("Idle")
	
		
func physics_process(delta):
	.physics_process(delta)
