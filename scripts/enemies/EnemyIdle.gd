extends "EnemyMotion.gd"

func enter():
	owner.get_node("AnimationPlayer").play("Idle")
	
func process(delta):
	_should_activate = owner.should_activate()
	if _should_activate:
		.exit("Move")
		
func physics_process(delta):
	.physics_process(delta)
