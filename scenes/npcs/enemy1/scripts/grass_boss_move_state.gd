extends BaseEnemyState
signal finished_moving
var move_lerp_speed = 2.0

@onready var player = get_tree().get_first_node_in_group("player")
func enter(owner: Node2D, previous_state: Node):
	await face_player()
	await walk_towards_player()
	finished_moving.emit()

func face_player():
	if player.global_position.x < owner.global_position.x:
		owner.animation_player.play("face_left_from_right")
		await owner.animation_player.animation_finished
		owner.sprite_2d.flip_h = true

	elif player.global_position.x > owner.global_position.x:
		owner.animation_player.play("face_right_from_left")
		await owner.animation_player.animation_finished
		owner.sprite_2d.flip_h = false

func walk_towards_player():
	var desired_distance_from_player = 20
	var target_pos = Vector2(
		player.global_position.x + desired_distance_from_player,
		player.global_position.y
	)
	var tween = create_tween()
	tween.tween_property(owner, "global_position", target_pos, 1.5)
	owner.animation_player.play("walk")
	await tween.finished

func exit(owner: Node2D):
	pass

func physics_process(owner: Node2D, delta: float) -> String:
	return ""
