extends Node2D
var state_builder: StateBuilder
@export var distance_modifier = 2
func _ready():
	state_builder = StateBuilder.new()
	state_builder.generate_zones()
	var states = state_builder.build_states()
	state_builder.decide_which_states_are_empty(states)
	state_builder.get_visible_states(self, states)
	
func show_neighbour(edge: Delaunay.VoronoiEdge):
	var line = Line2D.new()
	var points: PackedVector2Array
	var l = 6
	var s = lerp(edge.a, edge.b, 0.6)
	var dir = edge.a.direction_to(edge.b).orthogonal()
	points.append(s + dir * l)
	points.append(s - dir * l)
	line.points = points
	line.width = 1
	line.default_color = Color.CYAN
	add_child(line)
	

func show_triangle(triangle: Delaunay.Triangle):
	var line = Line2D.new()
	var p = PackedVector2Array()
	p.append(triangle.a)
	p.append(triangle.b)
	p.append(triangle.c)
	p.append(triangle.a)
	line.points = p
	line.width = 1
	line.antialiased
	add_child(line)
