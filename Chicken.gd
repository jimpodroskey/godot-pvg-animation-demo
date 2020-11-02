extends KinematicBody2D

export (int) var speed = 200

var target = Vector2()
var velocity = Vector2(1,0)

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')

func _ready():
	animationTree.active = true
	set_blend_positions()

	

func _physics_process(_delta):
	if Input.is_action_pressed('mouse_walk'):
		target = get_global_mouse_position()
	else:
		target = position


	velocity = position.direction_to(target) * speed

	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
		animationState.travel("Walk")
		set_blend_positions()
	else:
		animationState.travel("Idle")

	if Input.is_action_just_pressed("attack"):
		animationState.travel("Attack")

func set_blend_positions():
	animationTree.set('parameters/Idle/blend_position', velocity.normalized())
	animationTree.set('parameters/Walk/blend_position', velocity.normalized())
	animationTree.set('parameters/Attack/blend_position', velocity.normalized())
