extends Node

var fsm: StateMachine

onready var player: KinematicBody2D = get_tree().get_root().get_node(Utils.PLAYER_NODE_PATH)
onready var enemy: KinematicBody2D = get_tree().get_root().get_node(Utils.ENEMY_NODE_PATH % owner.name)

var max_ground_speed: float
var gravity: float
var original_position: Vector2
var original_position_threshold: float
var original_direction: int

var _velocity: Vector2 = Vector2.ZERO
var _should_activate: bool = false

func _ready():
	add_to_group("enemy_motion")
	_initialize_variables()
	original_position = owner.global_position
	
func physics_process(delta):
	_velocity = owner.move_and_slide(_velocity, Vector2.UP)	
	_velocity.y += gravity * delta
	
func exit(state_name, args = null):
	fsm.change_to_state(state_name, args)
	
func back():
	fsm.return_to_previous_state()
		
func get_facing_direction():
	var direction = owner.global_position.direction_to(player.global_position)
	if direction.x < 0.0:
		return -1
	return 1
	
func get_original_position_direction():
	var direction = owner.global_position.direction_to(original_position)
	if abs(direction.x) <= original_position_threshold:
		return 0
	elif direction.x < 0.0:
		return -1
	return 1
	
func _initialize_variables():
	max_ground_speed = enemy.max_ground_speed
	gravity = enemy.gravity
	original_position_threshold = enemy.original_position_threshold
	original_direction = enemy.original_direction
