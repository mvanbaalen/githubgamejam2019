extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var frog = Player.frog_to_check
	find_node("FrogProfile").set_frog(Player.frog_to_check)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Croak_Button_pressed():
	# TODO: Animate?
	Player.frogs.erase(Player.frog_to_check)
	get_tree().change_scene("res://Prepare/Prepare.tscn")
	# TODO: You can't croak your only frog!


func _on_Back_Button_pressed():
	get_tree().change_scene("res://Prepare/Prepare.tscn")
