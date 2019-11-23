extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func closest_enemy(asking_frog):
	var closest_enemy = null
	var closest_distance = null
	for frog in get_children():
		if asking_frog.team != frog.team:
			var distance = asking_frog.position.distance_to(frog.position)
			if closest_distance == null or distance < closest_distance:
				distance = closest_distance
				closest_enemy = frog
	return closest_enemy