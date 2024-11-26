extends BasePlayerState

var done_animating = false
var prev_state_str: String

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	done_animating = false
	#if previous_state_str != "idle": # Allow multiple heals/dmgs in quick succession
	prev_state_str = previous_state_str
	owner.animation_player.play("hurt")
	await owner.animation_player.animation_finished
	done_animating = true

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	#var velocity = owner.velocity
	if done_animating: return prev_state_str
	return ""
