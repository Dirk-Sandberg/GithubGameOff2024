extends CanMoveState

@export var jump_gravity = Vector2(0, 980*6)
@export var JUMP_VELOCITY = -140.0
@export var max_extra_jump_frames = 10
var frames_holding_jump = 0
var extra_jump_velocity_per_frame = -15

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	frames_holding_jump = 0
	owner.velocity.y = JUMP_VELOCITY
	owner.animation_player.play("jump")
	pass

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	#owner.velocity += owner.get_gravity() * delta
	#owner.move_and_slide()
	# Add the gravity.
	if Input.is_action_pressed("jump"):
		if frames_holding_jump < max_extra_jump_frames:
			owner.velocity.y += extra_jump_velocity_per_frame
			frames_holding_jump += 1
	owner.velocity += jump_gravity * delta * 0.1

	var new_state = super(owner, delta)
	if owner.is_on_floor():
		new_state = "idle"
	if owner.velocity.y > 0:
		new_state = "fall"
	
	return new_state
