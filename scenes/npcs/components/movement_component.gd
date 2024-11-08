extends Node2D
class_name MovementComponent

#@export var
signal finished_moving

func move():
	# Could fly to a point of interest
	fly_towards_player()

func fly_towards_player():
	owner.change_state("move")
	#finished_moving.emit()
