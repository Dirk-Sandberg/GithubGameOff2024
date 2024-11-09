extends BasePlayerState

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	owner.animation_player.play("charge_start")
	await owner.animation_player.animation_finished
	owner.animation_player.play("charge_loop")

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	return ""
