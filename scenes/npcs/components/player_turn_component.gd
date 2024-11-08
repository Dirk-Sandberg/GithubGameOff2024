extends Node2D

signal turn_finished
signal turn_started

#@export var owner_state_machine: Node
#@export var attack_state_component: Node
@export var action_wheel_component: Node

var can_move = true
var can_attack = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_wheel_component.turn_ended.connect(on_end_turn)

func on_end_turn():
	turn_finished.emit()

func take_turn():
	turn_started.emit()
	#owner_state_machine.change_state("attack")
	#await attack_state_component.attack_finished
	#turn_finished.emit()
