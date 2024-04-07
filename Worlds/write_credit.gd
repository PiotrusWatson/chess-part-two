extends HBoxContainer

class_name Credit

@onready var title_label = $Title/Title
@onready var name_label = $Name/Name

func set_name_label(text: String):
	name_label.text = text

func set_title_label(text: String):
	title_label.text = text
