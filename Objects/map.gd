extends Node

var map : TileMap
var actors
const GROUND_LAYER = 0
var WALL_LAYER

func read_map(new_map):
	map = new_map
	actors = {}
	WALL_LAYER = map.get_layers_count() - 1

func can_move(coord: Vector2i):
	return map.get_cell_tile_data(GROUND_LAYER, coord) != null and \
	map.get_cell_tile_data(WALL_LAYER, coord) == null
	
func get_map_coord(coord: Vector2):
	return map.local_to_map(map.to_local(coord))
	
func get_global_coord(coord: Vector2i):
	return map.to_global(map.map_to_local(coord))
	
func update_actor(node: Node2D, position: Vector2i):
	actors[node] = position
