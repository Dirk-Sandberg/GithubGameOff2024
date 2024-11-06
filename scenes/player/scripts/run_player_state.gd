extends CanMoveState

func enter(owner: CharacterBody2D, previous_state: Node):
	owner.animation_player.play("run")

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	if not owner.is_on_floor():
		return "fall"

	var new_state = super(owner, delta)
	if not owner.velocity.x: return "idle"
	return new_state
