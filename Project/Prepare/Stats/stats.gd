extends Control

func _ready():
	$CenterContainer/VBoxContainer/Button.grab_focus()
	find_node("FrogName").text = Player.frog_to_check.name

func _on_Button_pressed():
	get_tree().change_scene('res://Prepare/Prepare.tscn')
