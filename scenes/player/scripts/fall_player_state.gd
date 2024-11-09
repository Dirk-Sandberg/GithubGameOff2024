extends CanMoveState
@export var fall_gravity = Vector2(0, 980*8.0)
@export var coyote_time = 1.0
var time_passed = 0.0
var prev_state: Node

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	owner.animation_player.play("fall")
	time_passed = 0.0
	prev_state = previous_state

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	time_passed += delta
	if Input.is_action_just_pressed("jump") and time_passed <= coyote_time and prev_state != owner.states["jump"]:
		return "jump"

	owner.velocity += fall_gravity * delta * 0.1

	var new_state = super(owner, delta)
	if owner.is_on_floor():
		new_state = "idle"
	return new_state
