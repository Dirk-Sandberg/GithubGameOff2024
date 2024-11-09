extends Ability

func _init() -> void:
	description = "Strike twice in quick succession."

func cast():
	var player = get_tree().get_first_node_in_group("player")
	player.change_state("attack")
