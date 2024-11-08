extends Camera2D

@onready var player = get_tree().get_first_node_in_group("player")

var lerp_speed = 10
var lerp_target: Node2D

func _ready() -> void:
	TurnManager.new_combatant.connect(on_new_combatant)
	lerp_target = player

func on_new_combatant(node: Node2D):
	lerp_target = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = lerp(global_position, lerp_target.global_position, 1-exp(-delta*lerp_speed))
