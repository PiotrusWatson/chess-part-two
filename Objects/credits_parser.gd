extends Object

class_name CreditsParser
enum LineType{TITLE, CREDIT, EMPTY, FONT}

static func parse(line: String):
	if line.length() == 0:
		return LineType.EMPTY
	if line[0] == "*":
		return LineType.TITLE
	elif line.contains(":"):
		return LineType.CREDIT
	else:
		return LineType.FONT
		

static func get_title(title: String):
	return title.split("*")[1]
	
static func get_credit(credit: String):
	return credit.split(":")

static func parse_all(lines: Array[String]):
	var parsed_content = {}
	var section
	var title = ""
	for line in lines:
		print(line)
		var result = parse(line)
		if result == LineType.TITLE and title.length() > 0:
			parsed_content[title] = section
			title = get_title(line)
			section = []
		elif result == LineType.TITLE:
			title = get_title(line)
			section = []
		elif result == LineType.CREDIT:
			section.append(get_credit(line))
		elif result == LineType.FONT:
			section.append(line)
		else:
			section.append("\n")
	parsed_content[title] = section
	return parsed_content
			
		
	
