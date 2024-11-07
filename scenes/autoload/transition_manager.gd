extends Node

signal changed_scene

func change_scene(node: PackedScene):
	var player_pos = get_tree().get_first_node_in_group("player").get_global_transform_with_canvas()
	var spawn_pos = player_pos.get_origin()
	%ColorRect.position = spawn_pos - 180*Vector2.ONE

	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	#await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_packed(node)
	$AnimationPlayer.play_backwards("fade_in")
	changed_scene.emit()
