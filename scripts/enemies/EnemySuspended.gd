extends "EnemyMotion.gd"

func enter():
	_velocity.x = 0.0
	is_suspended = true
		
	owner.get_node("AnimationPlayer").play("Idle")
	yield(get_tree().create_timer(1.0), "timeout")
	
	is_suspended = false
	.back()
	
