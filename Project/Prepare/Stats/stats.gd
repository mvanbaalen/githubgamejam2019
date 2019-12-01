extends Control

func _ready():
	var frog = Player.frog_to_check
	
	find_node("FrogName").text = frog.name
	var frog_texture = load("res://img/frog_profile" + str(frog.profile) + ".png")
	find_node("FrogPicture").texture = frog_texture
	find_node("LevelLabel").text += str(frog.level)
	find_node("Strength").value = frog.strength
	

func _on_Button_pressed():
	get_tree().change_scene('res://Prepare/Prepare.tscn')
