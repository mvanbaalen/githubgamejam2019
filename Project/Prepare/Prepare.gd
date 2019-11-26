extends Control

var scene_path_to_load
const InspectFrog = preload("res://Prepare/InspectFrog.tscn")
const MyFrogs = preload("res://MyFrogs/MyFrogs.tscn")
const FrogButton = preload("res://title_screen/buttons/FrogButton.tscn")
var debug
func _ready():
	var frog_count = MyFrogs.instance().get_child_count()
	for i in range(int(min(3.0,float(frog_count)))):
		var inst = FrogButton.instance()
		inst.name = "FrogButton"+str(i)
		$Menu/FrogSpotRow1.add_child(inst)
	debug = int(max(0.0,float(frog_count-3)))
	for i in range(int(max(0.0,float(frog_count-3)))):
		var inst = FrogButton.instance()
		inst.name = "FrogButton"+str(i+3)
		$Menu/FrogSpotRow2.add_child(inst)		
	$Menu/FrogSpotRow1/FrogButton1.grab_focus()
	for button in $Menu/FrogSpotRow1.get_children():
		button.connect("button_down", self, "_on_FrogButton_pressed",[button])
	for button in $Menu/FrogSpotRow2.get_children():
		button.connect("button_down", self, "_on_FrogButton_pressed",[button])
	$BattleButton.connect("pressed", self, "_on_Button_pressed",[$BattleButton.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load

func _on_FrogButton_pressed(frog):
	print(debug)
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
