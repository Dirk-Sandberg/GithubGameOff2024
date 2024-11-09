extends BaseEnemyState

func enter(owner: Node2D, previous_state: Node):
	owner.animation_player.play("wake")
	ScreenShake.shake()
	await owner.animation_player.animation_finished
	TurnManager.begin_combat([owner])
	owner.change_state("idle")

func exit(owner: Node2D):
	pass

func physics_process(owner: Node2D, delta: float) -> String:
	return ""
