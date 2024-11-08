extends Camera2D

signal finished_lerping

@onready var player = get_tree().get_first_node_in_group("player")

var lerp_speed = 7
var lerp_target: Node2D
var awaiting_lerp_finished = false

func _ready() -> void:
	TurnManager.new_combatant.connect(on_new_combatant)
	lerp_target = player

func on_new_combatant(node: Node2D):
	lerp_target = node
	awaiting_lerp_finished = true

func _process(delta: float) -> void:
	global_position = lerp(global_position, lerp_target.global_position, 1-exp(-delta*lerp_speed))
	if awaiting_lerp_finished:
		if global_position.is_equal_approx(lerp_target.global_position):
			awaiting_lerp_finished = false
			finished_lerping.emit()
			
