extends BaseEnemyState
signal finished_moving
var move_lerp_speed = 2.0

@onready var player = get_tree().get_first_node_in_group("player")
func enter(owner: Node2D, previous_state: Node):
	await walk_towards_player()
	finished_moving.emit()

func face_towards(target_pos):
	var target_is_left = target_pos.x < owner.global_position.x
	print("target is to the left? ", target_is_left, " and flip_h is ", owner.sprite_2d.flip_h)
	print("")
	if target_is_left and not owner.sprite_2d.flip_h:# and not flip_h?
		owner.animation_player.play("face_left_from_right")
		await owner.animation_player.animation_finished
	elif target_is_left and owner.sprite_2d.flip_h:# and not flip_h?
		pass
	elif not target_is_left and owner.sprite_2d.flip_h:
		#owner.animation_player.play("face_right_from_left")
		owner.animation_player.play("face_left_from_right")
		await owner.animation_player.animation_finished
	else:
		pass

	# Flip sprite if necessary
	await get_tree().process_frame
	#var player = get_tree().get_first_node_in_group("player")
	if target_pos.x < owner.global_position.x:
		owner.sprite_2d.flip_h = true
	elif target_pos.x > owner.global_position.x:
		owner.sprite_2d.flip_h = false

#func walk_towards_player():
	#var desired_distance_from_player = 20
	#var target_pos = Vector2(
		#player.global_position.x + desired_distance_from_player,
		#player.global_position.y
	#)
#
	#await face_player()
	#
	#var tween = create_tween()
	#tween.tween_property(owner, "global_position", target_pos, 1.5)
#
	#owner.animation_player.play("walk")
	#await get_tree().process_frame
	#var player = get_tree().get_first_node_in_group("player")
	#if player.global_position.x < owner.global_position.x:
		#owner.sprite_2d.flip_h = true
	#elif player.global_position.x > owner.global_position.x:
		#owner.sprite_2d.flip_h = false
	#await tween.finished

func walk_towards_player():
	var desired_distance_from_player = 20
	var target_pos = Vector2(
		player.global_position.x + desired_distance_from_player,
		player.global_position.y
	)

	# Walk towards target pos
	await face_towards(target_pos)
	var tween = create_tween()
	tween.tween_property(owner, "global_position", target_pos, 1.5)
	owner.animation_player.play("walk")
	await tween.finished

	# Face player animation
	await face_towards(player.global_position)

	## Flip sprite if necessary
	#await get_tree().process_frame
	#var player = get_tree().get_first_node_in_group("player")
	#if player.global_position.x < owner.global_position.x:
		#owner.sprite_2d.flip_h = true
	#elif player.global_position.x > owner.global_position.x:
		#owner.sprite_2d.flip_h = false


func exit(owner: Node2D):
	pass

func physics_process(owner: Node2D, delta: float) -> String:
	return ""
