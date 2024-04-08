extends Object

class_name CityState


enum StateType{NONE, CITY}
var name: String
var name_generator: NameGenerator
var voronoi_site: Delaunay.VoronoiSite
var neighbours = []
var type: StateType
var color: Color
func get_site():
	return voronoi_site

func _init(site: Delaunay.VoronoiSite):
	name_generator = NameGenerator.new()
	voronoi_site = site
	decide_state_type(StateType.CITY)

func is_in_neighbours(site: Delaunay.VoronoiSite):
	for neighbour_edge in voronoi_site.neighbours:
		if neighbour_edge.this == site:
			return true
	return false

func decide_state_type(type: StateType):
	self.type = type
	if type == StateType.CITY:
		randomly_generate_color()
		name = name_generator.generate_simple_name()
	else:
		color = Color.TRANSPARENT
		name = ""
		
func add_neighbour_back(other: CityState):
	if is_in_neighbours(other.voronoi_site):
		neighbours.append(other)

func get_old_neighbours():
	return voronoi_site.neighbours

func make_label() -> Label:
	var label = Label.new()
	label.text = name
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.global_position = voronoi_site.center
	return label

func make_polygon() -> Polygon2D:
	var polygon = Polygon2D.new()
	var p = voronoi_site.polygon
	p.append(p[0])
	polygon.polygon = p
	polygon.color = color
	polygon.add_child(make_label())
	return polygon

func randomly_generate_color():
	color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),0.5)
func randomly_colour_polygon(polygon: Polygon2D) -> Polygon2D:
	polygon.color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),0.5)
	return polygon
