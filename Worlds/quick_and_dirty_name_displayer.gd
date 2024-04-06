extends Label

func _ready():
	var name_generator = NameGenerator.new()
	text = "Shadows of " + name_generator.generate_simple_name()
