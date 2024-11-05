extends BasePlayerState

var finished = false
func enter(owner: CharacterBody2D):
	finished = false
	owner.animation_player.play("melee")
	owner.animation_player.speed_scale = 0.6
	await owner.animation_player.animation_finished
	finished = true
	pass

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	if finished: return "idle"
	return ""
