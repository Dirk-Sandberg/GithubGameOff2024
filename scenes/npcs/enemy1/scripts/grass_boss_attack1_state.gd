extends BaseEnemyState

signal finished_attacking

func enter(owner: Node2D, previous_state: Node):
	owner.animation_player.play("ranged_attack1")
	await owner.animation_player.animation_finished
	#ScreenShake.shake()
	owner.change_state("idle")
	finished_attacking.emit()

func exit(owner: Node2D):
	pass

func physics_process(owner: Node2D, delta: float) -> String:
	return ""
