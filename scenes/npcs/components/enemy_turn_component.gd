extends Node2D


signal turn_finished
signal turn_started

@export var movement_node: MovementComponent
@export var attacking_node: AttackingComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movement_node.finished_moving.connect(on_finished_moving)
	attacking_node.finished_attacking.connect(on_finished_attacking)

func on_finished_moving():
	attacking_node.attack()

func on_finished_attacking():
	turn_finished.emit()
	
func take_turn():
	movement_node.move()
	await movement_node.finished_moving
