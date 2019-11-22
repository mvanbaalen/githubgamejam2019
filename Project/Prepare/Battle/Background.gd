extends TextureRect

# Declare member variables here. Examples:
var tick = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	tick += delta
	texture.noise.period = 40 + 5*sin(PI*tick)
