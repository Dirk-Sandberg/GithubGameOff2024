extends BasePlayerState

func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	#Engine.time_scale = 0.5
	get_tree().get_first_node_in_group("camera").lerp_zoom(1.1)
	owner.shockwave.show()
	owner.animation_player.play("charge_blast")
	await owner.animation_player.animation_finished
	#owner.animation_player.play("charge_end")
	#await owner.animation_player.animation_finished
	owner.change_state("idle")
	owner.shockwave.hide()
	TurnManager.player_turn_ended.emit()
	#Engine.time_scale = 1.0
	get_tree().get_first_node_in_group("camera").lerp_zoom(1.0)
	

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	return ""
