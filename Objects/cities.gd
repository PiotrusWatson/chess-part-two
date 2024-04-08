extends Object

class_name CityStates

var delaunay
var states
func _init(states, delaunay):
	self.delaunay = delaunay
	self.states = states

func is_border_of_world(state: CityState):
	return delaunay.is_border_site(state.get_site())
	
func decide_which_states_are_empty(noise: FastNoiseLite):
	for state in states:
		if is_border_of_world(state):
			state.decide_state_type(CityState.StateType.NONE)
		else:
			var centre = state.get_centre()
			state.set_height(noise.get_noise_2d(centre.x, centre.y))

func get_visible_states(parent: Node):
	for state in states:
		var polygon = state.make_polygon()
		parent.add_child(polygon)
