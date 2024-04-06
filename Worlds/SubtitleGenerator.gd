extends Label

@export var max_size = 6
@export var min_size = 2
@export var adjective_limit = 3

var noun_path = "res://Resources/SubtitleStuff/nouns.txt"
var adjective_path = "res://Resources/SubtitleStuff/adjectives.txt"
var conjunction_path = "res://Resources/SubtitleStuff/conjunctions.txt"

var title_generator
func _ready():
	title_generator = TitleGenerator.new(min_size, max_size, adjective_limit)
	title_generator.setup_from_file(noun_path, adjective_path, conjunction_path)
	text = title_generator.generate_sentence()
	
