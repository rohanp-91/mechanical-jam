extends KinematicBody2D

export (float) var max_ground_speed = 60.0
export (float) var gravity = 400.0

onready var _sprite = $Sprites/Sprite

var _should_activate: bool = false

func should_activate():
	return _should_activate


func on_Detector_body_entered(body):
	if body.name == "Player":
		_should_activate = true

func on_Detector_body_exited(body):
	if body.name == "Player":
		_should_activate = false

func flip_sprite(direction):
	if not [-1, 1].has(direction):
		return
		
	if direction == 1:
		_sprite.flip_h = true
	elif direction == -1:
		_sprite.flip_h = false
