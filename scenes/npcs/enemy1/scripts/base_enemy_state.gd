extends EnemyState
class_name BaseEnemyState

func enter(owner: Node2D, previous_state: Node):
	pass

func exit(owner: Node2D):
	pass

func physics_process(owner: Node2D, delta: float) -> String:
	return ""
