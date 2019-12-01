extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_frog(frog):
	find_node("FrogName").text = frog.name
	var frog_texture = load("res://img/frog_profile" + str(frog.profile) + ".png")
	find_node("FrogPicture").texture = frog_texture