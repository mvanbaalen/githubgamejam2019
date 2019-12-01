extends CenterContainer

var hud_scene = preload("res://Battle/FrogHUD.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#TODO Logs generate from Player.frogs

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_from_frog_list(frogs):
	for frog in frogs:
		var frog_hud = hud_scene.instance()
		frog_hud.get_node("TextureRect").texture = load("res://img/frog_profile" + str(frog.profile) + ".png")
		frog_hud.get_node("Label").text = frog.name
		$FrogList.add_child(frog_hud)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
