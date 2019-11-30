extends Control

var scene_path_to_load
const InspectFrog = preload("res://Prepare/InspectFrog.tscn")
const MyFrogs = preload("res://MyFrogs/MyFrogs.tscn")
const FrogButton = preload("res://title_screen/buttons/FrogButton.tscn")
#const Player = preload("res://MyFrogs/Player.tscn")

func _ready():
	for frog in Player.frogs:
		var frog_button = FrogButton.instance()
		frog_button.connect("pressed", self, "_on_FrogButton_pressed", [frog_button])
		frog_button.abstract_frog_instance = frog
		$FrogGrid.add_child(frog_button)
	$FrogGrid.get_child(0).grab_focus()
	$BattleButton.connect("pressed", self, "_on_Button_pressed",[$BattleButton.scene_to_load])
	$RetireButton.connect("pressed", self, "_on_Button_pressed",[$RetireButton.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load

func _on_FrogButton_pressed(frog):
	if has_node("InspectFrog"):
		$InspectFrog.free()
	var inspect_menu = InspectFrog.instance()
	inspect_menu.name = "InspectFrog"
	for button in inspect_menu.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	inspect_menu.rect_position = frog.get_global_transform().origin - Vector2(20.0,10.0)
	add_child(inspect_menu)
	$InspectFrog.get_child(0).grab_focus()
	Player.frog_to_check = frog.abstract_frog_instance

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(scene_path_to_load)
