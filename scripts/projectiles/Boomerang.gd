extends Area2D

onready var player: KinematicBody2D = get_tree().get_root().get_node(Utils.PLAYER_NODE_PATH)

var _velocity: Vector2 = Vector2.ZERO
var _max_speed: float = 3.0
var _mass: float = 2.0
var returning: bool = false

func _ready():
	var direction = player.facing
	_velocity.x = direction * _max_speed
	
func _process(delta):
	if returning:
		_velocity = follow(_velocity, global_position, player.global_position)

func _physics_process(delta):
	translate(_velocity)


func follow(velocity, current_position, target_position):
	var desired_velocity = (target_position - current_position).normalized() * _max_speed
	var steering = (desired_velocity - velocity) / _mass
	return velocity + steering


func on_Timer_timeout():
	returning = true
