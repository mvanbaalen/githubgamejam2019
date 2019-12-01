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

var level = 1
var power = 0
var speed = 0
var size = 10

func _init():
	name = get_random_name()
	