extends Ability

@export var explode_ability: Ability
func _init() -> void:
	description = "Start charging and end your turn. Next turn, you explode."

func cast():
	var player = get_tree().get_first_node_in_group("player")
	player.change_state("charge")
	if TurnManager.in_combat:
		Abilities.auto_cast_upon_next_turn = explode_ability
		TurnManager.player_turn_ended.emit()
