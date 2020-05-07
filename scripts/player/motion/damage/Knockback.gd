extends "../PlayerMotion.gd"

const KNOCKBACK_THRESHOLD = 1.0

var knockback_velocity: Vector2 = Vector2.ZERO
var knockback_direction: Vector2 = Vector2.ZERO

func initialize(velocity, knocback_dir = null):
	knockback_direction = knocback_dir

func enter():
	is_in_knockback = true
	knockback_velocity = knockback_direction * knockback_impulse
	owner.get_node("AnimationPlayer").play("Hurt")

func process(delta):
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_counter_impulse * delta)
	if knockback_velocity.length() <= KNOCKBACK_THRESHOLD:
		is_in_knockback = false
		.exit("Idle")
	
func physics_process(delta):
	knockback_velocity = owner.move_and_slide(knockback_velocity)
	.physics_process(delta)
