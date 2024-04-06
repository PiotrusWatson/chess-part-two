extends Node2D

@onready var grid_mover = $GridMover
var horizontal 
var vertical
func _ready():
	grid_mover.setup(self)
	

