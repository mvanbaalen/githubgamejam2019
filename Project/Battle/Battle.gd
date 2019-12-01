extends Node

enum BattleState {PREPARE, FIGHT, END}
enum Team {PLAYER, ENEMY} # Duplicated? Use Global?

var FrogActor = preload("res://Battle/frog/Frog.tscn")

var current_state = BattleState.PREPARE

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
		
func victory(team):
	if team == Team.PLAYER:
		for frog in $Arena/Frogs.get_children():
			if frog.current_state != frog.State.FALLEN:
				frog.stats.level += 1
	else:
		pass # TODO add to losses or something
	get_tree().change_scene("res://Prepare/Prepare.tscn")

func _on_Button_pressed():
	get_tree().change_scene('res://title_screen/TitleScreen.tscn')


func _on_StartButton_pressed():
	for frog in $Arena/Frogs.get_children():
		if !frog.ready_to_fight():
			return
	for frog in $Arena/Frogs.get_children():
		frog.start_battle()
		current_state = BattleState.FIGHT
		$StartButton.queue_free()
