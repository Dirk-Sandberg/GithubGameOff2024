extends CanMoveState
var timer = 0.0
var footsteps_delta = 0.5

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	owner.animation_player.play("run")
	AudioManager.play_footstep()
	timer = 0.0

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	if not owner.is_on_floor():
		return "fall"
	if owner.velocity != Vector2.ZERO and owner.is_on_floor():
		timer += delta
		if timer >= footsteps_delta:
			timer = 0.0
			AudioManager.play_footstep()
	var new_state = super(owner, delta)
	if not owner.velocity.x: return "idle"
	return new_state
