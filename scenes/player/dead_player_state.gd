extends BasePlayerState

var done_animating = false

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	done_animating = false
	owner.animation_player.play("die")
	await owner.animation_player.animation_finished
	done_animating = true

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	return ""
