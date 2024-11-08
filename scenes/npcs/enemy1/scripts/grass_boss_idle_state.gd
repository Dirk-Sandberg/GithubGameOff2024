extends BaseEnemyState

func enter(owner: Node2D, previous_state: Node):
	owner.animation_player.play("idle")
	pass

func exit(owner: Node2D):
	pass

func physics_process(owner: Node2D, delta: float) -> String:
	return ""
