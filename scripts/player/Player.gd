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
