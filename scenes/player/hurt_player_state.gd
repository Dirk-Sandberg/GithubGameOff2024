extends BasePlayerState

var done_animating = false

func enter(owner: CharacterBody2D, previous_state: Node):
	done_animating = false
	owner.animation_player.play("hurt")
	await owner.animation_player.animation_finished
	done_animating = true

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	#var velocity = owner.velocity
	if done_animating: return "idle"
	return ""
