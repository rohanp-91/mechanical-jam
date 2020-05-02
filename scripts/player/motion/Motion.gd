extends Node

# Reference to the state machine
var fsm: StateMachine

onready var player: KinematicBody2D = get_tree().get_root().get_node(Utils.PLAYER_NODE_PATH)

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

# Private variables
var _velocity: Vector2 = Vector2.ZERO

# Process handlers

func _ready():
	_initialize_variables()
	if not owner.is_in_group("player"):
		add_to_group("player")
	
func unhandled_input(event):
	get_tree().set_input_as_handled()
	
func physics_process(delta):
	_velocity = owner.move_and_slide(_velocity, Vector2.UP)
	_velocity.y += gravity * delta

# FSM members

func exit(state_name, args = null):
	fsm.change_to_state(state_name, args)
	
func back():
	fsm.return_to_previous_state()
	

# Public members

func get_input_direction():
	var left = int(Input.is_action_pressed("left"))
	var right = int(Input.is_action_pressed("right"))
	
	return (right - left)


func flip_sprite(direction):
	if not [-1, 1].has(direction):
		return
		
	var sprite = owner.get_node("Sprites/Sprite")
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true
		
func stop_vertical_motion():
	_velocity.y = 0

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
	
	
	
	
	
