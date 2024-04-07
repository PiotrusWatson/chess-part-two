extends VBoxContainer

@export var credit_prefab : PackedScene
var credit_path = "res://Resources/Credits/credits.txt"
var parsed_credits
func _ready():
	var unparsed_credits = FileHelper.file_to_string_array(credit_path)
	parsed_credits = CreditsParser.parse_all(unparsed_credits)
	for title in parsed_credits:
		draw_title(title)
		for credit in parsed_credits[title]:
			if credit is PackedStringArray:
				draw_credit(credit)
			else:
				draw_title(credit)
	
func draw_title(title: String):
	var label_title = Label.new()
	label_title.text = title
	label_title.name = title
	add_child(label_title)
	
func draw_credit(credit):
	var credit_labels: Credit = SpawningHelper.spawn(credit_prefab, self)
	credit_labels.set_name_label(credit[0])
	credit_labels.set_title_label(credit[1])
	
