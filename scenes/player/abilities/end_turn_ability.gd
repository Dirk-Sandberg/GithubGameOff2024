extends Ability

func _init():
	description = "End your turn."

func cast():
	TurnManager.player_turn_ended.emit()
