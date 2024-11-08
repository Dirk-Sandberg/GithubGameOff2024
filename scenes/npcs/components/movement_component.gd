extends Node2D
class_name MovementComponent

signal finished_moving

func move():
	owner.global_position += Vector2.ONE*10
	finished_moving.emit()
