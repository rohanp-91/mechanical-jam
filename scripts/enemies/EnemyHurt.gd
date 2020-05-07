extends "EnemyMotion.gd"

func enter():
	_velocity.x = 0.0
	
	owner.get_node("AnimationPlayer").play("Hurt")
	yield(owner.get_node("AnimationPlayer"), "animation_finished")
	
	.back()
