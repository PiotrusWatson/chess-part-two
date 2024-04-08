extends Node2D
var state_builder: StateBuilder
@export var distance_modifier = 2
func _ready():
	state_builder = StateBuilder.new()
	state_builder.generate_zones()
	var states = state_builder.build_states()
	states.decide_which_states_are_empty()
	states.get_visible_states(self)
	
