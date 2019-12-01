extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func closest_enemy(asking_frog):
	var closest_enemy = null
	var closest_distance = null
	for frog in get_children():
		if asking_frog.team != frog.team && frog.current_state != frog.State.FALLEN:
			var distance = asking_frog.position.distance_to(frog.position)
			if closest_distance == null or distance < closest_distance:
				closest_distance = distance
				closest_enemy = frog
	return closest_enemy
	
func check_victory():
	# TODO Always track these?
	var player_team = []
	var enemy_team = []
	for frog in get_children():
		if frog.current_state != frog.State.FALLEN:
			if frog.team == frog.Team.PLAYER:
				player_team.append(frog)
			else:
				enemy_team.append(frog)
	if player_team.size() > 0 and enemy_team.size() > 0:
		return false
	else:
		return true
		# This is really dumb but I am so tired