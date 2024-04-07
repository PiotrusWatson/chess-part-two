extends Object

class_name StateBuilder
var delaunay
var start_point: Vector2
var distance: float
var random_flibble: int

var triangles
var sites
func _init(_start_point= Vector2(50, 50), _distance = 100, _random_flibble=15):
	delaunay = Delaunay.new()
	start_point = _start_point
	distance = _distance
	random_flibble = _random_flibble

func generate_zones(zone_numbers = Vector2(10, 10)):
	for i in range(zone_numbers.x):
		for j in range(zone_numbers.y):
			add_point(i, j)
	triangles = delaunay.triangulate()
	sites = delaunay.make_voronoi(triangles)
	var result_dict = delaunay.relax_multiple_times(sites, 2)
	triangles = result_dict["triangles"]
	sites = result_dict["sites"]
	
func add_point(x, y):
	var x_position = start_point.x + x * distance + randi_range(-random_flibble,random_flibble)
	var y_position = start_point.y + y * distance/2 + randi_range(-random_flibble,random_flibble)
	delaunay.add_point(Vector2(x_position,y_position))
	
func build_states():
	var sites_to_states = {}
	for site in sites:
		var current_state = CityState.new(site)
		sites_to_states[site] = current_state
	
	for state in sites_to_states.values():
		var neighbours = state.get_old_neighbours()
		for neighbour in neighbours:
			state.add_neighbour_back(sites_to_states[neighbour.other])
	
	var states = sites_to_states.values()
	decide_which_states_are_empty(states)
	return states
	
func decide_which_states_are_empty(states):
	for state in states:
		if delaunay.is_border_site(state.get_site()):
			state.type = CityState.StateType.NONE

func get_visible_states(parent: Node, states):
	for state in states:
		var polygon = state.make_polygon()
		parent.add_child(polygon)
		
	
