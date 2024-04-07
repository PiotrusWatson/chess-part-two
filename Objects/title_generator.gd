extends Object
class_name TitleGenerator

enum PartOfSpeech{NOUN, ADJECTIVE, CONJUNCTION}
var nouns : PackedStringArray
var adjectives : PackedStringArray
var conjunctions : PackedStringArray
var adjective_limit : int
var minimum_words: int
var maximum_words: int
var is_ready = false

func pick_random(array: PackedStringArray):
	var index = randi_range(0, array.size() - 1)
	return array[index]
func _init(min_size = 2, max_size = 6, max_adjectives = 3):
	adjective_limit = max_adjectives
	minimum_words = min_size
	maximum_words = max_size
	
func setup(_nouns: Array[String], _adjectives: Array[String], _conjunctions: Array[String]):
	nouns = _nouns
	adjectives = _adjectives
	conjunctions = _conjunctions
	
func file_to_string_array(path: String):
	var f = FileAccess.open(path, FileAccess.READ)
	var content = f.get_as_text()
	var content_array = content.split("\n")
	return content_array.slice(0, content_array.size() - 1)
	
func setup_from_file(noun_path: String, adjective_path: String, conjunction_path: String):
	nouns = file_to_string_array(noun_path)
	adjectives = file_to_string_array(adjective_path)
	conjunctions = file_to_string_array(conjunction_path)
	
func generate_sentence():
	return generate_bespoke_sentence(maximum_words, minimum_words)
	
func generate_bespoke_sentence(max_size: int, min_size: int):
	var size = randi_range(min_size, max_size)
	return form_sentence(size)
	
func form_sentence(size: int):
	if size == 2:
		return maybe_the() + get_new_word(PartOfSpeech.ADJECTIVE) + " " + get_new_word(PartOfSpeech.NOUN)
	var current_part_of_speech = [PartOfSpeech.ADJECTIVE, PartOfSpeech.NOUN].pick_random()
	var consecutive_adjectives = 0
	var sentence = ""
	sentence += get_new_word(current_part_of_speech) + " "
	if current_part_of_speech == PartOfSpeech.ADJECTIVE:
		consecutive_adjectives += 1
	
	for i in range(size - 1):
		if consecutive_adjectives >= adjective_limit:
			current_part_of_speech = PartOfSpeech.NOUN
		else:
			current_part_of_speech = get_next_part_of_speech(current_part_of_speech)
		
		sentence += get_new_word(current_part_of_speech) + " "
		if current_part_of_speech == PartOfSpeech.ADJECTIVE:
			consecutive_adjectives += 1
		else:
			consecutive_adjectives = 0
		
	if current_part_of_speech != PartOfSpeech.NOUN:
		sentence += get_new_word(PartOfSpeech.NOUN)
		
	return maybe_the() + sentence

func get_next_part_of_speech(part_of_speech: PartOfSpeech):
	if part_of_speech == PartOfSpeech.ADJECTIVE:
		return [PartOfSpeech.ADJECTIVE, PartOfSpeech.NOUN].pick_random()
	if part_of_speech == PartOfSpeech.NOUN:
		return PartOfSpeech.CONJUNCTION
	if part_of_speech == PartOfSpeech.CONJUNCTION:
		return [PartOfSpeech.ADJECTIVE, PartOfSpeech.NOUN].pick_random()
		
func get_new_word(part_of_speech: PartOfSpeech):
	if part_of_speech == PartOfSpeech.ADJECTIVE:
		return pick_random(adjectives)
	elif part_of_speech == PartOfSpeech.NOUN:
		return pick_random(nouns)
	else:
		return pick_random(conjunctions)

func maybe_the():
	if randf() > 0.5:
		return "The "
	else:
		return ""

