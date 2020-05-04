extends "EnemyMotion.gd"

func enter():
	print("here")
	_velocity.x = 0
	owner.get_node("AnimationPlayer").play("Idle")
	yield(get_tree().create_timer(1.0), "timeout")
	.back()
