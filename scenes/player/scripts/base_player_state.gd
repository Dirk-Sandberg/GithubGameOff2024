extends Node
class_name BasePlayerState

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	pass

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	return ""
