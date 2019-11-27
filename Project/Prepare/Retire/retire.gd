extends Control
var tick = 0
func _ready():
	$ReturnButton.grab_focus()

func _on_Button_pressed():
	get_tree().change_scene('res://title_screen/TitleScreen.tscn')

func _process(delta):
	tick += delta
	$PondTexture.texture.noise.period = 6.2+0.05*sin(tick)