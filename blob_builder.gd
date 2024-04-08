extends Node2D
var state_builder: StateBuilder
@export var distance_modifier = 2
@export var threshold = 0.01
@export var noise: FastNoiseLite
func _ready():
	state_builder = StateBuilder.new(threshold)
	state_builder.generate_zones()
	var states = state_builder.build_states()
	states.decide_which_states_are_empty(noise)
	states.get_visible_states(self)
	
