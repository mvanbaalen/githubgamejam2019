extends Control

var scene_path_to_load
const InspectFrog = preload("res://Prepare/InspectFrog.tscn")

func _ready():
	$Menu/FrogSpotRow1/FrogButton1.grab_focus()
	for button in $Menu/FrogSpotRow1.get_children():
		button.connect("pressed", self, "_on_FrogButton_pressed",[button,button.scene_to_load])
	for button in $Menu/FrogSpotRow2.get_children():
		button.connect("pressed", self, "_on_FrogButton_pressed",[button,button.scene_to_load])
	$BattleButton.connect("pressed", self, "_on_Button_pressed",[$BattleButton.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load

func _on_FrogButton_pressed(frog,scene_to_load):
	var inst = InspectFrog.instance()
	inst.name = "InspectFrog"
	inst.rect_position = frog.get_global_transform().origin - Vector2(20.0,10.0)
	self.add_child(inst)

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(scene_path_to_load)
