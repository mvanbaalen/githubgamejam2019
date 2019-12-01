extends Control


func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene('res://title_screen/TitleScreen.tscn')

func _on_BackButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
