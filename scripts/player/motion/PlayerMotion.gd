extends Node

# Reference to the state machine
var fsm: StateMachine

onready var player: KinematicBody2D = get_tree().get_root().get_node(Utils.PLAYER_NODE_PATH)
onready var level: Node2D = get_tree().get_root().get_node("Level")

# Ground motion variables
var max_ground_speed: float
var acceleration: float
var friction: float
var idle_threshold: float

# Aerial motion variables
var gravity: float
var jump_velocity: float
var jump_decceleration: float
var air_jump_multiplier: float
var fall_multiplier: float
var low_fall_multiplier: float
var max_horizontal_air_speed: float
var air_acceleration: float
var air_friction: float

# Attack and damage variables
var knockback_impulse: float
var knockback_counter_impulse: float
var weapon: PackedScene

# Private variables
var _velocity: Vector2 = Vector2.ZERO

# Callback members

func knockback(area):
	var knockback_direction = get_knockback_direction(area)
	exit("Knockback", knockback_direction)
			
# Public members

func get_input_direction():
	var left = int(Input.is_action_pressed("left"))
	var right = int(Input.is_action_pressed("right"))
	
	return (right - left)
	
func get_knockback_direction(area):
	var enemy_direction = owner.global_position.direction_to(area.global_position).normalized()
	var knockback_direction = -enemy_direction
	return knockback_direction
	
func throw_weapon():
	var weapon_instance = weapon.instance()
	var weapon_position = get_weapon_position()
	weapon_instance.position = player.global_position + weapon_position
	level.add_child(weapon_instance)
	
func get_weapon_position():
	return player.weapon_position

# Process handlers

func _ready():
	add_to_group("player_motion")
	_initialize_variables()
	
func unhandled_input(event):
	if event.is_action_pressed("attack"):
		if weapon:
			throw_weapon()
			
	get_tree().set_input_as_handled()
	

func physics_process(delta):
	if not fsm._state.name == "Knockback":
		_velocity = owner.move_and_slide(_velocity, Vector2.UP)
	_velocity.y += gravity * delta

# FSM members

func exit(state_name, args = null):
	if fsm:
		fsm.change_to_state(state_name, args)
	
func back():
	if fsm:
		fsm.return_to_previous_state()

# Private members

func _initialize_variables():
	max_ground_speed = player.max_ground_speed
	acceleration = player.acceleration
	friction = player.friction
	idle_threshold = player.idle_threshold
	
	gravity = player.gravity
	jump_velocity = player.jump_velocity
	jump_decceleration = player.jump_decceleration
	air_jump_multiplier = player.air_jump_multiplier
	fall_multiplier = player.fall_multiplier
	low_fall_multiplier = player.low_fall_multiplier
	max_horizontal_air_speed = player.max_horizontal_air_speed
	air_acceleration = player.air_acceleration
	air_friction = player.air_friction
	
	knockback_impulse = player.knockback_impulse
	knockback_counter_impulse = player.knockback_counter_impulse
	
	weapon = player.weapon
	
	
