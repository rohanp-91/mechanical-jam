extends "EnemyMotion.gd"

func enter():
	owner.get_node("AnimationPlayer").play("Hurt")
	yield(get_tree().create_timer(0.5), "timeout")
	.exit("Idle")
