extends Node2D

@onready var grid_mover = $GridMover
@onready var sprite = $Sprite
var horizontal: float
var vertical: float
func _ready():
	grid_mover.setup(self)
	sprite.play()
	
func _unhandled_input(event):
	horizontal = Input.get_axis("Left", "Right")
	vertical = Input.get_axis("Up", "Down")
	grid_mover.move(Vector2i(horizontal, vertical))
