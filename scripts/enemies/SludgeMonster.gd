extends KinematicBody2D

export (float) var max_ground_speed = 60.0
export (float) var gravity = 400.0
export (float) var original_position_threshold = 0.05
export (Utils.EntityFacing) var original_direction = Utils.EntityFacing.LEFT

onready var _sprite = $Sprites/Sprite
onready var _collisionShape = $CollisionShape2D

onready var _animation_player = $AnimationPlayer

onready var _wall_detector_left = $WallDetectorLeft
onready var _wall_detector_right = $WallDetectorRight
onready var _drop_detector_left = $DropDetectorLeft
onready var _drop_detector_right = $DropDetectorRight

onready var _hitbox = $Hitbox


var priority_map: Dictionary = {
	"Any": false,
	"PlayerLeft" : false,
	"PlayerRight" : false}
var priority: String = Utils.STRING_EMPTY
var prev_priority: String = Utils.STRING_EMPTY

func _ready():
	add_to_group("enemy")
	priority = "Any"
	
func _physics_process(delta):
	var collision_left = get_collision_body_name(_wall_detector_left)
	var collision_right = get_collision_body_name(_wall_detector_right)
	
	priority_map["Any"] = priority_map["Any"] or priority_map["PlayerRight"] or priority_map["PlayerLeft"]	
	priority_map["PlayerLeft"] = true if collision_left == "Player" else false
	priority_map["PlayerRight"] = true if collision_right == "Player" else false
	
	if not _drop_detector_left.is_colliding():
		prev_priority = priority
		priority = "PlayerRight"
	elif not _drop_detector_right.is_colliding():
		prev_priority = priority
		priority = "PlayerLeft"
	else:
		prev_priority = priority
		priority = "Any"
	

func should_activate():
	return priority_map[priority] if priority else false

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

func on_Hitbox_area_entered(area):
	if "hurtbox_type" in area:
		if area.hurtbox_type == Utils.BoxType.Player:
			get_tree().call_group("enemy_motion", "stop_after_hit")


func on_Hurtbox_area_entered(area):
	if "hitbox_type" in area:
		if area.hitbox_type == Utils.BoxType.Player:
			get_tree().call_group("enemy_motion", "hurt")
			
