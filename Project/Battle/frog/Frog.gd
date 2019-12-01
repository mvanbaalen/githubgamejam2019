extends KinematicBody2D

const distance_multiplier = 1000

enum State {PREPARE, WAIT, MOVING, MELEE, DIZZY, FALLEN}
enum Team  {PLAYER, ENEMY}

export(Team) var team = Team.PLAYER

var stats # Comes from the Abstract Frog

onready var FrogList = get_parent()
onready var ArenaArea = FrogList.get_parent()
onready var BattleScene = ArenaArea.get_parent()

#Prepare only
var dragging = false
var last_known_position = position
var legal_position

#TODO: Use timers for this
var attack_cooldown = 2.0
var current_cooldown = 0
var dizzy_cooldown = 1.0
var dizzy_time = 0

var current_state = State.PREPARE
var current_target = null

var movement_speed

func _ready():
	movement_speed = stats.speed * 25
	if team == Team.PLAYER:
		modulate = Color(1,0,0)
		legal_position = false
	
func _process(delta):
	if current_state == State.PREPARE:
		if dragging:
			calculate_dragging()
	else:
		current_cooldown = clamp(current_cooldown - delta, 0, attack_cooldown)
		if !valid_target():
			find_target()

func _physics_process(delta):
	match current_state:
		State.WAIT:
			pass
		State.MOVING:
			move_towards_target(delta)
		State.MELEE:
			if can_attack(current_target):
				attack_target(delta)
		State.DIZZY:
			dizzy_time = clamp(dizzy_time - delta, 0, dizzy_cooldown)
			if dizzy_time == 0:
				dizzy_time = dizzy_cooldown
				become_undizzy()
				
func valid_target():
	if current_target == null:
		return false
	if current_target.current_state == State.FALLEN:
		return false
	if !is_instance_valid(current_target):
		return false
	return true

func calculate_dragging():
	position = get_viewport().get_mouse_position()
	if check_legal_position():
		modulate = Color(1,1,1)
	else:
		modulate = Color(1,0,0)
	
func start_battle():
	current_state = State.WAIT
	
func find_target():
	current_target = FrogList.closest_enemy(self)
	current_state = State.MOVING
	
func can_attack(target):
	if (valid_target() and current_cooldown == 0):
		return true
	return false
	#TODO Check distance, etc.
	
func move_towards_target(delta):
	if valid_target():
		rotation = position.angle_to_point(current_target.position)
		var collision = move_and_collide((current_target.position - position).normalized() * movement_speed * delta)
		if collision:
			if collision.collider == current_target:
				current_state = State.MELEE
			else:
				if collision.collider.team != team:
					current_target = collision.collider
					current_state = State.MELEE
	
func attack_target(delta):
	if valid_target():
		#Todo recheck target in range
		current_target.move_and_collide((current_target.position - position).normalized() * delta * distance_multiplier * stats.strength)
		current_cooldown = attack_cooldown
		current_state = State.MOVING
		current_target.attacked()
	
func attacked():
	become_dizzy()
	#TODO Other stuff? Health? Charge attack?
	
func become_dizzy():
	current_state = State.DIZZY
	dizzy_time = dizzy_cooldown
	$FrontLegsSprite.animation = "Idle"
	
func become_undizzy():
	current_state = State.WAIT
	current_target = null
	$FrontLegsSprite.animation = "Walk"
	
func fall():
	# TODO Animations and etc.
	current_state = State.FALLEN
	visible = false
	if FrogList.check_victory():
		# The opposite team of the one that fell won
		if team == Team.PLAYER:
			BattleScene.victory(Team.ENEMY)
		else:
			BattleScene.victory(Team.PLAYER)

#warning-ignore:unused_argument
func _on_Frog_input_event(viewport, event, shape_idx):
	if current_state == State.PREPARE:
		if team == Team.PLAYER:
			if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
				start_drag()
			if event is InputEventMouseButton and !event.pressed and event.button_index == BUTTON_LEFT:
				undrag()

func start_drag():
	dragging = true
	last_known_position = position

		
func undrag():
	if dragging:
		dragging = false
		if check_legal_position():
			legal_position = true
		else:
			legal_position = false
			position = last_known_position
		
				
func check_legal_position():
	var no_collide = get_parent().get_parent().get_parent().get_node("StartButton/NoPlace")
	if $Overlap.overlaps_area(no_collide) or $Overlap.get_overlapping_bodies().size() > 1:
		return false
	else:
		return ($Overlap.get_overlapping_bodies().size() == 1
		and $Overlap.overlaps_area(ArenaArea.get_node("Area2D")))
			# Overlaps with only self and the lilypad, this is gross
		
func ready_to_fight():
	return (team == Team.PLAYER and legal_position) or (team == Team.ENEMY)
		