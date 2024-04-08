extends Object

class_name StateBuilder
var delaunay
var start_point: Vector2
var distance: float
var random_flibble: int
var relax_amount: int
var threshold: float
var triangles
var sites
func _init(threshold, _start_point= Vector2(50, 50), _distance = 100, _random_flibble=15, relax_amount = 2):
	delaunay = Delaunay.new()
	start_point = _start_point
	distance = _distance
	random_flibble = _random_flibble
	self.relax_amount = relax_amount
	self.threshold = threshold

func generate_zones(zone_numbers = Vector2(10, 10)):
	for i in range(zone_numbers.x):
		for j in range(zone_numbers.y):
			add_point(i, j)
	triangles = delaunay.triangulate()
	sites = delaunay.make_voronoi(triangles)
	var result_dict = delaunay.relax_multiple_times(sites, 3)
	triangles = result_dict["triangles"]
	sites = result_dict["sites"]
	
func add_point(x, y):
	var x_position = start_point.x + x * distance + randi_range(-random_flibble,random_flibble)
	var y_position = start_point.y + y * distance/2 + randi_range(-random_flibble,random_flibble)
	delaunay.add_point(Vector2(x_position,y_position))
	
func build_states():
	var sites_to_states = {}
	for site in sites:
		var current_state = CityState.new(site, threshold)
		sites_to_states[site] = current_state
	
	for state in sites_to_states.values():
		var neighbours = state.get_old_neighbours()
		for neighbour in neighbours:
			state.add_neighbour_back(sites_to_states[neighbour.other])
	
	var states = sites_to_states.values()
	return CityStates.new(states, delaunay)
	

		
	
