extends Node2D
class_name AttackingComponent

signal finished_attacking

func attack():
	owner.animation_player.play("ranged_attack1")
	await owner.animation_player.animation_finished
	finished_attacking.emit()
