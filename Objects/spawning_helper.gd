extends Object

class_name SpawningHelper


static func spawn(scene: PackedScene, parent: Node2D, position = Vector2.ZERO):
	var instance = scene.instantiate()
	return move(instance, parent, position)

static func move(instance: Node2D, parent: Node2D, position = Vector2.ZERO):
	parent.add_child(instance)
	instance.global_position = position
	return instance
