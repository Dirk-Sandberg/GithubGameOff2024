extends CanMoveState
@export var fall_gravity = Vector2(0, 980*8.0)

func enter(owner: CharacterBody2D):
	owner.animation_player.play("fall")
	
	pass

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	# Add the gravity.
	owner.velocity += fall_gravity * delta * 0.1

	var new_state = super(owner, delta)
	if owner.is_on_floor():
		new_state = "idle"
	return new_state
