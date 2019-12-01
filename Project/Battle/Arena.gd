extends CenterContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StartButton_pressed():
	for frog in $Frogs.get_children():
		if !frog.ready_to_fight():
			return
	for frog in $Frogs.get_children():
		frog.start_battle()
