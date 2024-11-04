extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = randf_range(0.23, 0.28)
