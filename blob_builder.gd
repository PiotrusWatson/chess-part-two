extends Node2D
var delaunay
func _ready():
	delaunay = Delaunay.new()
	for i in range(10):
		for j in range(10):
			delaunay.add_point(Vector2(50 + i*100 + randi_range(-15,15), 50 + j * 50 + randi_range(-15,15)))
	
	var triangles = delaunay.triangulate()
	for triangle in triangles:
		if !delaunay.is_border_triangle(triangle):
			show_triangle(triangle)
	var sites = delaunay.make_voronoi(triangles)
	for site in sites:
		if !delaunay.is_border_site(site): # do not render border sites
			show_site(site)
		if site.neighbours.size() == site.source_triangles.size(): # sites on edges will have incomplete neighbours information
			for neighbour_edge in site.neighbours:
				show_neighbour(neighbour_edge)

func show_site(site: Delaunay.VoronoiSite):
####As Polygons
	var polygon = Polygon2D.new()
	var p = site.polygon
	p.append(p[0])
	polygon.polygon = p
	polygon.color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),0.5)
	polygon.z_index = -1
	add_child(polygon)
	
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
	

func add_point(point: Vector2):
	var polygon = Polygon2D.new()
	var p = PackedVector2Array()
	var s = 5
	p.append(Vector2(-s,s))
	p.append(Vector2(s,s))
	p.append(Vector2(s,-s))
	p.append(Vector2(-s,-s))
	polygon.polygon = p
	polygon.color = Color.BURLYWOOD
	polygon.position = point
	add_child(polygon)
	delaunay.add_point(point)

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
