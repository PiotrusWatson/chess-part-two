extends Object

class_name CityState


enum StateType{NONE, CITY}
var name: String
var voronoi_site: Delaunay.VoronoiSite
var neighbours = []

func _init(site: Delaunay.VoronoiSite):
	var name_generator = NameGenerator.new()
	name = name_generator.generate_simple_name()
	voronoi_site = site

func is_in_neighbours(site: Delaunay.VoronoiSite):
	for neighbour_edge in voronoi_site.neighbours:
		if neighbour_edge.other == site:
			return true
	return false

func add_neighbour_back(other: CityState):
	if is_in_neighbours(other.voronoi_site):
		neighbours.append(other)

func get_old_neighbours():
	return voronoi_site.neighbours
	
func make_polygon() -> Polygon2D:
	var polygon = Polygon2D.new()
	var p = voronoi_site.polygon
	p.append(p[0])
	polygon.polygon = p
	return polygon
	
