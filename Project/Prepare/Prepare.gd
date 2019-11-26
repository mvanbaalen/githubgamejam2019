extends Control

var scene_path_to_load
const InspectFrog = preload("res://Prepare/InspectFrog.tscn")
const MyFrogs = preload("res://MyFrogs/MyFrogs.tscn")
const FrogButton = preload("res://title_screen/buttons/FrogButton.tscn")

func _ready():
	for frog in Player.frogs:
		var inst = FrogButton.instance()
		inst.connect("button_down", self, "_on_FrogButton_pressed", [inst])
		$FrogGrid.add_child(inst)
	$FrogGrid.get_child(0).grab_focus()
	$BattleButton.connect("pressed", self, "_on_Button_pressed",[$BattleButton.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load

func _on_FrogButton_pressed(frog):
	if($InspectFrog != null):
		$InspectFrog.free()
	var inst = InspectFrog.instance()
	inst.name = "InspectFrog"
	for button in inst.get_node("Choices").get_children():
		button.connect("pressed", self, "_on_Button_pressed",[button.scene_to_load])
	inst.rect_position = frog.get_global_transform().origin - Vector2(20.0,10.0)
	self.add_child(inst)
	$InspectFrog/Choices.get_child(0).grab_focus()

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(scene_path_to_load)
