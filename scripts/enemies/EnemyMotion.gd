extends Node

var fsm: StateMachine

onready var player: KinematicBody2D = get_tree().get_root().get_node(Utils.PLAYER_NODE_PATH)
onready var enemy: KinematicBody2D = get_tree().get_root().get_node(Utils.ENEMY_NODE_PATH % owner.name)

var max_ground_speed: float
var gravity: float

var _velocity: Vector2 = Vector2.ZERO
var _should_activate: bool = false

func _ready():
	add_to_group("enemy_motion")
	_initialize_variables()
	
func physics_process(delta):
	_velocity = owner.move_and_slide(_velocity, Vector2.UP)	
	_velocity.y += gravity * delta
	
func hurt():
	exit("Hurt")
	
func stop_after_hit():
	exit("Suspended")
	
	
func exit(state_name, args = null):
	if fsm:
		fsm.change_to_state(state_name, args)
	
func back():
	if fsm:
		fsm.return_to_previous_state()
		
func get_facing_direction():
	var player_direction = owner.global_position.direction_to(player.global_position)
	var direction = -1 if player_direction.x < 0.0 else 1
	return direction
	
func _initialize_variables():
	max_ground_speed = enemy.max_ground_speed
	gravity = enemy.gravity
