extends "EnemyMotion.gd"

func enter():
	_velocity.x = 0.0
	is_hurt = true
	
	owner.get_node("AnimationPlayer").play("Hurt")
	yield(owner.get_node("AnimationPlayer"), "animation_finished")
	
	is_hurt = false
	.back()
