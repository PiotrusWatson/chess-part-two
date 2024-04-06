extends Node
class_name GridMover

var thing_to_move: Node2D
var grid_position: Vector2i

func setup(parent: Node2D):
	thing_to_move = parent
	reset_grid_position()
	Map.add_actor(thing_to_move, grid_position)

func reset_grid_position():
	grid_position = Map.get_map_coord(thing_to_move.global_position)
	thing_to_move.global_position = Map.get_global_coord(grid_position)
	
func move_to(location: Vector2i):
	thing_to_move.global_position = Map.get_global_coord(location)
	grid_position = location
	
func try_move(direction: Vector2i):
	return try_move_to(grid_position + direction)

func move(direction: Vector2i):
	return move_to(grid_position + direction)
	
func try_move_to(location: Vector2i):
	if Map.can_move(location):
		move_to(location)
		Map.update_actor(thing_to_move, grid_position)
		return true
	return false
