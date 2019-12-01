extends Node

var abstract_frog = load("res://shared/abstract_frog.gd")

enum BattleState {PREPARE, FIGHT, END}
enum Team {PLAYER, ENEMY} # Duplicated? Use Global?

#TODO: Use Arena Bounds and trig
const LEVELS = {
	1: {Vector2(635, 365): 1},
	2: {Vector2(400, 365): 1, Vector2(600, 365): 1},
	3: {Vector2(635, 90): 1, Vector2(900, 365): 1, Vector2(635, 630): 1}
}

var bgm = load("res://audio/pyoko_battle.ogg")
var FrogActor = preload("res://Battle/frog/Frog.tscn")

var current_state = BattleState.PREPARE
var enemy_frogs = []

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$PlayerLog.load_from_frog_list(Player.frogs)
	for frog in Player.frogs:
		var frog_actor = FrogActor.instance()
		frog_actor.team = frog_actor.Team.PLAYER
		frog_actor.rotation = PI
		frog_actor.stats = frog
		frog_actor.position.x = 200
		$Arena/Frogs.add_child(frog_actor)
		frog_actor.position.y = 100 * $Arena/Frogs.get_children().size()
	
	if LEVELS.has(Player.level):
		for new_position in LEVELS[Player.level].keys():
			make_enemy_frog(new_position)
	else:
		for new_frog_id in range(6):
			var new_position = Vector2()
			new_position.x = rng.randi_range(335,935)
			new_position.y = rng.randi_range(65, 665)
			var new_frog = make_enemy_frog(new_position)
			#TODO This loops forever. Of course.
#			while !new_frog.check_legal_position():
#				$Arena/Frogs.remove_child(new_frog)
#				new_position.x = rng.randi_range(335,935)
#				new_position.y = rng.randi_range(65, 665)
#				new_frog = make_enemy_frog(new_position)
#				print ("Make a new frog at " + str(new_position))
				
	$EnemyLog.load_from_frog_list(enemy_frogs)
	AudioPlayer.change_song(bgm)

		
func make_enemy_frog(new_position):
	var new_frog = abstract_frog.new()
	var enemy_actor = FrogActor.instance()
	enemy_actor.team = enemy_actor.Team.ENEMY
	enemy_actor.stats = new_frog
	$Arena/Frogs.add_child(enemy_actor)
	enemy_frogs.append(new_frog)
	enemy_actor.position = new_position
	return enemy_actor


func victory(team):
	if team == Team.PLAYER:
		for frog in $Arena/Frogs.get_children():
			if frog.current_state != frog.State.FALLEN:
				frog.stats.level += 1
		Player.level += 1
	else:
		pass # TODO add to losses or something
	$FadeIn.show()
	$FadeIn.fade_in()
	AudioPlayer.music_fade_out()

func _on_StartButton_pressed():
	for frog in $Arena/Frogs.get_children():
		if !frog.ready_to_fight():
			return
	for frog in $Arena/Frogs.get_children():
		frog.start_battle()
		current_state = BattleState.FIGHT
		$StartButton.queue_free()

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene("res://Prepare/Prepare.tscn")
