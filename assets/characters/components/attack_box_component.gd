extends Area2D
class_name AttackHitboxComponent

@export var is_player_attack = false

const ENEMY_LAYER = 4
const PLAYER_LAYER = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_player_attack:
		set_collision_mask_value(ENEMY_LAYER, true)
	else:
		set_collision_mask_value(PLAYER_LAYER, true)

func apply_damage(damage: float):
	for area in get_overlapping_areas():
		if area.has_method("get_hit"):
			area.get_hit(damage)
