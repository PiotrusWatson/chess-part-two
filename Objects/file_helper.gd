extends Object

class_name FileHelper

static func file_to_string_array(path: String):
	var f = FileAccess.open(path, FileAccess.READ)
	var content = f.get_as_text()
	var content_array = content.split("\n")
	return content_array.slice(0, content_array.size() - 1)
