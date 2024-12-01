extends Ability

func _init() -> void:
	description = "Strike twice in quick succession."

func cast():
	if GV.awaiting_tutorial_ability1:
		GV.used_tutorial_ability1 = true
		GV.awaiting_tutorial_ability1 = false
		GV.awaiting_tutorial_ability2 = true
	var player = get_tree().get_first_node_in_group("player")
	player.change_state("attack")
