extends "EnemyMotion.gd"

func enter():
	_velocity.x = 0
	owner.get_node("AnimationPlayer").play("Idle")
	
func process(delta):
	_should_activate = owner.should_activate()
	if _should_activate:
		.exit("Move")
		
func stop_after_hit():
	.exit("Suspended")
		
func physics_process(delta):
	.physics_process(delta)
