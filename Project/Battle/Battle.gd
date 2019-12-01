extends Node

func _ready():
	$PlayerLog.load_from_frog_list(Player.frogs)

func _on_Button_pressed():
	get_tree().change_scene('res://title_screen/TitleScreen.tscn')
