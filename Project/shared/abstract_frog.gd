extends Reference
class_name AbstractFrog

const RANDOM_NAMES: Array = ['Bella','Charlie','Luna','Lucy','Max','Bailey',
'Cooper','Daisy','Sadie','Molly','Buddy','Lola','Stella','Tucker','Bentley',
'Zoey','Harley','Maggie','Riley','Bear','Sophie','Duke','Jax','Oliver','Chloe',
'Jack','Penny','Rocky','Lily','Milo','Piper','Toby','Zeus','Ellie','Nala','Roxy',
'Winston','Gracie','Coco','Murphy','Dexter','Teddy','Ruby','Diesel','Rosie',
'Marley','Loki','Scout','Mia','Leo','Gus','Abby','Jake','Finn','Moose','Ollie',
'Koda','Louie','Hank','Lilly','Thor','Pepper','Gunner','Willow','Jackson','Zoe',
'Bandit','Buster','Blue','Shadow','Kona','Baxter','Dixie','Henry','Lexi','Izzy',
'Apollo','Ginger','Beau','Layla','Millie','Gizmo','Oscar','Tank','Bruno','Jasper',
'Lucky','Dakota','Ace','Olive','Brody','Maverick','Lulu','Emma','Oakley','Sasha',
'Belle','Nova','Athena','Sammy']

static func get_random_name() -> String:
	return RANDOM_NAMES[randi() % len(RANDOM_NAMES)] as String

var name = ""
var profile = 0

var level = 1

var strength = 0 setget ,get_strength
var str_per_level = 0

var speed = 0 setget ,get_speed
var spd_per_level = 0

var size = 10

func _init():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	name = get_random_name()
	profile = rng.randi_range(0, 9)
	
	strength = rng.randi_range(4,6)
	str_per_level = rng.randf_range(.25, .5)
	
	speed = rng.randi_range(4,6)
	spd_per_level = rng.randf_range(.25, .5)
	
func get_strength():
	return clamp(floor(strength + str_per_level * level), 0, 10)
	
func get_speed():
	return clamp(floor(speed + spd_per_level * level), 0, 10)
	

	