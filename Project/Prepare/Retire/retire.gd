extends Control
var tick = 0

var bgm = load('res://audio/pyoko_retire.ogg')

func _ready():
	$ReturnButton.grab_focus()
	AudioPlayer.change_song(bgm)

func _on_Button_pressed():
	AudioPlayer.playSFX(load('res://audio/pyoko_SFX3.wav'))
	$FadeIn.show()
	$FadeIn.fade_in()
	AudioPlayer.music_fade_out()

func _process(delta):
	tick += delta
	$PondTexture.texture.noise.period = 6.2+0.05*sin(tick)

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene('res://title_screen/TitleScreen.tscn')