extends Area2D

export (Utils.BoxType) var hitbox_type = Utils.BoxType.Player
export (float) var max_speed = 2.5
export (float) var mass = 2.0
export (float) var time = 0.3

onready var player: KinematicBody2D = get_tree().get_root().get_node(Utils.PLAYER_NODE_PATH)
onready var timer: Timer = $Timer

var _velocity: Vector2 = Vector2.ZERO
var _returning: bool = false

func _ready():
	timer.start(time)
	var direction = player.facing
	_velocity.x = direction * max_speed
	
func _process(delta):
	print(_returning)
	rotation_degrees += 15.0
	if _returning:
		_velocity = follow(_velocity, global_position, player.global_position + player.weapon_position)
		var returned = check_if_returned()
		if returned:
			queue_free()

func _physics_process(delta):
	translate(_velocity)


func follow(velocity, current_position, target_position):
	var desired_velocity = (target_position - current_position).normalized() * max_speed
	var steering = (desired_velocity - velocity) / mass
	return velocity + steering
	
func check_if_returned():
	var distance = global_position.distance_to(player.global_position)
	var threshold = player.weapon_position.length()
	return abs(distance) <= abs(threshold)





func on_Timer_timeout():
	_returning = true
