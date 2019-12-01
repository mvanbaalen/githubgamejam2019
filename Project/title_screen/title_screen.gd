extends Control

var scene_path_to_load
var bgm = load('res://audio/pyoko_titlescreen.ogg')

func _ready():
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	AudioPlayer.change_song(bgm)

func _on_Button_pressed(scene_to_load):
	AudioPlayer.playSFX(load('res://audio/pyoko_SFX3.wav'))
	$FadeIn.show()
	$FadeIn.fade_in()
	AudioPlayer.music_fade_out()
	scene_path_to_load = scene_to_load

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(scene_path_to_load)
