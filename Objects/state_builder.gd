extends Object

class_name StateBuilder

static func build_states(voronoi_sites: Array[Delaunay.VoronoiSite]):
	var sites_to_states = {}
	for site in voronoi_sites:
		var current_state = CityState.new(site)
		sites_to_states[site] = current_state
	
	for state in sites_to_states.values():
		var neighbours = state.get_old_neighbours()
		for neighbour in neighbours:
			state.add_neighbour_back(sites_to_states[neighbour])
	
	return sites_to_states.values()
	
	
