extends "EnemyMotion.gd"

func enter():
	_velocity.x = 0.0
	
	owner.get_node("AnimationPlayer").play("Die")
	yield(owner.get_node("AnimationPlayer"), "animation_finished")
	
	owner.queue_free()
	
