extends KinematicBody2D

export (float) var max_ground_speed = 60.0
export (float) var gravity = 400.0
export (float) var original_position_threshold = 0.05
export (Utils.EnemyFacing) var original_direction = Utils.EnemyFacing.LEFT

onready var _sprite = $Sprites/Sprite
onready var _collisionShape = $CollisionShape2D
onready var _detector = $Detector/CollisionShape2D
onready var _wall_detector_left = $WallDetectorLeft
onready var _wall_detector_right = $WallDetectorRight
onready var _drop_detector_left = $DropDetectorLeft
onready var _drop_detector_right = $DropDetectorRight

var _should_activate: bool = false

func _ready():
	add_to_group("enemy")
	
func _physics_process(delta):
	var collision_left = get_collision_body_name(_wall_detector_left)
	var collision_right = get_collision_body_name(_wall_detector_right)
	if [collision_left, collision_right].has("Player"):
		_should_activate = true
	elif [collision_left, collision_right].has("Foreground"):
		_should_activate = false
	
func should_activate():
	return _should_activate

func on_Detector_body_entered(body):
	if body.name == "Player" and not _should_activate:
		_should_activate = true

func on_Detector_body_exited(body):
	if body.name == "Player" and _should_activate:
		_should_activate = false

func flip_sprite(direction):
	if not [-1, 1].has(direction):
		return
		
	if direction == 1:
		_sprite.flip_h = true
	elif direction == -1:
		_sprite.flip_h = false
		
func get_collision_body_name(raycast: RayCast2D):
	if raycast.is_colliding():
		return raycast.get_collider().name
	return null		

