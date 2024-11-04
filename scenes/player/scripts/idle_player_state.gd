extends CanMoveState

func enter(owner: CharacterBody2D):
	owner.animation_player.play("idle")
	pass

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	if not owner.is_on_floor():
		return "fall"
	if owner.velocity.x != 0.0:
		return "run"
	return super(owner, delta)
