extends Label

var tick = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	tick += delta
	self['custom_fonts/font'].size = 80+int(5*sin(PI*tick))
	self['custom_constants/shadow_offset_x'] = int(20*cos(tick))
	self['custom_constants/shadow_offset_y'] = int(10*sin(tick))
