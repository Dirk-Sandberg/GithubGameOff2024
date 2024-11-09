extends Ability

func cast():
	var player = get_tree().get_first_node_in_group("player")
	player.change_state("explode")
	Abilities.auto_cast_upon_next_turn = null
