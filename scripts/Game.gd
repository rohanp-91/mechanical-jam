extends Node2D

var _level_num = 1

func _ready():
	call_deferred("init_level")
	
func init_level():
	load_level(_level_num)
	
func load_level(level_num: int):
	var root = get_tree().root
	if root.has_node(Utils.LEVEL_NAME):
		var level = root.get_node(Utils.LEVEL_NAME)
		root.remove_child(level)
		level.queue_free()
		
	var level = load(Utils.LEVEL_PATH % level_num).instance()
	root.add_child(level)
	return true
	
func load_next_level():
	_level_num += 1
	load_level(_level_num)
