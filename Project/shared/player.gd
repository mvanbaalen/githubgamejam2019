extends Node
var abstract_frog = load("res://shared/abstract_frog.gd")


var frogs = []
var level = 1


# State handling variables
var frog_to_check # Which frog we're going to load scenes for


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(6):
		var new_frog = abstract_frog.new()
		frogs.append(new_frog)
