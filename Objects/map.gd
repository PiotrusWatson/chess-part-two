extends Node

var map : TileMap
var actors_to_positions
var positions_to_actors
const GROUND_LAYER = 0
var WALL_LAYER

func read_map(new_map):
	map = new_map
	actors_to_positions = {}
	positions_to_actors = {}
	WALL_LAYER = map.get_layers_count() - 1

func can_move(coord: Vector2i):
	return map.get_cell_tile_data(GROUND_LAYER, coord) != null and \
	map.get_cell_tile_data(WALL_LAYER, coord) == null \
	and actor_at_coord(coord)
	
func get_map_coord(coord: Vector2):
	return map.local_to_map(map.to_local(coord))
	
func get_global_coord(coord: Vector2i):
	return map.to_global(map.map_to_local(coord))

func add_actor(actor: Node2D, position: Vector2i):
	actors_to_positions[actor] = position
	positions_to_actors[position] = actor
func update_actor(actor: Node2D, position: Vector2i):
	var old_position = actors_to_positions[actor]
	positions_to_actors.erase(old_position)
	add_actor(actor, position)
	
func remove_actor(actor: Node2D):
	var position = actors_to_positions[actor]
	positions_to_actors.erase(position)
	actors_to_positions.erase(actor)
	
func actor_at_coord(coord: Vector2i):
	return positions_to_actors.has(coord)
