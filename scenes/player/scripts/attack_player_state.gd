extends BasePlayerState
signal attack_finished

@export var attack_hitbox: AttackHitboxComponent

var finished = false
func enter(owner: CharacterBody2D, previous_state: Node, previous_state_str: String):
	finished = false
	owner.animation_player.play("melee")
	owner.animation_player.speed_scale = 0.6
	await owner.animation_player.animation_finished
	attack_hitbox.apply_damage(1)
	finished = true
	attack_finished.emit()

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	if finished: return "idle"
	return ""
