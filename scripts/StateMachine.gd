extends Node

class_name StateMachine

# Public variables
export (String) var starting_state

# Constants
const DEBUG = false

# Private variables
var _state: Object = null
var _prev_state: Object = null
var _state_history = []
var _state_map = {}

func _ready():
	_populate_state_map()
	_state = _state_map[starting_state]
	
	call_deferred("_enter_state")
	
func change_to_state(new_state: String, args = null):
	if new_state == _state.name:
		return
	_state_history.push_front(_state.name)
	_prev_state = _state
	_state = _state_map[new_state]
	if _state.has_method("initialize"):
		_state.initialize(_prev_state._velocity, _prev_state._jump_count, args)
	_enter_state()

func return_to_previous_state():
	if _state_history.size() <= 0:
		push_warning("State history is empty")
		return
	_state = _state_map[_state_history.pop_front()]
	_enter_state()

#-----------------------
# State Machine Methods	
#-----------------------

# Enters the state assigned to _state
func _enter_state():
	if DEBUG:
		print("Entering state: ", _state.name)
	_state.fsm = self
	if !_state.has_method("enter"):
		push_error("State %s doesn't implement enter method" %_state.name)
		return
	_state.enter()

# Populates a map for all host states: {<state_name> : <state_node>}
func _populate_state_map():
	var states = get_children()
	for state in states:
		_state_map[state.name] = state
	if DEBUG:
		print(_state_map)
		
#-------------------
# Game loop methods
#-------------------

func _process(delta):
	if _state.has_method("process"):
		_state.process(delta)
		
func _physics_process(delta):
	if _state.has_method("physics_process"):
		_state.physics_process(delta)
		
func _input(event):
	if _state.has_method("input"):
		_state.input(event)
		
func _unhandled_input(event):
	if _state.has_method("unhandled_input"):
		_state.unhandled_input(event)

func _unhandled_key_input(event):
	if _state.has_method("unhandled_key_input"):
		_state.unhandled_key_input(event)
		
func _notification(what):
	if _state:
		if _state.has_method("notification"):
			_state.notification(what)
