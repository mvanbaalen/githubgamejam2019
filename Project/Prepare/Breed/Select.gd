extends Control

var FrogProfile = preload("res://Prepare/FrogProfile.tscn")

func _ready():
	var frog = Player.frog_to_check
	find_node("FrogName").text = frog.name
	var frog_texture = load("res://img/frog_profile" + str(frog.profile) + ".png")
	find_node("FrogPicture").texture = frog_texture
	
	for frog in Player.frogs:
		if frog != Player.frog_to_check:
			var frog_selection = FrogProfile.instance()
			frog_selection.set_frog(frog)
			$ColorRect/GridContainer.add_child(frog_selection)


func _on_Back_Button_pressed():
	get_tree().change_scene("res://Prepare/Prepare.tscn")
