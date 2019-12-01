extends Control

const FIRST = 0
const SECOND = 1

var frogs_to_breed
var breeding_is_complete = false
var tick = 0

func _ready():
	#Identify which frogs were selected for breeding and load profiles
	frogs_to_breed = []
	for frog in Player.frogs:
		#if frog.is_breeding:
		frogs_to_breed.append(frog)
			
	#Animate/Tween profile nodes
	$FirstFrogTween.interpolate_property($Node2D, "position",
	        Vector2(0, 0), Vector2(100, 0), 1,
	        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$FirstFrogTween.start()
	$SecondFrogTween.interpolate_property($Node2D, "position",
	        Vector2(0, 0), Vector2(-100, 0), 1,
	        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$SecondFrogTween.start()
	
	#Remove later
	$Button.grab_focus()

func _on_Button_pressed():
	if breeding_is_complete:
		get_tree().change_scene('res://Prepare/Prepare.tscn')
	
func _process(delta):
	#animate visuals
	tick += delta
	$Background.texture.noise.period = 64 + 10*sin(PI*tick)
	$Background2.texture.noise.period = 64 - 10*sin(PI*tick)
	
func _on_tween_all_completed():
	# when tweens finish call finished_breeding() and add newly generated frog
	generate_new_frog(frogs_to_breed)
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	$FrogProfile1.visible = false
	$FrogProfile2.visible = false
	$FrogProfileNew.visible = true
	$FadeIn.hide()

func generate_new_frog(frogs_to_breed):
	pass

func finished_breeding():
	pass