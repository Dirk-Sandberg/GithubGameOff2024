extends Node2D


signal turn_finished
signal turn_started

@export var movement_state_node: EnemyState
@export var attacking_state_node: EnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(movement_state_node)
	assert(attacking_state_node)
	movement_state_node.finished_moving.connect(on_finished_moving)
	attacking_state_node.finished_attacking.connect(on_finished_attacking)

func on_finished_moving():
	owner.change_state("attack")
	#attacking_node.attack()

func on_finished_attacking():
	turn_finished.emit()
	
func take_turn():
	#movement_node.move()
	owner.change_state("move")
	await movement_state_node.finished_moving
	#await movement_node.finished_moving
