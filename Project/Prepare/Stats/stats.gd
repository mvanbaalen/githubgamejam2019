extends Control

func _ready():
	$CenterContainer/VBoxContainer/Button.grab_focus() # TODO Get rid of focus?
	var frog = Player.frog_to_check
	
	find_node("FrogName").text = frog.name
	var frog_texture = load("res://img/frog_profile" + str(frog.profile) + ".png")
	find_node("FrogPicture").texture = frog_texture
	

func _on_Button_pressed():
	get_tree().change_scene('res://Prepare/Prepare.tscn')
