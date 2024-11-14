extends Sprite2D
class_name PlayerGhost

@onready var player: Player = get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.get_node("TurnComponent").turn_finished.connect(on_turn_finished)

func on_turn_finished():
	queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("movement_reset"):
		player.global_position = global_position + Vector2(-9, 15)
		player.reset_movement()
		hide()
