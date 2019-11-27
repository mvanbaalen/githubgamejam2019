extends KinematicBody2D

enum State {PREPARE, WAIT, MOVING, MELEE, DIZZY}
enum Team  {PLAYER, ENEMY}

export(Team) var team = Team.PLAYER

#TODO: Use timers for this
var attack_cooldown = 2.0
var current_cooldown = 0
var dizzy_cooldown = 1.0
var dizzy_time = 0

var current_state = State.PREPARE
var current_target = null

export var speed = 100

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if current_state != State.PREPARE:
		current_cooldown = clamp(current_cooldown - delta, 0, attack_cooldown)
		if current_target == null || !is_instance_valid(current_target):
			find_target()

func _physics_process(delta):
	match current_state:
		State.WAIT:
			pass
		State.MOVING:
			move_towards(current_target, delta)
		State.MELEE:
			if can_attack(current_target):
				attack(current_target, delta)
		State.DIZZY:
			dizzy_time = clamp(dizzy_time - delta, 0, dizzy_cooldown)
			if dizzy_time == 0:
				dizzy_time = dizzy_cooldown
				become_undizzy()

func start_battle():
	current_state = State.WAIT
	
func find_target():
	current_target = get_parent().closest_enemy(self)
	current_state = State.MOVING
	
func can_attack(target):
	if (is_instance_valid(target)
	&& current_cooldown == 0):
		return true
	return false
	#TODO Check distance, etc.
	
func move_towards(target, delta):
	rotation = position.angle_to_point(target.position)
	var collision = move_and_collide((target.position - position).normalized() * speed * delta)
	if collision:
		if collision.collider == target:
			current_state = State.MELEE
		else:
			if collision.collider.team != team:
				current_target = collision.collider
				current_state = State.MELEE
	
func attack(target, delta):
	#Todo recheck target in range
	target.move_and_collide((target.position - position).normalized() * delta * 3000)
	current_cooldown = attack_cooldown
	current_state = State.MOVING
	target.attacked()
	
func attacked():
	become_dizzy()
	#TODO Other stuff? Health? Charge attack?
	
func become_dizzy():
	current_state = State.DIZZY
	dizzy_time = dizzy_cooldown
	#TODO: Stop animations, add dizzy animation, etc?
	
func become_undizzy():
	current_state = State.WAIT
	current_target = null
	#TODO Start animations again
	
func fall():
	print(name + " has fallen!")
	queue_free()