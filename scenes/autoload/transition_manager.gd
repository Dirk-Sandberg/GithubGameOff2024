extends Node

signal changed_scene

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

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

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if get_tree().paused else Input.MOUSE_MODE_HIDDEN
