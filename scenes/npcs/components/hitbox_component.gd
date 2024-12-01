extends Area2D

@export var is_player = false
@export var health_component: HealthComponent
const ENEMY_LAYER = 4
const PLAYER_LAYER = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(health_component)
	if is_player:
		set_collision_layer_value(PLAYER_LAYER, true)
	else:
		set_collision_layer_value(ENEMY_LAYER, true)

func get_hit(d: float):
	health_component.take_damage(d)
