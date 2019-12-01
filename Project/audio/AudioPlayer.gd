extends Node2D

onready var music_tween_out
export var transition_duration = 0.5
export var transition_type = 1 # TRANS_SINE

func music_fade_out():
	music_tween_out = get_node("MusicPlayer/TweenOut")
	music_tween_out.interpolate_property(get_node("MusicPlayer"), "volume_db", -8, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	music_tween_out.start()

func music_fade_in():
	music_tween_out = get_node("MusicPlayer/TweenIn")
	music_tween_out.interpolate_property(get_node("MusicPlayer"), "volume_db", -80, -8, transition_duration, transition_type, Tween.EASE_IN, 0)
	music_tween_out.start()
	
func _on_TweenOut_tween_completed(object, key):
	pass
	#object.stop()

func change_song(song):
	$MusicPlayer.stream = song
	$MusicPlayer.play()
	music_fade_in()

func playSFX(sfx):
	$SFXPlayer.stream = sfx
	$SFXPlayer.play()



