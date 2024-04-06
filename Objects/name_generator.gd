extends Object
class_name NameGenerator

var suffixes = [
	"ria",
	"sia",
	"driu",
	"gda",
	"hna",
	"tea",
	"phen",
	"dia",
	"del",
	"zel",
	"ma",
	"ssa",
	"be",
	"yos",
	"roen",
	"nia",
	"rra",
	"ges",
	"tia",
	"mis",
	"rin",
	"rina",
	"lys",
	"niel",
	"vale",
	"ri",
	"hein",
	"vis",
	"lia",
	"dral",
	"cia"
]

var prefixes = [
	"Ae",
	"Ad",
	"Agust",
	"Al",
	"Ar",
	"As",
	"Ay",
	"Be",
	"Ba",
	"De",
	"Da",
	"El",
	"Eid",
	"Ed",
	"Em",
	"Fe",
	"Fa",
	"Fi",
	"Ga",
	"Ge", 
	"Go",
	"Gra",
	"Ha",
	"Hre",
	"Il",
	"Je",
	"Ka",
	"Ki",
	"Ko",
	"La",
	"Ly",
	"Ma",
	"Mi",
	"Na",
	"Ne",
	"No",
	"Oh",
	"Phe",
	"Pe",
	"Ple",
	"Ra",
	"Re",
	"Ri",
	"Ro",
	"Sa",
	"Se",
	"Si",
	"Ta",
	"Te",
	"Va",
	"Ve",
	"Yli"
]
var picked_names = []
func generate_simple_name():
	var chosen_name = prefixes.pick_random() + suffixes.pick_random()
	while already_chosen(chosen_name):
		chosen_name = prefixes.pick_random() + suffixes.pick_random()
	picked_names.append(chosen_name)
	return chosen_name
	
func already_chosen(chosen_name: String):
	for name in picked_names:
		if chosen_name == name:
			return true
	return false
