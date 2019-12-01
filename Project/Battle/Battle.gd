extends Node

var FrogActor = preload("res://Battle/frog/Frog.tscn")

func _ready():
	$PlayerLog.load_from_frog_list(Player.frogs)
	for frog in Player.frogs:
		var frog_actor = FrogActor.instance()
		frog_actor.team = frog_actor.Team.PLAYER
		frog_actor.rotation = PI
		frog_actor.stats = frog
		frog_actor.position.x = 100
		$Arena/Frogs.add_child(frog_actor)
		frog_actor.position.y = 100 * $Arena/Frogs.get_children().size()

func _on_Button_pressed():
	get_tree().change_scene('res://title_screen/TitleScreen.tscn')
