extends KinematicBody2D

# Ground variables
export (float) var max_ground_speed = 100.0
export (float) var acceleration = 50.0
export (float) var friction = 30.0
export (float) var idle_threshold = 5.0

# Aerial variables
export (float) var gravity = 400.0
export (float) var jump_velocity = 180.0
export (float) var jump_decceleration = 25.0
export (float) var air_jump_multiplier = 0.75
export (float) var fall_multiplier = 2.5
export (float) var low_fall_multiplier = 1.5
export (float) var max_horizontal_air_speed = 120.0
export (float) var air_acceleration = 75.0
export (float) var air_friction = 20.0

# Attack and damage variables
export (float) var knockback_impulse = 100.0
export (float) var knockback_counter_impulse = 30.0

# Light variables
export (float) var light_reducer = 0.5
export (float) var light_multiplier = 1.0

# Child accessors
onready var _sprite = $Sprites/Sprite
onready var _light = $Light

func _ready():
	add_to_group("player")
	
func _process(delta):
	decrease_light(delta)
	
func flip_sprite(direction):
	if not [-1, 1].has(direction):
		return
		
	if direction == 1:
		_sprite.flip_h = false
	elif direction == -1:
		_sprite.flip_h = true
	
func decrease_light(delta):
	var current_scale = _light.transform.get_scale()
	current_scale -= Vector2.ONE * light_reducer * delta
	if current_scale < Vector2.ZERO:
		current_scale = Vector2.ZERO
	_light.set_scale(current_scale)
	
func increase_light():
	var current_scale = _light.transform.get_scale()
	current_scale += Vector2.ONE * light_multiplier
	_light.set_scale(current_scale)


func on_Hurtbox_area_entered(area):
	if "hitbox_type" in area:
		if area.hitbox_type == Utils.HitboxType.Enemy:
			get_tree().call_group("player_motion", "knockback", area)
