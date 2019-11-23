extends KinematicBody2D

enum State {PREPARE, WAIT, MOVING}
enum Team  {PLAYER, ENEMY}

export(Team) var team = Team.PLAYER

var current_state = State.PREPARE
var current_target = null

export var speed = 100

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	match current_state:
		State.WAIT:
			if current_target == null:
				find_target()
			else:
				if can_attack(current_target):
					attack(current_target)
		State.MOVING:
			move_towards(current_target, delta)

func start_battle():
	current_state = State.WAIT
	
func find_target():
	current_target = get_parent().closest_enemy(self)
	current_state = State.MOVING
	
func can_attack(target):
	pass
	
func move_towards(target, delta):
	rotation = position.angle_to_point(target.position)
	move_and_collide((target.position - position).normalized() * speed * delta)
	
func attack(target):
	pass