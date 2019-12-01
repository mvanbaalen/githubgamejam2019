extends Control

var bgm = load('res://audio/pyoko_croak.ogg')

func _ready():
	find_node("FrogProfile").set_frog(Player.frog_to_check)
	AudioPlayer.change_song(bgm)

func _on_Croak_Button_pressed():
	# TODO: Animate?
	AudioPlayer.playSFX(load('res://audio/pyoko_SFX4.wav'))
	Player.frogs.erase(Player.frog_to_check)
	$FadeIn.show()
	$FadeIn.fade_in()
	AudioPlayer.music_fade_out()
	# TODO: You can't croak your only frog!

func _on_Back_Button_pressed():	
	$FadeIn.show()
	$FadeIn.fade_in()
	AudioPlayer.music_fade_out()
	
func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene("res://Prepare/Prepare.tscn")
