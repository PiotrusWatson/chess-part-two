extends Object

class_name CityState


enum StateType{NONE, CITY}
var name: String
var voronoi_site: Delaunay.VoronoiSite
var neighbours = []
var type: StateType

func get_site():
	return voronoi_site

func _init(site: Delaunay.VoronoiSite):
	var name_generator = NameGenerator.new()
	name = name_generator.generate_simple_name()
	voronoi_site = site
	type = StateType.CITY

func is_in_neighbours(site: Delaunay.VoronoiSite):
	for neighbour_edge in voronoi_site.neighbours:
		if neighbour_edge.this == site:
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
	polygon = randomly_colour_polygon(polygon)
	return polygon
	
func randomly_colour_polygon(polygon: Polygon2D) -> Polygon2D:
	polygon.color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),0.5)
	return polygon
